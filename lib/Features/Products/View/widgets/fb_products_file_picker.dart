import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastbag_vendor_flutter/Commons/placeholder.dart';
import 'package:fastbag_vendor_flutter/Features/Products/fashion/model/fashion_item_model.dart'
    as itemModel;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FbProductsFilePicker extends StatefulWidget {
  final Function(List<File>) onFilesPicked;
  final String fileCategory;
  final List<File>? initialFiles;
  final List<itemModel.Images> images;
  final Function(int index)? onImageRemove;

  const FbProductsFilePicker({
    super.key,
    required this.onFilesPicked,
    required this.fileCategory,
    this.images = const [],
    this.initialFiles,
    this.onImageRemove,
  });

  @override
  FbProductsFilePickerState createState() => FbProductsFilePickerState();
}

class FbProductsFilePickerState extends State<FbProductsFilePicker> {
  late List<File> _selectedFiles;

  @override
  void initState() {
    super.initState();
    _selectedFiles = widget.initialFiles ?? [];
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      List<File> tempFiles = [];

      for (var file in result.files) {
        if (file.path != null) {
          File newFile = File(file.path!);
          int fileSize = await newFile.length();

          if (fileSize <= 5 * 1024 * 1024) {
            tempFiles.add(newFile);
          } else {
            _showError("${file.name} exceeds 5MB and was not selected.");
          }
        }
      }

      if (tempFiles.isNotEmpty) {
        setState(() {
          _selectedFiles = List.from(
              _selectedFiles.toSet()..addAll(tempFiles)); // Prevent duplicates
        });
        widget.onFilesPicked(_selectedFiles);
      }
    } else {
      _showError("No file selected or invalid file type.");
    }
  }

  void _deleteFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
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
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: _pickFiles,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        height: screenHeight * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.2),
        ),
        child: SingleChildScrollView(
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
                children: [
                  // Display Existing Network Images (widget.images)
                  ...List.generate(widget.images.length, (index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                              imageUrl: widget.images[index].imageUrl ?? '',
                              placeholder: (context, url) => Image.asset(
                                PlaceholderImage.placeholderimage,
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: const Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              if (widget.onImageRemove != null) {
                                widget.onImageRemove!(index);
                              }
                            },
                          ),
                        )
                      ],
                    );
                  }),

                  // Display Selected Local Images (_selectedFiles)
                  ...List.generate(_selectedFiles.length, (index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: Image.file(
                              _selectedFiles[index],
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: const Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () => _deleteFile(index),
                          ),
                        )
                      ],
                    );
                  }),

                  // Upload Icon (Only Show If No Images Are Present)
                  if (_selectedFiles.isEmpty && widget.images.isEmpty)
                    SvgPicture.asset(
                      'assets/icons/file_upload.svg',
                      width: 50.0,
                      height: 50.0,
                    ),
                ],
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
                          onPressed: () => _deleteFile(index),
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
