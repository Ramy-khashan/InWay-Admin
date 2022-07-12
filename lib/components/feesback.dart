import 'package:admin/components/button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackItem extends StatelessWidget {
  final String? id;
  final String? docId;
  final String? name;
  final String? phone;
  final String? title;
  final String? desc;
  final String? time;
  final String? date;
  final bool isAddress;
  final String? address;

  final String? feedbackType;
  const FeedBackItem(
      {Key? key,
      this.isAddress = false,
      this.address,
      this.date,
      this.docId,
      this.desc,
      this.feedbackType,
      this.id,
      this.name,
      this.phone,
      this.time,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(blurRadius: 6, spreadRadius: 2, color: Colors.grey)
          ]),
      margin: EdgeInsets.symmetric(
          vertical: size.longestSide * .012,
          horizontal: size.shortestSide * .03),
      padding: EdgeInsets.symmetric(
          vertical: size.longestSide * .02,
          horizontal: size.shortestSide * .03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.longestSide * .01,
          ),
          Align(
            alignment: Alignment.center,
            child: SelectableText(
              "$feedbackType Number : $id",
              style: TextStyle(
                  fontSize: size.shortestSide * .05,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: size.longestSide * .013,
          ),
          Text(
            "Name : $name",
            style: TextStyle(
                fontSize: size.shortestSide * .042,
                fontWeight: FontWeight.w500),
          ),
          SelectableText(
            "Phone : $phone",
            style: TextStyle(
                fontSize: size.shortestSide * .042,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Title : $title",
            style: TextStyle(
                fontSize: size.shortestSide * .042,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Description : $desc",
            style: TextStyle(
                fontSize: size.shortestSide * .042,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size.longestSide * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Time : $time",
                style: TextStyle(
                    fontSize: size.shortestSide * .042,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Date : $date",
                style: TextStyle(
                    fontSize: size.shortestSide * .042,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          isAddress
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: size.longestSide * .015),
                  child: Text(
                    "Address : $address",
                    style: TextStyle(
                        fontSize: size.shortestSide * .042,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: size.longestSide * .015,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.shortestSide * .03),
            width: double.infinity,
            child: ButtonItem(
                name: "Call",
                onPressed: () async {
                  if (await canLaunch('tel:' + phone.toString())) {
                    await launch('tel:' + phone.toString());
                  } else {
                    throw "Error occured trying to call that number.";
                  }
                }),
          )
        ],
      ),
    );
  }
}
