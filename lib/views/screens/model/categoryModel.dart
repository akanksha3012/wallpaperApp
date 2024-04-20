class categoryModel{
  String catName;
  String catImgUrl;
  categoryModel({required this.catImgUrl, required this.catName});

  static categoryModel fromApi2App(Map<String, dynamic> category){
    return categoryModel(catImgUrl: category["imgUrl"], catName: category["CategoryName"]);
  }
}