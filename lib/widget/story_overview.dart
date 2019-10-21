import 'dart:io';

import 'package:flutter/material.dart';

class StoryOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Title(
            padding: EdgeInsets.only(bottom: 10),
            text: 'Storyline',
          ),
          Text(
            'A cynical American expatriate struggles to decide whether or not he should help his former lover and her fugitive husband escape French Morocco.',
            style: TextStyle(color: Colors.white),
          ),
          _Cast(),
          if (Platform.isAndroid) SizedBox.fromSize(size: Size(0, 30)),
        ],
      );
}

class _Cast extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Title(
            text: 'Cast',
          ),
          Text(
            'Robert De Niro, Jack Nicholson, Marlon Brando, Denzel Washington, Tom Hanks, Leonardo DiCaptio',
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
}

class _Title extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const _Title(
      {@required this.text,
      this.padding = const EdgeInsets.symmetric(vertical: 10)});

  @override
  Widget build(BuildContext context) => Padding(
        padding: this.padding,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      );
}
