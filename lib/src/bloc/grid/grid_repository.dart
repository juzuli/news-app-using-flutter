import 'package:citizens/src/model/api_response.dart';
import 'package:citizens/src/web_service/api_helper.dart';

class GridRepository{
  Future<ApiResponse>fetchGrid()async{
    String route='NewsAPI/everything/cnn.json';
    final response = await ApiHelper.internal().getData(route);
    return response;
  }
}