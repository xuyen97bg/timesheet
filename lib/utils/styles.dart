import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timesheet/utils/color_resources.dart';

import 'dimensions.dart';

final robotoRegular = TextStyle(
  fontFamily: 'NotoSerif',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMedium = TextStyle(
  fontFamily: 'NotoSerif',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoBold = TextStyle(
  fontFamily: 'NotoSerif',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoBlack = TextStyle(
  fontFamily: 'NotoSerif',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);

const font15W600 = TextStyle(
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter');
const font15W400 = TextStyle(
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter');
const font14BlackW600 = TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  color:Colors.black
);
const font16PrimaryW600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: ColorResources.COLOR_PRIMARY);
const font16BlackW500 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
    color: Colors.black);
const font16WhiteW600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: Colors.white);
const font18WhiteW600 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: Colors.white);
const font16BlackW600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: Colors.black);
const font16SecondaryW600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: ColorResources.COLOR_GRAY);

Expanded layoutEditTextNumber(
    {required String label, required TextEditingController controller}) =>
    Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 6),
                child: Text(label, style: font16BlackW600)),
            Container(
              color: Colors.white,
              height: 40,
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                        gapPadding: 0),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                        gapPadding: 0)),
                controller: controller,
                style: font15W400,
              ),
            ),
          ],
        ));

InputDecoration borderDropbox() => InputDecoration(
      contentPadding: const EdgeInsets.only(left: 10, right: 10),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.black26, width: 1, style: BorderStyle.solid)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.black26, width: 1, style: BorderStyle.solid)),
    );

Container textArea( {required TextEditingController controller, String? placeholder})=> Container(
  color: Colors.white,
  child: TextFormField(
    maxLines: 5,
    decoration: InputDecoration(
      hintText: placeholder,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(width: 1, color: Colors.black26),
            borderRadius: BorderRadius.circular(10),
            gapPadding: 0),
        focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(width: 1, color: Colors.black26),
            borderRadius: BorderRadius.circular(10),
            gapPadding: 0)),
    controller: controller,
  ),
);
