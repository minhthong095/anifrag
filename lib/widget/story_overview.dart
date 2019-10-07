import 'package:Anifrag/screen/detail.dart';
import 'package:flutter/material.dart';

class StoryOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Detail.paddingContent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Title(
              text: 'Storyline',
            ),
            Text(
                'A cynical American expatriate struggles to decide whether or not he should help his former lover and her fugitive husband escape French Morocco.'),
            _Cast()
          ],
        ),
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
              'Robert De Niro, Jack Nicholson, Marlon Brando, Denzel Washington, Tom Hanks, Leonardo DiCaptio'),
        ],
      );
}

class _Title extends StatelessWidget {
  final String text;

  const _Title({@required this.text});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
}
