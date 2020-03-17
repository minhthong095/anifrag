import 'dart:io';

import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryOverview extends StatefulWidget {
  @override
  _StoryOverviewState createState() => _StoryOverviewState();
}

class _StoryOverviewState extends State<StoryOverview> {
  BlocDetail _blocDetail;

  @override
  void didChangeDependencies() {
    _blocDetail = Provider.of<BlocDetail>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Title(
            padding: EdgeInsets.only(bottom: 10),
            text: 'Storyline',
          ),
          Text(
            _blocDetail.getMovie.overview,
            style: TextStyle(color: Colors.white),
          ),
          _Cast(casts: _blocDetail.getCasts),
          if (Platform.isAndroid) SizedBox.fromSize(size: Size(0, 30)),
        ],
      );
}

class _Cast extends StatelessWidget {
  final List<ResponseCast> casts;
  String _stringCasts = '';

  _Cast({@required this.casts}) {
    if (casts.length > 0) {
      casts.forEach((cast) {
        _stringCasts += cast.name + ', ';
      });
      _stringCasts = _stringCasts.substring(0, _stringCasts.length - 2);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Title(
            text: 'Cast',
          ),
          Text(
            _stringCasts,
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
