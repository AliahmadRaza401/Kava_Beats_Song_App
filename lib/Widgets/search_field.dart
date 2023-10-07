import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kava_beats_app/Constants/colors.dart';

Widget searchField({
  required BuildContext context,
  TextEditingController? controller,
  required var hint,
  required void Function(String)? onChanged, 
  // TextInputType? inputType,
  // dynamic obscureText,
}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return SizedBox(
    height: 48,
    width: width * 0.89,
    child: TextFormField(
      // controller: controller,
      onChanged: onChanged,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: const Icon(CupertinoIcons.search,size: 20,color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        //   borderRadius: const BorderRadius.all(Radius.circular(3)),
        // ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        //   borderRadius: const BorderRadius.all(Radius.circular(3)),
        // ),
        border: InputBorder.none,
        fillColor: primaryClr,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        hintText: "$hint",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    ),
  );
}