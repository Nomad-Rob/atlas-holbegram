import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import '../pages/methods/post_storage.dart';
import '../home.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _image;
  final TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;

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

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await PostStorage().uploadPost(
        _captionController.text,
        uid,
        username,
        profImage,
        _image!,
      );

      if (res == "Ok") {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Posted successfully!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res)),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () => postImage(user.uid, user.displayName ?? 'User', user.photoURL ?? ''),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading) CircularProgressIndicator(),
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
              : CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage('../../assets/images/logo.png'),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _captionController,
              decoration: InputDecoration(hintText: 'Enter caption'),
            ),
          ),
          SizedBox(height: 28),
          ElevatedButton(
            onPressed: () => postImage(user.uid, user.displayName ?? 'User', user.photoURL ?? ''),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color.fromARGB(218, 226, 37, 24),
              ),
            ),
            child: Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
