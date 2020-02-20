import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/di/module/module_network.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

abstract class Requesting {
  final Dio dio;
  final int timeOut = 10; // second
  final Function throwTimeout = () {
    throw DioError(
      error: 'Local connect timeout in AbsRequesting.',
    );
  };

  Requesting(this.dio);
}

abstract class RequestingAbiary extends Requesting {
  RequestingAbiary(Dio dio) : super(dio);

  Future<Response<T>> sendGET<T>(String url, {Map<String, dynamic> args});
}

abstract class RequestingMovie extends Requesting {
  RequestingMovie(Dio dio) : super(dio);
  Future<Response<T>> sendGETv3<T>(String url, {Map<String, dynamic> args});
}

class RequestingMovieImplement extends RequestingMovie {
  RequestingMovieImplement(Dio dio) : super(dio);

  @override
  Future<Response<T>> sendGETv3<T>(String url,
      {Map<String, dynamic> args}) async {
    args ??= Map<String, dynamic>();
    args['api_key'] = ApiKey.v3;
    return await dio
        .get(url, queryParameters: args)
        .timeout(Duration(seconds: timeOut), onTimeout: throwTimeout);
  }
}

@provide
class RequestingAbiaryImplement extends RequestingAbiary {
  @provide
  RequestingAbiaryImplement(Dio dio) : super(dio);

  @override
  Future<Response<T>> sendGET<T>(String url,
      {Map<String, dynamic> args}) async {
    return await dio
        .get(url, queryParameters: args)
        .timeout(Duration(seconds: timeOut), onTimeout: throwTimeout);
  }
}
