import 'package:flutter/material.dart';



responsiveAspect(MediaQueryData data) {

  double deviceHeight = data.size.height;


  if(deviceHeight <= 550){
    return 0.55;
  }else if(deviceHeight <= 900){
    return 0.80;
  }else if(deviceHeight <= 1450){
    return 1.0;
  }else{
    return 1.5;
  }

}



responsiveCount(MediaQueryData data){

  double deviceWidth = data.size.width;

  if(deviceWidth <= 550){
    return 2;
  }else if(deviceWidth <= 950){
    return 3;
  }else{
    return 4;
  }
}




