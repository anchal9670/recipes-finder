import 'package:recipes_finder/src/utils/config.dart';

class BasePaths {
  static const baseProdUrl = "https://dummyjson.com";
  static const baseTestUrl = "https://dummyjson.com";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
