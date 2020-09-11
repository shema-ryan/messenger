import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File image) pickedImageFn;
  UserImagePicker(this.pickedImageFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final _picker = ImagePicker();
  File _image;
  //Helper functions
  Future<void> _pickImage() async {
    PickedFile _imageP = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 150,
        maxHeight: 150);
    setState(() {
      _image = File(_imageP.path);
    });
    widget.pickedImageFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
            onPressed: _pickImage,
            icon: Icon(
              Icons.camera,
              color: Theme.of(context).primaryColor,
            ),
            label: Text(
              'take a picture',
              style: TextStyle(color: Theme.of(context).accentColor),
            ))
      ],
    );
  }
}
