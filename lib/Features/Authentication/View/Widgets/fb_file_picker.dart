import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FbFilePicker extends StatefulWidget {
  final Function(File?) onFilePicked;
  final String fileCategory;
  final Color? borderColor;

  const FbFilePicker(
      {super.key, required this.onFilePicked, required this.fileCategory,this.borderColor});

  @override
  FbFilePickerState createState() => FbFilePickerState();
}

class FbFilePickerState extends State<FbFilePicker> {
  File? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'], // Customize your file types
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length(); // Get file size in bytes

      if (fileSize <= 5 * 1024 * 1024) {
        // File size check (5MB max)
        setState(() {
          _selectedFile = file;
        });
        widget.onFilePicked(file); // Callback to parent with selected file
      } else {
        _showError("File size must be less than 5MB");
      }
    } else {
      _showError("No file selected or invalid file type.");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .07, vertical: screenHeight * .02),
      child: GestureDetector(
        onTap: _pickFile,
        child: Container(
          height:
              _selectedFile != null ? screenHeight * .25 : screenHeight * .18,
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor ?? Colors.white, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.fileCategory.toUpperCase(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/file_upload.svg',
                      width: 50.0, // Set desired width
                      height: 50.0, // Set desired height
                    ),
                     Text(
                      "Upload ${widget.fileCategory} Image",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      "jpg/png should be less than 5mb",
                      style: TextStyle(color: Colors.black12),
                    ),
                    if (_selectedFile != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ListTile(
                            title: Text(_selectedFile!.path.split('/').last),
                            trailing: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
