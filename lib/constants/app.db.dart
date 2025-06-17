import 'package:satu/config.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

const String dbname = 'mobile.db';
const int dbversion = 1;
const String createUser = "create table if not exists user ( "
    "id integer primary key, "
    "token text "
    ")";

class AppDb {
  AppDb._();
  static Future<Database> open() async {
    return await openDatabase(
      dbname,
      version: dbversion,
      password: Config.dbPassword,
      onCreate: (Database db, int version) async {
        await db.execute(createUser);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        //
      },
    );
  }

  static Future<bool> isOpen() async {
    try {
      Database db = await open();
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> rmDB() async {
    await deleteDatabase(dbname);
  }

  static Future<List<Map>> all(String table, {String? orderBy}) async {
    Database db = await open();
    List<Map> maps = await db.query(table, orderBy: orderBy);
    db.close();
    return maps;
  }

  static Future<dynamic> allByMap(String table, Map<String, dynamic> data) async {
    Database db = await open();
    List<String> w = [];
    List<Object> v = [];
    data.forEach((key, value) {
      w.add("$key = ?");
      v.add(value);
    });
    List<Map> maps = await db.query(table, where: w.join(" and "), whereArgs: v);
    db.close();
    return maps;
  }

  static Future<dynamic> first(String table, int id) async {
    Database db = await open();
    List<Map> maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return maps.first;
    return null;
  }

  static Future<Map?> findByMap(String table, Map<String, dynamic> data) async {
    Database db = await open();
    List<String> w = [];
    List<Object> v = [];
    data.forEach((key, value) {
      w.add("$key = ?");
      v.add(value);
    });
    List<Map> maps = await db.query(table, where: w.join(" and "), whereArgs: v);
    db.close();
    if (maps.isNotEmpty) return maps.first;
    return null;
  }

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    Database db = await open();
    return await db.insert(table, data);
  }

  static Future<int> update(String table, int id, Map<String, dynamic> data) async {
    Database db = await open();
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(String table, int id) async {
    Database db = await open();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteAll(String table) async {
    Database db = await open();
    return await db.delete(table);
  }
}
