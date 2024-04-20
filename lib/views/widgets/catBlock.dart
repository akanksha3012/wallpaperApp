import 'package:flutter/material.dart';
import "package:wallify/views/category.dart";

class catBlock extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  catBlock({super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
       
    return InkWell(
          onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: 
            (context)=> categoryScreen(catImgUrl: categoryImgSrc, catName: categoryName)));
          },
            
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              height:50,
              width:100,
              fit: BoxFit.cover,
              categoryImgSrc
              ),
          ),
          Container(
            height: 50,
            width:100,
            color: Colors.black26,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          ),
          Positioned(
            left: 30,
            top: 15,
            child: Text("Cars", style: TextStyle(color:Colors.white, fontWeight: FontWeight.w600)))
        ],
      ),
    ),
    );
  }
}