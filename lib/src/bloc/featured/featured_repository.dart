import 'package:citizens/src/model/api_response.dart';

import '../../web_service/api_helper.dart';

class FeaturedRepository {
  Future<ApiResponse> fetchFeatured() async {
    String route = 'NewsAPI/everything/cnn.json';
    final response = await ApiHelper.internal().getData(route);
    return response;
  }
}
