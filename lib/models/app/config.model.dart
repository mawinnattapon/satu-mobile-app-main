import 'package:satu/constants/map.dart';

class AppComfig {
  AppComfig();

  late String version = "";
  late bool force = false;
  late bool register = false;
  late bool remove = false;

  AppComfig.fromJson(Map<String, dynamic> json) {
    version = json.getString('version');
    force = json.getBool('force');
    register = json.getBool('register');
    remove = json.getBool('remove');
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['version'] = version;
    json['force'] = force;
    json['register'] = register;
    json['remove'] = remove;
    return json;
  }
}
