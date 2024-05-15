import 'package:http/http.dart' as http;
import 'package:recipes_finder/src/res/endpoints.dart';

class RecipesRepository {
  Future<http.Response> fetchRecipesInformationBulk() async {
    try {
      final response = await http.get(
        Uri.parse(
          Endpoints.recipes,
        ),
      );

      // print(response.body);
      return response;
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
