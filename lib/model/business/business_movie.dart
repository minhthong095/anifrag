import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_tv.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_movie.g.dart';

@JsonSerializable()
class BusinessMovie {
  final int id;
  final String overview;
  final int runtime;
  final double popularity;
  final String title;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'release_date')
  final DateTime releaseDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'number_of_seasons')
  final int numberOfSeasons;
  @JsonKey(name: 'number_of_episodes')
  final int numberOfEpisodes;

  BusinessMovie(
      this.id,
      this.overview,
      this.popularity,
      this.runtime,
      this.title,
      this.posterPath,
      this.releaseDate,
      this.voteAverage,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.voteCount);

  BusinessMovie.movie(ResponseMovie movie)
      : this.id = movie.id,
        this.overview = movie.overview,
        this.runtime = movie.runtime,
        this.popularity = movie.popularity,
        this.title = movie.title,
        this.posterPath = movie.posterPath,
        this.releaseDate = movie.releaseDate,
        this.voteAverage = movie.voteAverage,
        this.voteCount = movie.voteCount,
        this.numberOfSeasons = -1,
        this.numberOfEpisodes = -1;

  BusinessMovie.tv(ResponseTv tv)
      : this.id = tv.id,
        this.overview = tv.overview,
        this.runtime = tv.episodeRunTime[0],
        this.popularity = tv.popularity,
        this.title = tv.originalName,
        this.posterPath = tv.posterPath,
        this.releaseDate = tv.firstAirDate,
        this.voteAverage = tv.voteAverage,
        this.voteCount = tv.voteCount,
        this.numberOfSeasons = tv.numberOfSeasons,
        this.numberOfEpisodes = tv.numberOfEpisodes;

  factory BusinessMovie.fromJson(Map<String, dynamic> json) {
    return _$BusinessMovieFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusinessMovieToJson(this);
}
