import "package:flutter/material.dart";
import 'package:wallify/views/widgets/CustomAppBar.dart';
import "package:wallify/views/widgets/catBlock.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
      title: CustomAppBar(word1: "Wallpaper" , word2:"App"),
        ),

        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SearchBar()
              ),
              ListView.builder(itemBuilder: (context, index) => CatBlock())
          ],
        ),
    );
  }
}