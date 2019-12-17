import 'dart:io';

import 'package:flutter/cupertino.dart';

class UploadImageModel with ChangeNotifier{
  var _imageFile;

   get getImageFile => _imageFile;

  set setImageFile(var file){
    _imageFile = file;
    notifyListeners();
  }



}