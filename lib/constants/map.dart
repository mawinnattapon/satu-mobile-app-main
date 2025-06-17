import 'dart:convert';

extension AppMap on Map {
  //=======================================================================
  bool hasKey(String key) {
    if (containsKey(key)) return true;
    return false;
  }

  bool isNull(String key) {
    if (!containsKey(key)) return true;
    if (this[key] == null) return true;
    return false;
  }

  //=======================================================================
  String getString(String key, {String v = ""}) {
    if (!containsKey(key)) return v;
    if (this[key] == null) return v;
    if (this[key] is int) return "${this[key]}";
    if (this[key] is double) return "${this[key]}";
    if (this[key] is String) {
      if (this[key].toString().toLowerCase().isEmpty) return v;
      if (this[key].toString().toLowerCase() == "nan") return v;
      if (this[key].toString().toLowerCase() == "null") return v;
      return this[key].toString();
    }
    return this[key].toString();
  }

  int getInt(String key, {int v = 0}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is int) return this[key];
      if (this[key] is double) return (this[key] as double).toInt();
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        if (this[key].toString().toLowerCase() == "nan") return v;
        if (this[key].toString().toLowerCase() == "null") return v;
        return int.parse(this[key]);
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  double getDouble(String key, {double v = 0.0}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is double) return this[key];
      if (this[key] is int) return (this[key] as int).toDouble();
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        if (this[key].toString().toLowerCase() == "nan") return v;
        if (this[key].toString().toLowerCase() == "null") return v;
        return double.parse(this[key]);
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  bool getBool(String key, {bool v = false}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is bool) return this[key];
      if (this[key] is int) return (this[key] as int) == 1;
      if (this[key] is double) return (this[key] as double) == 1;
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        if (this[key].toString().toLowerCase() == "false") return false;
        if (this[key].toString().toLowerCase() == "true") return true;
        return v;
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  List<T> getList<T>(String key, {List<T> v = const []}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is List) {
        if ((this[key] as List).isEmpty) return v;
        return List.from(this[key] as List).map((e) => e as T).toList();
      }
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        return List.from(jsonDecode(this[key].toString())).map((e) => e as T).toList();
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  List<Map<String, dynamic>> getListMap(String key, {List<Map<String, dynamic>> v = const []}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is List) {
        if ((this[key] as List).isEmpty) return v;
        return List.from(this[key] as List).map((e) => e as Map<String, dynamic>).toList();
      }
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        return List.from(jsonDecode(this[key].toString())).map((e) => e as Map<String, dynamic>).toList();
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  Map<String, dynamic> getMap<T>(String key, {Map<String, dynamic> v = const {}}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is Map) {
        return Map<String, dynamic>.from(this[key] as Map);
      }
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        return Map<String, dynamic>.from(jsonDecode(this[key].toString()));
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  //=======================================================================
  String? getStringN(String key, {String? v}) {
    if (!containsKey(key)) return v;
    if (this[key] == null) return v;
    if (this[key] is int) return "${this[key]}";
    if (this[key] is double) return "${this[key]}";
    if (this[key] is double) return "${this[key]}";
    if (this[key] is String) {
      if (this[key].toString().toLowerCase().isEmpty) return "";
      if (this[key].toString().toLowerCase() == "nan") return v;
      if (this[key].toString().toLowerCase() == "null") return v;
      return this[key].toString();
    }
    return this[key].toString();
  }

  int? getIntN(String key, {int? v}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is int) return this[key];
      if (this[key] is double) return (this[key] as double).toInt();
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        if (this[key].toString().toLowerCase() == "nan") return v;
        if (this[key].toString().toLowerCase() == "null") return v;
        return int.parse(this[key]);
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  double? getDoubleN(String key, {double? v}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is double) return this[key];
      if (this[key] is int) return (this[key] as int).toDouble();
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        if (this[key].toString().toLowerCase() == "nan") return v;
        if (this[key].toString().toLowerCase() == "null") return v;
        return double.parse(this[key]);
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  bool? getBoolN(String key, {bool? v}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is bool) return this[key];
      if (this[key] is int) return (this[key] as int) == 1;
      if (this[key] is double) return (this[key] as double) == 1;
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        if (this[key].toString().toLowerCase() == "false") return false;
        if (this[key].toString().toLowerCase() == "true") return true;
        return v;
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  List<T>? getListN<T>(String key, {List<T>? v}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is List) {
        if ((this[key] as List).isEmpty) return [];
        return List.from(this[key] as List).map((e) => e as T).toList();
      }
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        return List.from(jsonDecode(this[key].toString())).map((e) => e as T).toList();
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  List<Map<String, dynamic>>? getListMapN(String key, {List<Map<String, dynamic>>? v}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is List) {
        if ((this[key] as List).isEmpty) return [];
        return List.from(this[key] as List).map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        return List.from(jsonDecode(this[key].toString())).map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
      return v;
    } catch (e) {
      return v;
    }
  }

  Map<String, dynamic>? getMapN<T>(String key, {Map<String, dynamic>? v}) {
    try {
      if (!containsKey(key)) return v;
      if (this[key] == null) return v;
      if (this[key] is Map) {
        return Map<String, dynamic>.from(this[key] as Map);
      }
      if (this[key] is String) {
        if (this[key].toString().toLowerCase().isEmpty) return v;
        return Map<String, dynamic>.from(jsonDecode(this[key].toString()));
      }
      return v;
    } catch (e) {
      return v;
    }
  }
}
