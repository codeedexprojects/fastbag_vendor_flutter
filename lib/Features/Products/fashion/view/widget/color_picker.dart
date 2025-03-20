import 'dart:convert';
import 'package:fastbag_vendor_flutter/Commons/fb_button.dart';
import 'package:fastbag_vendor_flutter/Commons/fonts.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;

class ColorPickerScreen extends StatefulWidget {
  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color selectedColor = Colors.blue;
  String colorHex = "#0000FF";
  String colorName = "Blue";

  // Fetch color name from API
  Future<void> fetchColorName(String hex) async {
    final url =
    Uri.parse("https://www.thecolorapi.com/id?hex=${hex.substring(1)}");
    try {
      final response = await http.get(url);
      if (!mounted) return; // 🔴 Prevent setState() if widget is disposed

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          colorName = data["name"]["value"] ?? "NA";
        });
      } else {
        setState(() {
          colorName = "Unknown";
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        colorName = "Unknown";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Color Picker",
          style: normalFont3(
              fontsize: 16, fontweight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                  colorHex =
                  '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                });
                fetchColorName(colorHex); // ✅ API call after color change
              },
              showLabel: false,
              enableAlpha: false,
            ),
            const SizedBox(height: 20),
            FbButton(
              onClick: () {
                Navigator.pop(
                  context,
                  ColorPickerModel(
                    colorCode: colorHex,
                    colorName: colorName,
                  ),
                );
              },
              label: "Pick",
            )
          ],
        ),
      ),
    );
  }
}
