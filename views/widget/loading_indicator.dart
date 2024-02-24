import 'package:flutter/material.dart';

import '../../consts/colors.dart';

Widget loadingIndicator({circleColor=purpleColor}){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),
  );
}