import 'package:cat_directory_app/models/breed_model.dart';
import 'package:dio/dio.dart';

class BreedService {
  final Dio dio;

  BreedService(this.dio);

  Future<List<BreedModel>> fetchBreeds(int page) async {
    try {
      final response = await dio.get(
        '/breeds',
        queryParameters: {'page': page},
      );

      final List data = response.data['data'];

      return data.map((e) => BreedModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  Future<String> fetchRandomFact() async {
    try {
      final response = await dio.get('/fact');
      return response.data['fact'];
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  String _mapDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timed out';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    }
    return 'Unexpected error';
  }
}
