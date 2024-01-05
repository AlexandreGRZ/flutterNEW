import 'package:flutter/material.dart';

const double width = 350.0;
const double height = 50.0;
const double loginAlign = -1;
const double signInAlign = 1;
Color? selectedColor = Colors.green[700];
Color? normalColor = Colors.grey[400];

class toggleBtnAccount extends StatefulWidget {
  final VoidCallback voidCallback;
  toggleBtnAccount({
    required this.voidCallback,
    super.key,
  });

  @override
  State<toggleBtnAccount> createState() => _toggleBtnAccountState(voidCallback);
}

class _toggleBtnAccountState extends State<toggleBtnAccount> {
  double? xAlign;
  Color? loginColor;
  Color? signInColor;

  VoidCallback voidCallback;
  _toggleBtnAccountState(this.voidCallback);

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign!, 0),
              duration: const Duration(milliseconds: 100),
              child: Container(
                margin: const EdgeInsets.all(5.0),
                width: width * 0.5,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = loginAlign;
                  loginColor = selectedColor;
                  signInColor = normalColor;
                  voidCallback();
                });
              },
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Container(
                  width: width * 0.5,
                  height: height,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Articles',
                    style: TextStyle(
                        color: loginColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = signInAlign;
                  signInColor = selectedColor;
                  loginColor = normalColor;
                  voidCallback();
                });
              },
              child: Align(
                alignment: const Alignment(1, 0),
                child: Container(
                  width: width * 0.5,
                  height: height,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Message',
                    style: TextStyle(
                        color: signInColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
