import "package:flutter/material.dart";
import "package:wallify/views/screens/control/apiOper.dart";
import "package:wallify/views/screens/model/photosModel.dart";
import 'package:wallify/views/widgets/CustomAppBar.dart';
import "package:wallify/views/widgets/catBlock.dart";
import "package:wallify/views/screens/FullScreen.dart";
import "package:wallify/views/widgets/SearchBar.dart";

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<photosModel> searchResults;
  bool isLoading = true;

getSearchResults() async{
  searchResults = await apiOperations.searchWallpapers(widget.query);
  setState(() {
    isLoading=false;
  });
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResults();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
      title: customAppBar(word1: "Wallpaper" , word2:"App"),
        ),

        body: isLoading? Center(child:CircularProgressIndicator(),): SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar(),
              ),
                SizedBox(height:10,),
                
                
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 400,
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 10,
                  ), 
                  itemCount: searchResults.length,
                  itemBuilder: ((context, index) => GridTile(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => FullScreen(
                          imgUrl:searchResults[index].imgSrc
                        )));
                      },
                                     
                  child: Hero(
                    tag: searchResults[index].imgSrc,
                    child: Container(
                      height: 800,
                      width:50,
                      decoration: 
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.amberAccent,
                      ),
                      
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          height: 800,
                          width: 50,
                          fit: BoxFit.cover,
                          searchResults[index].imgSrc),
                      ),
                    ),
                  ),
                ),
              ))),
                )
            ],
          ),
        ),
    );
  }
}