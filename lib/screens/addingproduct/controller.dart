import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../validation/class.dart';
import 'state.dart';

class AddProductController extends Cubit<AddProductState> {
  AddProductController() : super(InitialState());
  static AddProductController get(context) => BlocProvider.of(context);
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  Validation validation = Validation();

  String selectCat = "Select Category";
  List<String> catList = ["Select Category"];
  List<String>? images = [];
  bool isLoadingMulti = false;
  bool isupload = false;
  bool isDone = false;
  bool isLoading = false;
  File? imageFile;
  final picker = ImagePicker();
  String? imageName;
  String? image;
  XFile? file;
  uploadImage(context) {
    try {
      picker.pickImage(source: ImageSource.gallery).then((value) async {
        int ranNum = math.Random().nextInt(10000000);
        imageName = path.basename(value!.path) + ranNum.toString();
        log(imageName.toString());
        file = value;
        imageFile = File(value.path);
        emit(AddingImageUrlState());
      });
    } catch (err) {
      log(err.toString() + "loll");
    }
  }

  List<XFile>? files;
  List<File> imagesFile = [];
  uploadMultiImage() {
    isLoadingMulti = true;
    isDone = true;

    emit(AddingMultiImageUrlState());
    picker.pickMultiImage().then((value) async {
      files = value;
      for (var element in value!) {
        imagesFile.add(File(element.path));
      }
      emit(AddingMultiImageUrlState());
    }).whenComplete(() {
      isDone = false;
      isLoadingMulti = false;
      emit(AddingMultiImageUrlState());
    });
  }

  equalValue(String? newValue) {
    selectCat = newValue!;
    emit(EqualState());
  }

  getCategories() async {
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) {
      for (var element in value.docs) {
        catList.add(element.data()["category_name"]);
        emit(AddingCatState());
      }
    });
  }

  addingProduct() async {
    if (imageFile != null && imagesFile.isNotEmpty) {
      isupload = true;
      emit(UploadState());
      Reference storage =
          FirebaseStorage.instance.ref("ProductImages/$imageName");
      await storage.putFile(File(file!.path));

      await storage.getDownloadURL().then((value) {
        image = value;
        emit(AddingImageUrlState());
      }).whenComplete(() async {
        for (var element in files!) {
          int ranNum = math.Random().nextInt(10000000);
          String imageName = path.basename(element.path) + ranNum.toString();
          emit(AddingImageUrlState());
          try {
            Reference storage =
                FirebaseStorage.instance.ref("ProductImages/$imageName");
            await storage.putFile(File(element.path));
            storage.getDownloadURL().then((val) {
              images!.add(val);
            });
          } on FirebaseException catch (e) {
            Fluttertoast.showToast(msg: "Something went wrong, try again.");
            log(e.toString());
          }
        }
      }).onError((error, stackTrace) {
        isupload = false;
        emit(UploadState());
        Fluttertoast.showToast(msg: "Something went wrong, try again.");
      });

      FirebaseFirestore.instance.collection("product").add({
        "name": productNameController.text,
        "description": productDescriptionController.text,
        "image": image,
        "category": selectCat,
        "images": images,
        "productowner_id": FirebaseAuth.instance.currentUser!.uid,
        "price": productPriceController.text,
        "time": DateTime.now(),
        "product_owner": FirebaseAuth.instance.currentUser!.uid,
      }).then((value) {
        FirebaseFirestore.instance
            .collection("product")
            .doc(value.id)
            .update({"id": value.id}).whenComplete(() {
          isupload = false;
          selectCat = "Select Category";
          productDescriptionController.clear();
          productNameController.clear();
          productPriceController.clear();

          imageFile = null;
          imagesFile = [];
          emit(UploadState());

          Fluttertoast.showToast(msg: "Adding Success");
        });
      });
    }
  }
}
