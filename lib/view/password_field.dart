import 'package:flutter/material.dart';
import 'package:timesheet/utils/color_resources.dart';

class PasswordField extends StatefulWidget {
  TextEditingController? controller;
  PasswordField( {Key? key,required this.controller,}) : super(key: key);
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      focusNode: textFieldFocusNode,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: "Please input value",
        filled: true, // Needed for adding a fill color
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black45, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(borderSide:  BorderSide(color: ColorResources.COLOR_PRIMARY, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        errorBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Colors.redAccent, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedErrorBorder:const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black45, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        isDense: true,  // Reduces height a bit
        border: OutlineInputBorder(
          borderSide: BorderSide.none,              // No border
          borderRadius: BorderRadius.circular(10),  // Apply corner radius
        ),
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 24),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              _obscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 24,
            ),
          ),
        ),
      )
    );
  }
}


class EditTextField extends StatefulWidget {
  TextEditingController controller;
  Icon? icon ;
  String? placeholder;
  EditTextField({Key? key ,this.icon ,required this.controller, this.placeholder }):super(key: key);
  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: widget.placeholder ??"Please input value",
        filled: true, // Needed for adding a fill color
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black45, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(borderSide:  BorderSide(color: ColorResources.COLOR_PRIMARY, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        errorBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Colors.redAccent, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedErrorBorder:const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black45, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))),
        isDense: true,  // Reduces height a bit
        border: OutlineInputBorder(
          borderSide: BorderSide.none,              // No border
          borderRadius: BorderRadius.circular(10),  // Apply corner radius
        ),
        prefixIcon: widget.icon,
      ),
    );
  }
}


class EditTextField2 extends StatefulWidget {
  TextEditingController controller;
  Icon? icon ;
  String? placeholder;
  EditTextField2({Key? key ,this.icon ,required this.controller, this.placeholder }):super(key: key);
  @override
  _EditTextFieldState2 createState() => _EditTextFieldState2();
}

class _EditTextFieldState2 extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: widget.placeholder ??"Please input value",
        filled: true, // Needed for adding a fill color
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black45, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(5))),
        focusedBorder: const OutlineInputBorder(borderSide:  BorderSide(color: ColorResources.COLOR_PRIMARY, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(5))),
        errorBorder: const OutlineInputBorder(borderSide:  BorderSide(color: Colors.redAccent, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(5))),
        focusedErrorBorder:const OutlineInputBorder(borderSide:  BorderSide(color: Colors.black45, width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(5))),
        isDense: true,  // Reduces height a bit
        border: OutlineInputBorder(
          borderSide: BorderSide.none,              // No border
          borderRadius: BorderRadius.circular(10),  // Apply corner radius
        ),
        prefixIcon: widget.icon,
      ),
    );
  }
}