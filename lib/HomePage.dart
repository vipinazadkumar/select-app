import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  String imagePath="";
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker & Image Croper",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue.shade700,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if(pickedFile != null){
                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                        sourcePath: pickedFile.path,
                        uiSettings: [
                          AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.square,
                              //CropAspectRatioPresetCustom(),
                            ],
                          ),
                          IOSUiSettings(
                            title: 'Cropper',
                            aspectRatioPresets: [
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.square,
                            //  CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
                            ],
                          ),
                          WebUiSettings(
                            context: context,
                          ),
                        ],
                      );
                      if(croppedFile != null){
                        setState(() {
                          imagePath = croppedFile.path;
                        });
                      }

                    }
                  },
                  child: Text('Select Image from Device',style: TextStyle(color: Colors.white),),

                ),
              ),
              imagePath !=""
              ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Image.file(File(imagePath)),
              )
                  :Container(),
            ],
          ),
        )
    );
  }

}