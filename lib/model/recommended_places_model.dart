import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecommendedPlaceModel {
  final String image;
  final dynamic rating;
  final String location;
  final String name;
  final String price;
  final String distance;
  final dynamic time;
  final String slocation;
  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.location,
    required this.name,
    required this.price,
    required this.distance,
    required this.time,
    required this.slocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'rating': rating,
      'location': location,
      'name': name,
      'price': price,
      'distance': distance,
      'time': time,
      'slocation': slocation,
    };
  }

  factory RecommendedPlaceModel.fromMap(Map<String, dynamic> map) {
    return RecommendedPlaceModel(
      image: map['image'] as String,
      rating: map['rating'] as dynamic,
      location: map['location'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      distance: map['distance'] as String,
      time: map['time'] as dynamic,
      slocation: map['slocation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecommendedPlaceModel.fromJson(String source) =>
      RecommendedPlaceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

List<RecommendedPlaceModel> recommendedPlacesList = [
  RecommendedPlaceModel(
      image: "assets/places/place10.jpg",
      rating: "3.3",
      location: "Naran,KPK",
      name: "Naran",
      price: "15,000",
      distance: "385km",
      time: "4hr 33min",
      slocation: "KPK"),
  RecommendedPlaceModel(
      image: "assets/places/place8.jpg",
      rating: "4",
      location: "Murree, Islamabad",
      name: "Murree",
      price: "10,000",
      distance: "200km",
      time: "2hr 30min",
      slocation: "Islamabad"),
  RecommendedPlaceModel(
      image: "assets/places/place9.jpg",
      rating: "3",
      location: "Rohtas Fort,Jhelum",
      name: "Rohtas Fort",
      price: "5,000",
      distance: "20km",
      time: "30min",
      slocation: "Jhelum"),
  RecommendedPlaceModel(
      image: "assets/places/place5.jpg",
      rating: "2",
      location: "Daman-e-Koh, Islamabad",
      name: "Daman-e-Koh",
      price: "7,000",
      distance: "390km",
      time: "5hr 33min",
      slocation: "Islamabad"),
  RecommendedPlaceModel(
      image: "assets/places/place4.jpg",
      rating: "4.4",
      location: "Minar e Pakistan,Lahore",
      name: "Minar e Pakistan",
      price: "8,000",
      distance: "370km",
      time: "4hr 30min",
      slocation: "Lahore"),
  RecommendedPlaceModel(
      image: "assets/places/place2.jpg",
      rating: "2",
      location: "Neelum Valley,Muzaffarabad",
      name: "Neelum Valley",
      price: "14,000",
      distance: "400km",
      time: "6hr 40min",
      slocation: "Muzaffarabad"),
  RecommendedPlaceModel(
      image: "assets/places/place1.jpg",
      rating: "5",
      location: "Swat,Khyber Pakhtunkhwa",
      name: "Swat",
      price: "16,000",
      distance: "450km",
      time: "7hr 33min",
      slocation: "KPK"),
  //new data
  RecommendedPlaceModel(
      image: "assets/images/skardu.jpeg",
      rating: "3.3",
      location: "Skardu,Gilgit",
      name: "Skardu",
      price: "35,000",
      distance: "500km",
      time: "12hr 33min",
      slocation: "Gilgit"),
  RecommendedPlaceModel(
      image: "assets/images/shogran.jpeg",
      rating: "3.3",
      location: "Shogran,Kagan",
      name: "Shogran",
      price: "15,000",
      distance: "850km",
      time: "9hr 33min",
      slocation: "Kagan"),
  RecommendedPlaceModel(
      image: "assets/images/naltar.jpeg",
      rating: "3.3",
      location: "Naltar,Gilgit",
      name: "Naltar",
      price: "25,000",
      distance: "850km",
      time: "11hr 33min",
      slocation: "Gilgit"),
   RecommendedPlaceModel(
      image: "assets/images/ranikot.jpeg",
      rating: "3.3",
      location: "Ranikot,Sindh",
      name: "Ranikot",
      price: "10,000",
      distance: "600km",
      time: "7hr 33min",
      slocation: "Sindh"),
   RecommendedPlaceModel(
      image: "assets/images/fairy.jpeg",
      rating: "3.3",
      location: "Fairy,Gilgit",
      name: "Fairy",
      price: "20,000",
      distance: "800km",
      time: "12hr 33min",
      slocation: "Gilgit"),
   RecommendedPlaceModel(
      image: "assets/images/chitral.jpeg",
      rating: "3.3",
      location: "Chitral,KPK",
      name: "Chitral",
      price: "40,000",
      distance: "1005km",
      time: "11hr 33min",
      slocation: "KPK"),
   RecommendedPlaceModel(
      image: "assets/images/baltit.jpeg",
      rating: "3.3",
      location: "Baltit,Karimabad",
      name: "Baltit",
      price: "25,000",
      distance: "685km",
      time: "10hr 33min",
      slocation: "Karimabad"),
   RecommendedPlaceModel(
      image: "assets/images/bahawalpur.jpeg",
      rating: "3.3",
      location: "Bahawalpur, Punjab",
      name: "Bahawalpur",
      price: "10,000",
      distance: "500km",
      time: "4hr 10min",
      slocation: "Punjab"),
   RecommendedPlaceModel(
      image: "assets/images/attabad.jpeg",
      rating: "3.3",
      location: "Attabad,Gilgit baltistan",
      name: "Attabad",
      price: "20,000",
      distance: "800km",
      time: "8hr 45min",
      slocation: "KPK"),
];
