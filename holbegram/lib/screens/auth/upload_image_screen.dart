import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'methods/user_storage.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    Key? key,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);

  @override
  _AddPictureState createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void selectImageFromCamera() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? _file = await _picker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    throw 'No image selected';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 28),
          Text(
            'Holbegram',
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 50,
            ),
          ),
          SizedBox(height: 28),
          _image != null
              ? CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                )
              : const Icon(
                  Icons.account_circle,
                  size: 128,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: selectImageFromGallery,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: selectImageFromCamera,
              ),
            ],
          ),
          SizedBox(height: 28),
          ElevatedButton(
            onPressed: () async {
              if (_image != null) {
                String photoUrl = await StorageMethods().uploadImageToStorage(
                  false,
                  'profilePics',
                  _image!,
                );
                // Save the photoUrl to the user profile
                // You can also navigate to another screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile picture updated')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select an image')),
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color.fromARGB(218, 226, 37, 24),
              ),
            ),
            child: Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
