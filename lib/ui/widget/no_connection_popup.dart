import 'package:flutter/material.dart';

class NoConnectionPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff313238),
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "You're offline. Please check your connection.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
