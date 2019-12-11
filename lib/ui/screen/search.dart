import 'dart:io';

import 'package:Anifrag/bloc/bloc_search.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/ui/widget/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => ComponentInjector.I.blocSearch,
      child: _Search(),
    );
  }
}

class _Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
                left: 15, right: 15, top: Platform.isAndroid ? 15 : 0),
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  decoration: BoxDecoration(
                      color: AppColor.search,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(
                          PathSvg.find,
                          color: Colors.grey,
                          height: 20,
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          onChanged: (text) {
                            Provider.of<BlocSearch>(context).searchMovies(text);
                          },
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey)),
                          style:
                              TextStyle(color: Colors.grey[50], fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: Provider.of<BlocSearch>(context)
                              .valueNotifyIsLoading,
                          builder: (_, isLoading, ___) {
                            if (isLoading) return Indicator();

                            return SizedBox();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: StreamBuilder<SearchState>(
                  stream: Provider.of<BlocSearch>(context).subjectSearchState,
                  builder: (_, snapshot) {
                    switch (snapshot.data) {
                      case SearchState.kickoff:
                        return _MessageView(
                          message: 'Find what to watch next.',
                        );
                      case SearchState.fulfill:
                        return Container(
                          color: Colors.black87,
                        );
                      default:
                        return _MessageView(
                          message: 'Oh damm. We dont have that.',
                        );
                    }
                  },
                ))
              ],
            ),
          ),
        ),
      );
}

class _MessageView extends StatelessWidget {
  final String message;

  _MessageView({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            this.message == null ? '' : this.message,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
