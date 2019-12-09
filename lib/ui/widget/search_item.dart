import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:flutter/material.dart';

class SearchItemScreenTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        color: AppColor.backgroundColor,
        child: Center(
          child: SearchItem(
            runtime: 120,
            yearRelease: 2019,
          ),
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String title;
  final int yearRelease;
  final int runtime;
  final String director;

  SearchItem({String title, String director, int runtime, int yearRelease})
      : this.title = title ?? '',
        this.yearRelease = yearRelease ?? null,
        this.runtime = runtime ?? null,
        this.director = director ?? '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 120),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xff26262c),
          borderRadius: BorderRadius.all(Radius.circular(9))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Image.asset(
              PathImage.dunkirk,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '${this.yearRelease == null ? '' : this.yearRelease.toString()}${this.yearRelease == null || this.runtime == null ? '' : ' * '}' +
                    Utils.generateStringRuntime(runtime),
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  director,
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ],
          ))
        ],
      ),
    );
  }
}
