import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(250, 30, 38, 44),
      child: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 40.0,
        ),
      )
    );
  }
}

