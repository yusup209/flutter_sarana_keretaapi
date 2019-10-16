import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage{
  File image;

  Future getImageFromGalery() async{
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future uploadImage(BuildContext context, filename) async{
    // String filename = basename(this.image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(this.image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    return "Gambar berhasil diupload!";
  }
}