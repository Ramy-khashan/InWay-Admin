import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../core/validation/validation.dart';
import 'adding_category_state.dart'; 
class AddCategoryController extends Cubit<AddCategoryState> {
  AddCategoryController() : super(InitialState());
  static AddCategoryController get(cnt) => BlocProvider.of(cnt);
  Validation validation = Validation();
  TextEditingController categoryNameController = TextEditingController();
  bool load = false;
  bool isStart = false;
  File? imageFile;
  String? img;
  bool isLoading = false;
  String? imageName;
  FirebaseStorage? storage;
  XFile? file;
  final picker = ImagePicker();
  uploadCatImage(context) async {
    isStart = true;
    emit(AddingImageCatUrlState());
    await picker.pickImage(source: ImageSource.gallery).then((value) async {
      file = value;

      int ranNum = math.Random().nextInt(10000000);
      imageName = path.basename(value!.path) + ranNum.toString();
      imageFile = File(value.path);
      isStart = false;
      emit(AddingImageCatUrlState());
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  addingCat() async {
    if (imageFile == null) {
      imageFile = null;
      Fluttertoast.showToast(msg: "Something went wrong, try again.");
    } else {
      load = true;
      emit(AddingCategoryState());
      var ref = FirebaseStorage.instance.ref("CategoryImage/$imageName");
      log("Enter2");
      await ref.putFile(
        File(file!.path),
      );
      await ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance.collection("categories").add({
          "category_img": value,
          "category_name": categoryNameController.text
        }).then((value) {
          load = false;
          Fluttertoast.showToast(msg: "Adding Success");
          img = null;
          categoryNameController.clear();
          imageFile = null;
          emit(AddingCategoryState());
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(msg: "Something went wrong, try again.");
        });
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: "Something went wrong with image, try again.");
      });
    }
  }
}
