import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE1E6C6),
      child: const Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
