import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 25,
              ),
            ),
            SizedBox(width: 8),
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 60,
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Posts(),
    );
  }
}
