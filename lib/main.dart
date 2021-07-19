import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydro Safe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Color(0xFFFEF9EB),
      ),
        home:HomeScreen(),
    );

  }
}
class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
   File _image;
  //function to get image from the camera
  _imageFromCamera() async{
    PickedFile? image = await ImagePicker().getImage(source: ImageSource.camera,imageQuality: 50);
    if(image  != null){
      setState(() {
        _image = File(image.path);
      });
    }
  }
  //function to get image from the gallery
  _imageFromGallery() async{
    PickedFile? image = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
    if(image  != null){
      setState(() {
        _image = File(image.path);
      });
    }
  }
  //function to let use choose what to use
  void _showPicker(context){
    showModalBottomSheet(context: context, builder:(BuildContext bc){
      return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galllery'),
                onTap: (){
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: (){
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
      );

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
        title: Text('HYDRO SAFE',
        style: TextStyle(
          letterSpacing: 2,
          fontWeight: FontWeight.w900,
        ),),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.blue,
                    height: 58.0,
                    width: 388.0,
                    child: Text('Select an image',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                  ),
                ),
              ),

            ],
          ),
          Row(
           children: [
             SizedBox(
               height: 20.0,
             ),
             Container(
               margin: EdgeInsets.all(20.0),
               width: 450,
               height: 350,
               color: Colors.black26,
               child: _image != null ? Image.file(_image, fit: BoxFit.fill,) : Icon(Icons.camera_alt_outlined),
             ),
           ],
          )
        ],

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
        child: Icon(Icons.camera_alt),
      ),

    );
  }

}

