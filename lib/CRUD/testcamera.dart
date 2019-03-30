import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';






class CameraFeature extends StatefulWidget {
  @override
  _CameraFeatureState createState() => _CameraFeatureState();
}

class _CameraFeatureState extends State<CameraFeature> {
  File _image;
//  File get image => null;

  Future getCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future openGallery() async {
    var gallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = gallery;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Image Picker Exmaple'),
      ),
      body: Center(
        child: SizedBox(
          child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: _optionsDialogBox,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> _optionsDialogBox() {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Take a picture'),
                    onTap: getCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Select from gallery'),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
