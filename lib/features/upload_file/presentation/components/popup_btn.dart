import 'package:flutter/material.dart';

class PopUpActionBtn extends StatelessWidget {
  final String btnTitle;
  final Function() onPressed;
  const PopUpActionBtn({
    super.key,
    required this.btnTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: btnTitle == "Reset" ? Colors.white : const Color(0xFF3D5A80),
          border: Border.all(color: Color(0xFF3D5A80), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? Color.fromARGB(255, 122, 152, 191)
                  : null;
            },
          ),
          elevation: MaterialStatePropertyAll(0),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          backgroundColor: btnTitle == "Upload"
              ? MaterialStatePropertyAll(
                  Color.fromARGB(255, 48, 71, 101),
                )
              : MaterialStatePropertyAll(Colors.white),
        ),
        onPressed: onPressed,
        child: Text(
          btnTitle,
          style: TextStyle(
              fontFamily: "dmsans",
              color: btnTitle == "Upload"
                  ? Colors.white
                  : const Color(0xFF3D5A80)),
        ),
      ),
    );
  }
}
