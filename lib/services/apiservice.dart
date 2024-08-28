import 'package:assignmentjoyistick/utility/uihelper/allpackages.dart';

import '../models/company_model.dart';


class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/albums/1";
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = baseUrl;

       _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          print('Headers: ${options.headers}');
          print('Request Data: ${options.data}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioException e, handler) {
          print('ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          return handler.next(e); // Continue with the error
        },
      ),
    );
  }

  Future<List<CompanyModel>> fetchData() async {
    print('Data11');
    try {
      final response = await _dio.get('/photos');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        print('Data11${response.data}');
        return data.map((item) => CompanyModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        throw Exception('Server Error: ${e.response?.statusCode}');
      } else {
        // Network error
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected Error: $e');
    }
  }
}

