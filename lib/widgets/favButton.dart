import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/recommended_places_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ItemFavoriteButton extends StatelessWidget {
  final RecommendedPlaceModel model;

  const ItemFavoriteButton({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getFavoriteSnapshot(model.name),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final bool isFavorite = snapshot.data!.exists;
          return IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => toggleFavorite(model,isFavorite),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return IconButton(onPressed: null, icon: Icon(Icons.favorite_border));
        }
      },
    );
  }

  Stream<DocumentSnapshot> getFavoriteSnapshot(String itemName) {
    final String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(itemName)
        .snapshots();
  }

  Future<void> toggleFavorite(RecommendedPlaceModel model, bool isFavorite) async {
    final String userId = _auth.currentUser!.uid;
    final DocumentReference docRef = _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(model.name);

    if (isFavorite) {
      await docRef.delete();
    } else {
      await docRef.set(model.toMap()
      //   {
      //   'itemName': model.name,
      //   'itemLocation': model.location,
      //   'createdAt': DateTime.now().microsecondsSinceEpoch,
      // }
      );
    }
  }
}
