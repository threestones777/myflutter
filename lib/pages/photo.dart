import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File? _imgFile; // 改为 File? 类型

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("照片"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _ImageView(_imgFile),
              ElevatedButton(
                onPressed: _takePhoto,
                child: Text("拍照"),
              ),
              ElevatedButton(
                onPressed: _openGallery,
                child: Text("选择照片"),
              ),
            ],
          ),
        ));
  }

  /*图片控件*/
  Widget _ImageView(File? imgFile) {
    if (imgFile == null) {
      return Center(
        child: Container(
          height: 200,
          child: Text("请选择图片或拍照"),
        ),
      );
    } else {
      return Image.file(
        imgFile,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  /*拍照*/
  _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imgFile = File(image.path); // 转换为 File
      });
    }
  }

  /*相册*/
  _openGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imgFile = File(image.path); // 转换为 File
      });
    }
  }
}
