import "dart:convert";

import "package:http/http.dart" as http;
import "package:wallify/views/screens/model/categoryModel.dart";
import "package:wallify/views/screens/model/photosModel.dart";

import 'dart:math';

class apiOperations{
  static List<photosModel> trendingWallpapers=[];
  static List<photosModel> searchWallpaperList=[];
  static List<categoryModel> categoryModelList=[];
  static Future<List<photosModel>> getTrendingWallpapers() async{
    
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers:{
        "Authorization": 
            "tkC9UVnciqkehAHMAm9T70L2aQEXumOT3WVjcRPMkpKLbqMgDRreKZxh"
      }).then((value){
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        List photos = jsonData['photos'];
        photos.forEach((element) {
          trendingWallpapers.add(photosModel.fromAPI2App(element));
        });
    });
    return trendingWallpapers;
  }


  static Future<List<photosModel>> searchWallpapers(String query) async{
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"), headers:{
        "Authorization": 
            "tkC9UVnciqkehAHMAm9T70L2aQEXumOT3WVjcRPMkpKLbqMgDRreKZxh"
      }).then((value){
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        List photos = jsonData['photos'];
        searchWallpaperList.clear();
        photos.forEach((element) {
          searchWallpaperList.add(photosModel.fromAPI2App(element));
        });
    });
    return searchWallpaperList;
  }
  static List<categoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    categoryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      photosModel photoModel =
          (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      categoryModelList
          .add(categoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return categoryModelList;
  }
}