import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text('No images found'));
                  }
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      return Image.network(
                        post['postUrl'],
                        fit: BoxFit.cover,
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
