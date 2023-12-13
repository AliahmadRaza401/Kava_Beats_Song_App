import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customInputField(
  TextEditingController controller,
  FocusNode focusNode,
  String label,
  String? Function(String?)? validator, {
  bool? isPassword,
  Function()? onPressed,
  Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    // autocorrect: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    focusNode: focusNode,
    obscureText: isPassword == null ? false : isPassword,
    // Set obscureText to true for password fields
    style: TextStyle(color: Colors.white, fontSize: 15),
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.white : Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusNode.hasFocus ? Colors.white : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusNode.hasFocus ? Colors.white : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword == null
            ? SizedBox()
            : IconButton(
                icon: Icon(
                  isPassword == false ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: onPressed,
              )),
  );
}

Widget textField({
  required BuildContext context,
  required var hint,
  IconData? icon,
  required var lable,
  required TextEditingController controller,
  TextInputType? inputType,
  dynamic obscureText,
}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      height: 50,
      width: width * 0.85,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field is required";
          } else {
            return null;
          }
        },
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          labelText: "$lable",
          labelStyle: TextStyle(color: Colors.white, fontSize: 14),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          hintText: "$hint",
          hintStyle: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    ),
  );
}

bool isVisible = true;

class passwordfield extends StatefulWidget {
  passwordfield(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.lable})
      : super(key: key);
  TextEditingController? controller;
  var hint;
  var lable;

  @override
  State<passwordfield> createState() => _passwordfieldState();
}

class _passwordfieldState extends State<passwordfield> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 50,
        width: width * 0.85,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return "Field is required";
          //   } else {
          //     return null;
          //   }
          // },
          style: TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Icon(
              CupertinoIcons.lock,
              color: Colors.white,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                  print(isVisible);
                });
              },
              icon: Icon(
                isVisible == false ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
                size: 20,
              ),
            ),
            labelText: "${widget.lable}",
            labelStyle: TextStyle(color: Colors.white, fontSize: 14),
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            hintText: "${widget.hint}",
            hintStyle: TextStyle(fontSize: 14, color: Colors.white),
          ),
          obscureText: isVisible,
        ),
      ),
    );
  }
}

//============================ Conform password ==================

bool isConfirmVisible = true;

class cpasswordfield extends StatefulWidget {
  cpasswordfield({
    Key? key,
    required this.controller,
  }) : super(key: key);
  TextEditingController? controller;
  @override
  State<cpasswordfield> createState() => _cpasswordfieldState();
}

class _cpasswordfieldState extends State<cpasswordfield> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 45,
        width: width * 0.8,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return "Field is required";
          //   } else {
          //     return null;
          //   }
          // },
          style: TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Icon(
              CupertinoIcons.lock,
              color: Colors.white,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isConfirmVisible = !isConfirmVisible;
                  print(isConfirmVisible);
                });
              },
              icon: Icon(
                isConfirmVisible == false
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.white,
                size: 20,
              ),
            ),
            labelText: "Confirm Password",
            labelStyle: TextStyle(color: Colors.white, fontSize: 14),
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            hintText: "Confirm Password",
            hintStyle: TextStyle(fontSize: 14, color: Colors.white),
          ),
          obscureText: isConfirmVisible,
        ),
      ),
    );
  }
}
