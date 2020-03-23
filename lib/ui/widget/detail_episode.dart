import 'dart:convert';

import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/model/business/business_movie.dart';
import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:Anifrag/state/state_detail_episode.dart';
import 'package:Anifrag/ui/screen/test_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlocDetail2 with DisposeBag {
  static final Dio dio = Dio()
    ..options.baseUrl = Url.baseUrl
    ..options.headers = {'Authentication': 'Bearer ' + ApiKey.v3};
  static final Url url = ImplUrl();
  static final RequestingMovie requestingMovie = RequestingMovieImplement(dio);
  static final Requesting requestingAbiary = RequestingAbiaryImplement(dio);
  final API _api = Api(requestingMovie, url, requestingAbiary);
  final BusinessMovie _businessMovie =
      BusinessMovie.fromJson(json.decode(pseudo));

  /// Below mock data

  final ValueNotifier<int> stateNumEpisodes = ValueNotifier(0);
  final ValueNotifier<StateDetailEpisode> stateEpisodes =
      ValueNotifier(StateDetailEpisode.initial());

  int get getNumberOfSeason => _businessMovie.numberOfSeasons;

  void callEpisodes({int season = 1}) {
    _api.getTvEpisodes(_businessMovie.id, season).then((onValue) {
      if (onValue == null || onValue.length == 0) {
        stateEpisodes.value = StateDetailEpisode.empty();
        stateNumEpisodes.value = 0;
      } else {
        stateEpisodes.value = StateDetailEpisode.loaded(onValue);
        stateNumEpisodes.value = onValue.length;
      }
    }).catchError((onError) {
      stateEpisodes.value = StateDetailEpisode.empty();
    });
  }
}

class TestDetailEpisodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailEpisode(),
    );
  }
}

class DetailEpisode extends StatefulWidget {
  @override
  _DetailEpisodeState createState() => _DetailEpisodeState();
}

class _DetailEpisodeState extends State<DetailEpisode> {
  BlocDetail _blocDetail;

  @override
  void initState() {
    _blocDetail = Provider.of<BlocDetail>(context, listen: false);
    _blocDetail.callEpisodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              VirgilAaronDropDown(
                seasonCount: _blocDetail.getNumberOfSeason,
                onTap: (index) {
                  _blocDetail.callEpisodes(season: index);
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                          right: 20,
                        ),
                        child: ValueListenableBuilder(
                            valueListenable: _blocDetail.stateNumEpisodes,
                            builder: (_, data, __) {
                              return _Info(data);
                            })),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _blocDetail.stateEpisodes,
              builder: (BuildContext context, StateDetailEpisode snapshot,
                  Widget child) {
                return snapshot.join<Widget>(
                    (initial) => Empty(),
                    (empty) => EmptyTitle(),
                    (loaded) => Container(
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border:
                                  Border.all(width: 20, color: Colors.yellow)),
                          // child: Container(
                          //   width: 200,
                          //   height: 200,
                          //   color: Colors.blue,
                          // ),
                          // child: ListView.separated(
                          //     padding: EdgeInsets.all(0),
                          //     separatorBuilder: (_, __) => SizedBox.fromSize(
                          //           size: Size(0, 0),
                          //         ),
                          //     itemCount: loaded.data.length,
                          //     itemBuilder: (_, index) => _ItemEpisode(
                          //         loaded.data[index].name,
                          //         loaded.data[index].airDate,
                          //         index + 1)),
                          child: Column(
                            children: loaded.data
                                .asMap()
                                .entries
                                .map((entry) => _ItemEpisode(entry.value.name,
                                    entry.value.airDate, entry.key + 1))
                                .toList(),
                          ),
                        ));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ItemEpisode extends StatelessWidget {
  final String name;
  final DateTime airDate;
  final int episode;

  _ItemEpisode(this.name, this.airDate, this.episode);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     border:
      //         Border.all(color: Color.fromRGBO(216, 216, 216, 1), width: 2)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              episode.toString(),
              style: TextStyle(
                  color: Color.fromRGBO(216, 216, 216, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(airDate),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  static const fontSize = 22.0;
  final TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.white);
  final int episode;

  _Info(this.episode);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        episode == null || episode == 0
            ? SizedBox.shrink()
            : Text(
                episode.toString(),
                style: textStyle,
              ),
        SizedBox.fromSize(
          size: Size(20, 0),
        ),
        Image.asset(
          PathIcon.tv,
          filterQuality: FilterQuality.none,
          height: 28,
        )
      ],
    );
  }
}

class EmptyTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "It's empty",
          style: TextStyle(color: AppColor.yellow, fontSize: 25),
        ),
      ),
    );
  }
}

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

const pseudo = '''{
    "backdrop_path": "/3YS19tuwW5bOpvpJga7TaYT5X20.jpg",
    "created_by": [
        {
            "id": 1296509,
            "credit_id": "5a3240ff925141547501253b",
            "name": "Andrew Sodroski",
            "gender": 2,
            "profile_path": null
        },
        {
            "id": 1682545,
            "credit_id": "5b90aaa192514166a3006540",
            "name": "Jim Clemente",
            "gender": 2,
            "profile_path": null
        },
        {
            "id": 1777101,
            "credit_id": "5b90aab00e0a2665a8006aad",
            "name": "Tony Gittelson",
            "gender": 2,
            "profile_path": null
        }
    ],
    "episode_run_time": [
        42
    ],
    "first_air_date": "2017-08-01",
    "genres": [
        {
            "id": 80,
            "name": "Crime"
        },
        {
            "id": 18,
            "name": "Drama"
        },
        {
            "id": 9648,
            "name": "Mystery"
        }
    ],
    "homepage": "https://spectrumoriginals.com/manhunt-deadly-games",
    "id": 72597,
    "in_production": true,
    "languages": [
        "en"
    ],
    "last_air_date": "2020-02-03",
    "last_episode_to_air": {
        "air_date": "2020-02-03",
        "episode_number": 10,
        "id": 2158384,
        "name": "Open Season",
        "overview": "Eric, starving and bereft of allies, is finally captured. But as his day in court—and Richard's exoneration—approaches, he has another dangerous secret in store for law enforcement.",
        "production_code": "",
        "season_number": 2,
        "show_id": 72597,
        "still_path": "/sjiQGDvYBwdAqQEvlB6yNqjvae0.jpg",
        "vote_average": 0.0,
        "vote_count": 0
    },
    "name": "Manhunt",
    "next_episode_to_air": null,
    "networks": [
        {
            "name": "Discovery",
            "id": 64,
            "logo_path": "/tmttRFo2OiXQD0EHMxxlw8EzUuZ.png",
            "origin_country": "US"
        },
        {
            "name": "Spectrum",
            "id": 2871,
            "logo_path": "/ta0tkJ6VUugXwQzdea6T7jzUYkI.png",
            "origin_country": "US"
        }
    ],
    "number_of_episodes": 18,
    "number_of_seasons": 2,
    "origin_country": [
        "US"
    ],
    "original_language": "en",
    "original_name": "Manhunt",
    "overview": "Inspired by actual events, this true crime anthology series takes a deep dive into the dark, twisted minds of terrorists and follows the brave souls who hunt them down.",
    "popularity": 23.583,
    "poster_path": "/gmSOPIOenH39XHEdtfPwgi2lWNj.jpg",
    "production_companies": [
        {
            "id": 98468,
            "logo_path": null,
            "name": "Tigger Street Productions",
            "origin_country": ""
        },
        {
            "id": 1632,
            "logo_path": "/cisLn1YAUuptXVBa0xjq7ST9cH0.png",
            "name": "Lionsgate",
            "origin_country": "US"
        }
    ],
    "seasons": [
        {
            "air_date": "2017-07-31",
            "episode_count": 8,
            "id": 89961,
            "name": "Unabomber",
            "overview": "Follow Jim Fitzgerald, the FBI agent who tracked down Ted Kaczynski, aka the “Unabomber,” and brought him to justice through his expertise in profiling and linguistics.",
            "poster_path": "/gmSOPIOenH39XHEdtfPwgi2lWNj.jpg",
            "season_number": 1
        },
        {
            "air_date": "2020-02-03",
            "episode_count": 10,
            "id": 142141,
            "name": "Deadly Games",
            "overview": "The story of one of the largest and most complex manhunts on U.S. soil—the search for the 1996 Atlanta Olympic Park Bomber—and the media firestorm that consumed the life of Richard Jewell in its wake.",
            "poster_path": "/cDKXn1TjX6b111WXEzDKmCB2R1h.jpg",
            "season_number": 2
        }
    ],
    "status": "Returning Series",
    "type": "Scripted",
    "vote_average": 7.8,
    "vote_count": 135
}''';
