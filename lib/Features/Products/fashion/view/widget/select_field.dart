import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:flutter/material.dart';

class SelectField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final List<String> items;

  const SelectField({
    Key? key,
    required this.label,
    required this.controller,
    required this.items,
  }) : super(key: key);

  @override
  _SelectFieldState createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * .07,
        vertical: screenHeight * .01,
      ),
      child: DropdownButtonFormField<String>(
        style: normalFont4(
            fontsize: 14,
            fontweight: FontWeight.w400,
            color: Color.fromRGBO(26, 26, 26, 1)),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
            borderRadius: BorderRadius.circular(0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
            borderRadius: BorderRadius.circular(0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(240, 240, 240, 1)),
            borderRadius: BorderRadius.circular(0),
          ),
          hintText: widget.label,
          hintStyle: normalFont4(
            fontsize: 14,
            fontweight: FontWeight.w400,
            color: Color.fromRGBO(26, 26, 26, 1),
          ),
        ),
        value: selectedValue,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
            widget.controller.text = newValue ?? "";
          });
        },
      ),
    );
  }
}
