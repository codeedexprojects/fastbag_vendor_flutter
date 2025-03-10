import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FbProductsFilePicker extends StatefulWidget {
  final Function(List<File>) onFilesPicked;
  final String fileCategory;

  const FbProductsFilePicker({
    super.key,
    required this.onFilesPicked,
    required this.fileCategory,
  });

  @override
  FbProductsFilePickerState createState() => FbProductsFilePickerState();
}

class FbProductsFilePickerState extends State<FbProductsFilePicker> {
  List<File> _selectedFiles = [];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,  // ✅ Ensuring multiple selection
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      List<File> selectedFiles = [];

      for (var file in result.files) {
        if (file.path != null) {
          File newFile = File(file.path!);
          int fileSize = await newFile.length();

          if (fileSize <= 5 * 1024 * 1024) { // ✅ 5MB limit
            selectedFiles.add(newFile);
          } else {
            _showError("${file.name} exceeds 5MB and was not selected.");
          }
        }
      }

      if (selectedFiles.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(selectedFiles);  // ✅ Append selected files
        });
        widget.onFilesPicked(_selectedFiles);
      }
    } else {
      _showError("No file selected or invalid file type.");
    }
  }

  void _deleteFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);  // ✅ Remove selected file
    });
    widget.onFilesPicked(_selectedFiles);
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

    return GestureDetector(
      onTap: _pickFiles,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * .85,
        height: screenHeight * .25,  // ✅ Fixed height to prevent overflow
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.2),
        ),
        child: SingleChildScrollView(  // ✅ Prevents overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upload ${widget.fileCategory} Images",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 5.0),
              const Text(
                "jpg/png should be less than 5MB",
                style: TextStyle(color: Colors.black12),
              ),
              const SizedBox(height: 10.0),
               Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(4, (index) => SvgPicture.asset(
                      'assets/icons/file_upload.svg',
                      width: 50.0,
                      height: 50.0,
                    )),
              ),
              if (_selectedFiles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: _selectedFiles.asMap().entries.map((entry) {
                      int index = entry.key;
                      File file = entry.value;
                      return ListTile(
                        title: Text(file.path.split('/').last),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteFile(index),  // ✅ Delete file on tap
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
