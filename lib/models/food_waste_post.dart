

class FoodWastePost {
  final String date;
  final String photoURL;
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost({required this.date, required this.photoURL, required this.quantity, required this.latitude, required this.longitude});

  factory FoodWastePost.fromMap(doc) {
    return FoodWastePost(
      date: doc['date'],
      photoURL: doc['photoURL'],
      quantity: doc['quantity'].toInt(),
      latitude: doc['latitude'].toDouble(),
      longitude: doc['longitude'].toDouble()
    );
  }

}