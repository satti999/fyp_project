import 'package:flutter/material.dart';

class SnackBarService{

  showSnackBar(context,text){
     var snackBar = SnackBar(
      content: Text(text.toString()),
    );
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}