import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(ImagePickerApp());

class ImagePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePickerPage(),
    );
  }
}

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length: " + imageFileList!.length.toString());
    setState(() {});
  }

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Image Picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 300,

            child: PageView.builder(
              controller: controller,
              itemCount: imageFileList!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                    child: Image.file(
                      File(imageFileList![index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              onPageChanged: (page) {
                print("Page changed to: $page");
              },
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: SizedBox(
              width: 150,
              height: 40,
              child: MaterialButton(
                color: Colors.grey,
                child: const Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  selectImages();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
