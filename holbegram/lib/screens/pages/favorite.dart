import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Holbegram',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No posts yet'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final DocumentSnapshot post;

  PostCard({required this.post});

  void saveToFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('favorites').add({
        'userId': user.uid,
        'imageUrl': post['postUrl'],
        'postId': post.id,
        'savedAt': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Image.network(post['postUrl']),
          ListTile(
            title: Text(post['username']),
            trailing: IconButton(
              icon: Icon(Icons.bookmark_border),
              onPressed: saveToFavorites,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post['caption']),
          ),
        ],
      ),
    );
  }
}
