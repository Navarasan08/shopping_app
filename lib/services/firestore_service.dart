import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/models/product.dart';

class FirestoreService {
   Future<DocumentReference> addProduct() {
    return FirebaseFirestore.instance.collection('products').add({
      'name': "Gaming Console",
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'price': 432.90,
      'description': "A PS4 Gaming Console",
      'status': "1",
      'mdate': "20-01-2021",
      'color': "Black",
      'discountedPrice': null,
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwoqnpterGzAhF9TT7sOla8bNPcHqn5oibfg&usqp=CAU",
      'category_name': "Gaming",
      'category_id': "4",
    });
  }

  Future<DocumentReference> addCart() {
    User user = FirebaseAuth.instance.currentUser;
    // FirebaseFirestore.instance.collection('users').add({
    //   "displayName": user.displayName,
    //   "dob": "03-12-1996",
    //   "emil": user.email,
    //   "type": "admin",
    // });
    return FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .set({
      'name': "LG TV (32)",
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'price': 222.90,
      'description': "A smart TV with Video Games",
      'status': "1",
      'mdate': "20-01-2021",
      'color': "Black",
      'discountedPrice': null,
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwoqnpterGzAhF9TT7sOla8bNPcHqn5oibfg&usqp=CAU",
      'category_name': "TV",
      'category_id': "2",
      'quantity': 1,
    });
  }

  Future<List> getData() async {
    List<Product> _products = [];
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('products').get();

    data.docs.forEach((document) {
      _products.add(Product.fromJson(document.data()));
    });

    return _products;
  }

  updateCart() {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc("3GQGKmiK6o0QkYPHDF0N")
        .update({
      "quantity": 3,
    });
  }

}