import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

class addQuote extends StatefulWidget {
  String imgUrl;
  addQuote({super.key, required this.imgUrl});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  State<addQuote> createState() => _addQuoteState();
}

class _addQuoteState extends State<addQuote> {

  @override
  void initState() {
    super.initState();
  }
  final TextEditingController _quoteController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  String _quote='';
  Future<void> setWallpaper(BuildContext context) async {
    setState(() {
    _quote = _quoteController.text; // Assign the value of _quote
  });
  screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));
  }

saveImage(Uint8List bytes) async {
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = "screenshot_$time";
  
  // Request storage permission
  await Permission.storage.request();

  // Check if permission is granted
  if (await Permission.storage.isGranted) {
    // Permission is granted, save the image
    await ImageGallerySaver.saveImage(bytes, name: name);
  } else {
    // Permission is not granted, handle accordingly
    // You may want to show a message to the user
    print('Permission not granted');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: 
          ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                await Future.delayed(Duration(milliseconds: 100));
                await setWallpaper(context);
                print("set wallpaper");
              },
              child: Text("Set Wallpaper")
          ),
              
          
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body :Screenshot(
        controller: screenshotController,
          child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.92,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imgUrl), fit: BoxFit.cover))),
              Container(
                height: MediaQuery.of(context).size.height*0.92,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), 
                color: Colors.black26),
              ),
              Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _quoteController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add your quote...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            ]
          )
                ),
        ),
      
    );
  }
}

    