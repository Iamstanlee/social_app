import 'package:path_provider/path_provider.dart';

class DeviceUtils {
  static Future<String> getStorageDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
