import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

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
              print("SEARCHING...");
            },
            child:Icon(Icons.search)),
        ],
      ),
    );
  }
}