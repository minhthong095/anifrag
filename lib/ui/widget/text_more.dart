import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextMoreOneWay extends StatefulWidget {
  final TextStyle textStyle;
  final TextStyle readMoreStyle;
  final String text;
  final String readMoreText;
  final int maxCharacter;
  final Function tapReadMore;

  TextMoreOneWay(
      {this.textStyle,
      this.readMoreStyle,
      this.text,
      this.readMoreText,
      this.tapReadMore,
      this.maxCharacter = 20});

  @override
  _TextMoreOneWayState createState() => _TextMoreOneWayState();
}

class _TextMoreOneWayState extends State<TextMoreOneWay> {
  String _textAfterReduce;
  bool _unwrapReadMore = false;

  @override
  void initState() {
    _initReduceText();
    super.initState();
  }

  @override
  void didUpdateWidget(TextMoreOneWay oldWidget) {
    _initReduceText();
    super.didUpdateWidget(oldWidget);
  }

  void _initReduceText() {
    _textAfterReduce =
        _splitTextBaseOnMaxCharacter(widget.text, widget.maxCharacter);
  }

  String _splitTextBaseOnMaxCharacter(String original, int maxCharacter) {
    int count = 0;
    String value = '';
    final iterable = original.split(" ");

    for (int c = 0; c < iterable.length; c++) {
      if (count++ == maxCharacter) break;

      value += iterable[c] + ' ';
    }
    return value.substring(0, value.length - 1);
  }

  void _onReadMoreTap() {
    setState(() {
      _unwrapReadMore = true;
    });
    if (widget.tapReadMore != null) widget.tapReadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 17),
        children: [
          TextSpan(
            text: _unwrapReadMore ? widget.text : _textAfterReduce,
            style: TextStyle(color: Colors.white),
          ),
          _unwrapReadMore
              ? TextSpan()
              : TextSpan(
                  text: widget.readMoreText,
                  style: TextStyle(color: AppColor.yellow),
                  recognizer: TapGestureRecognizer()..onTap = _onReadMoreTap)
        ],
      ),
    ));
  }
}
