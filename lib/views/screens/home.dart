import "package:flutter/material.dart";
import 'package:wallify/views/screens/control/apiOper.dart';
import 'package:wallify/views/widgets/searchBar.dart';
import 'package:wallify/views/widgets/customAppBar.dart';
import "package:wallify/views/widgets/catBlock.dart";
import "package:wallify/views/screens/model/photosModel.dart";
import "package:wallify/views/screens/model/categoryModel.dart";
import "package:wallify/views/screens/FullScreen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<photosModel> trendingWallpaperList;
  late List<categoryModel> catModList;

  bool isLoading=true;

  getCatDetails() async{
    catModList= await apiOperations.getCategoriesList();
    print("Getting CAT Mod List");
    print(catModList);
    setState(() {
      catModList = catModList;
    });
  }

  getTrendingWallpapers() async{
    trendingWallpaperList = await apiOperations.getTrendingWallpapers();
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCatDetails();
    getTrendingWallpapers();
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
                child: searchBar()
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height:50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:catModList.length, itemBuilder: ((context, index) => catBlock(
                        categoryImgSrc:catModList[index].catImgUrl, 
                        categoryName:catModList[index].catName,)
                    )),
                  ),
                ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 700,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                    },                 
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 400,
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 10,
                  ), 
                  itemCount: trendingWallpaperList.length,
                  itemBuilder: ((context, index) => GridTile(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => FullScreen(
                          imgUrl:trendingWallpaperList[index].imgSrc
                        )));
                      },
                                     
                  child: Hero(
                    tag: trendingWallpaperList[index].imgSrc,
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
                          trendingWallpaperList[index].imgSrc),
                      ),
                    ),
                  ),
                ),
              ))),
          ),
              )
            ],
          ),
        ),
    );
  }
}