// import 'package:flutter/material.dart';

// List categories = [
//   {"name": "Mountain", "icon": Icons.terrain_rounded},
//   {"name": "Beach", "icon": Icons.beach_access_rounded},
//   {"name": "Park", "icon": Icons.park_rounded},
//   {"name": "Temple", "icon": Icons.account_balance_rounded},
//   {"name": "City", "icon": Icons.location_city_rounded},
//   {"name": "Others", "icon": Icons.widgets},
// ];

// List exploreCategories = [
//   {"name": "State", "icon": Icons.terrain_rounded},
//   {"name": "City", "icon": Icons.beach_access_rounded},
//   {"name": "Place", "icon": Icons.park_rounded},
// ];

// List populars = [
//   {
//     "image":
//         "https://upload.wikimedia.org/wikipedia/commons/e/ef/River_Swat_Pakistan_3.jpg",
//     "name": "Swat",
//     "location": "Malakand,Swat",
//     "is_favorited": false,
//     "description":
//         "Swat is a beautiful valley located in the northern region of Pakistan, in the Khyber Pakhtunkhwa province",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://i.pinimg.com/originals/f7/ff/fc/f7fffcd760a9804f8adb912956b67729.jpg",
//     "name": "Badshahi Mosque",
//     "location": "Badshahi Mosque,Lahore",
//     "is_favorited": true,
//     "description":
//         "The Badshahi Mosque is one of the most iconic landmarks of Lahore, Pakistan",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "http://t1.gstatic.com/licensed-image?q=tbn:ANd9GcSoLrnUKOeE_jGzoD7mXSa4CCNOW5bBjNttvEwnfWX-VZqyFjUgMio4V5_nh9lUgJEQ",
//     "name": "Naran",
//     "location": "Naran,Mansehra",
//     "is_favorited": true,
//     "description":
//         "Naran is a town in the Kaghan Valley of Pakistan's Khyber Pakhtunkhwa province",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/ba/c0/d8/neelum-valley.jpg?w=1200&h=1200&s=1",
//     "name": "Neelam Valley",
//     "location": "Neelam Valley,Azad Kashmir",
//     "is_favorited": false,
//     "description":
//         "Nelum Valley, also known as Neelum Valley or Neelam Valley, is a scenic valley in Azad Jammu and Kashmir, a territory administered by Pakistan",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://upload.wikimedia.org/wikipedia/commons/0/07/Rohtas_Fort_Gate.jpg",
//     "name": "Rohtas Fort",
//     "location": "Rohtas Fort, Jhelum",
//     "is_favorited": false,
//     "description":
//         "Rohtas Fort is a historic fortress located near the city of Jhelum in Pakistan's Punjab province",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://zameenblog.s3.amazonaws.com/blog/wp-content/uploads/2020/07/Shalimar-Gardens-Lahore-B-27-07-1024x640.jpg",
//     "name": "Shalimar Garden",
//     "location": "Shalimar Garden, Lahore",
//     "is_favorited": false,
//     "description":
//         "The Shalimar Garden is a historic garden complex located in Lahore, Pakistan.",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://upload.wikimedia.org/wikipedia/commons/4/42/Minar_e_Pakistan_2021.jpg",
//     "name": "Minar E Pakistan",
//     "location": "Minar e Pakistan, Lahore",
//     "is_favorited": false,
//     "description":
//         "Minar-e-Pakistan is a historical tower located in Iqbal Park in Lahore",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://media-cdn.tripadvisor.com/media/photo-s/05/07/4c/07/khewra-salt-mine.jpg",
//     "name": "Khewra Salt Mines",
//     "location": "Khewra, Jhelum",
//     "is_favorited": false,
//     "description":
//         "Khewra is a small town located in the Jhelum district of the Punjab province in Pakistan",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://tourism.punjab.gov.pk/system/files/styles/dp_internal_fi/private/gali2.jpg?itok=EQV4LIAN",
//     "name": "Murree",
//     "location": "Murree,Pakistan",
//     "is_favorited": true,
//     "description":
//         "Murree is a popular hill station located in the Galyat region of the Punjab province in Pakistan",
//     "rate": 4,
//     "id": "pro010",
//   },
// ];

// List countries = [
//   {
//     "image":
//         "https://media-cdn.tripadvisor.com/media/photo-s/1d/36/40/d9/rotas-fort-built-in-1642.jpg",
//     "name": "Punjab",
//     "location": "Punjab,Pakistan",
//     "is_favorited": false,
//     "description":
//         "Punjab is the largest province in Pakistan, located in the northeastern region of the country",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://thesaneadventurer.com/wp-content/uploads/2021/03/IMG-20201207-WA0016.jpg",
//     "name": "Sindh",
//     "location": "Sindh,Pakistan",
//     "is_favorited": false,
//     "description":
//         "Sindh is a province located in the southeastern region of Pakistan. It is the second-largest province in terms of population and is known for its rich history, culture, and natural beauty",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://media.istockphoto.com/id/1170068870/photo/volcanic-rock-formation-in-the-balochistan.jpg?s=612x612&w=0&k=20&c=rDMjQ0Mt_seSglZEAHHRHj2zrKZOVDNdtUbFgHmHY6M=",
//     "name": "Baluchistan",
//     "location": "Baluchistan,Pakistan",
//     "is_favorited": false,
//     "description":
//         "Balochistan is the largest province in Pakistan, located in the southwestern region of the country. It is known for its rugged terrain, diverse cultures, and natural resources",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://www.travelgirls.pk/wp-content/uploads/2020/05/Thandyani-640x400.jpg",
//     "name": "Khyber Pakhtunkhwa",
//     "location": "Khyber Pakhtunkhwa,Pakistan",
//     "is_favorited": false,
//     "description":
//         "Khyber Pakhtunkhwa is a province located in the northwestern region of Pakistan",
//     "rate": 4,
//     "id": "pro010",
//   },
//   {
//     "image":
//         "https://thediplomat.com/wp-content/uploads/2022/07/sizes/td-story-s-2/thediplomat_2022-07-12-115130.jpg",
//     "name": "Gilgit-Baltistan",
//     "location": "Gilgit-Baltistan,Pakistan",
//     "is_favorited": false,
//     "description":
//         "Gilgit-Baltistan is a region located in the northernmost part of Pakistan",
//     "rate": 4,
//     "id": "pro010",
//   },
// ];
