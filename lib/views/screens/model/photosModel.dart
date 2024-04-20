class photosModel{
  String imgSrc;
  photosModel({required this.imgSrc});
    static photosModel fromAPI2App(Map<String, dynamic> photoMap){
      return photosModel(imgSrc: (photoMap["src"])['portrait']);
    }
}