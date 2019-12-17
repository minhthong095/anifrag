import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/material.dart';

// class SearchDetail extends AnimatedWidget {

//   SearchDetail({Key key, @required AnimationController controller})
//       : super(key: key, listenable: controller);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOp;
//   }
// }

class SearchDetail extends StatefulWidget {
  final Function onTap;

  SearchDetail({@required this.onTap});

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  @override
  void initState() {
    print("HAHA");
    super.initState();
  }

  @override
  void dispose() {
    print("DISPOSE");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1500,
        color: AppColor.backgroundColor,
        child: GestureDetector(
          onTap: this.widget.onTap,
          child: Center(
            child: Container(
              constraints: BoxConstraints.tight(Size(200, 200)),
              color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}
