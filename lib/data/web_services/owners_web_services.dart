import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class OwnersWebServices {
  late Dio dio;
  OwnersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllOwners() async {
    try {
      Response response = await dio.get('repositories');
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }
}
