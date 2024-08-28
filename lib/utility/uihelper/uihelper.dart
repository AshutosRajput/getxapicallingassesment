import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{

  static heading(String text,Color color,double fontsize){
    return Text(text,style:  TextStyle(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontsize,
    ),);
  }
  static subHeading(String text,Color color){
    return Text(text,style:  TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 14,

    ),
      textAlign: TextAlign.justify,
    );
  }
  static subHeading1(String text,Color color){
    return Text(text,style:  TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 12,

    ),
   maxLines: 1,
   // overflow: TextOverflow.ellipsis
    );
  }
  static showSnackbar(BuildContext context,String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(text,style:  TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),) ));
  }
}