import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:wallify/views/screens/search.dart';

class searchBar extends StatelessWidget {
  searchBar({super.key});
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 179, 178, 176),
        border: Border.all(color: const Color.fromARGB(71, 0, 0, 0)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration( 
                hintText: "Search Wallpapers",
               errorBorder: InputBorder.none,
               disabledBorder:InputBorder.none, 
               enabledBorder:InputBorder.none, 
               focusedErrorBorder:InputBorder.none, 
               focusedBorder: InputBorder.none,
               border:InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap:(){
              Navigator.push(
                context, MaterialPageRoute(builder: (context)=>
                SearchScreen(query:_searchController.text)));
            },
            child:Icon(Icons.search)),
        ],
      ),
    );
  }
}