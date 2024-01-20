import 'dart:convert';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseDao<T extends Model> {
  final Mapper<T>? _mapper;
  final SharedPreferences _preferences;
  int lastUpdatedTime = 0;
  int expiredTimeInMinute;

  BaseDao({
    Mapper<T>? mapper,
    required SharedPreferences preferences,
    this.expiredTimeInMinute = 5,
  })  : _mapper = mapper,
        _preferences = preferences;

  Future<void> saveList(String key, List<T> list, {DateTime? now}) async {
    await _preferences.setString(
        key, json.encode(list.map((i) => i.toJson()).toList()));

    final time = now ?? DateTime.now();
    lastUpdatedTime = time.millisecondsSinceEpoch;
    await _preferences.setInt(_lastUpdatedKey, lastUpdatedTime);
  }

  List<T>? getList(String key) {
    if (_mapper == null || _isExpired()) return null;

    final jsonString = _preferences.getString(key);
    if (jsonString == null) return null;

    try {
      final dic = List<Map<String, dynamic>>.from(json.decode(jsonString));
      return dic.map(_mapper.parser).toList();
    } catch (e) {
      log.error('Parse json ${T.toString()} error: $e');
      return null;
    }
  }

  bool _isExpired() {
    final lastUpdatedTimeStamp = lastUpdated();
    final passedTime = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastUpdatedTimeStamp))
        .inMinutes;

    return passedTime > expiredTimeInMinute;
  }

  Future<void> clearList(String key) async {
    await _preferences.remove(key);
    await _preferences.remove(_lastUpdatedKey);
  }

  Future<void> clearAllKeysMatchPrefix(String prefix) async {
    final allKeys = _preferences.getKeys();
    final removingKeys = <String>[];

    for (final key in allKeys) {
      if (key.startsWith(prefix)) {
        removingKeys.add(key);
      }
    }

    if (removingKeys.isEmpty) return;

    await Future.wait(removingKeys.map(_preferences.remove));
  }

  Future<void> saveItem(String key, T item) async {
    await _preferences.setString(key, json.encode(item.toJson()));
  }

  T? getItem(String key) {
    if (_mapper == null) return null;

    final jsonString = _preferences.getString(key);
    if (jsonString == null) return null;

    final dic = Map<String, dynamic>.from(json.decode(jsonString));
    if (dic.isEmpty) return null;

    return _mapper.parser(dic);
  }

  Future<void> clearObjectOrEntity(String key) async {
    await _preferences.remove(key);
  }

  Future<void> saveEntity<S extends Model>(String key, S entity) async {
    await _preferences.setString(key, json.encode(entity.toJson()));
  }

  S? getEntity<S extends Model>(String key, {required Mapper<S> mapper}) {
    final jsonString = _preferences.getString(key);
    if (jsonString == null) return null;

    final dic = Map<String, dynamic>.from(json.decode(jsonString));
    if (dic.isEmpty) return null;

    return mapper.parser(dic);
  }

  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<void> saveInteger(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  Future<void> saveBoolean(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  int? getInteger(String key) {
    return _preferences.getInt(key);
  }

  bool? getBoolean(String key) {
    return _preferences.getBool(key);
  }

  @override
  String toString() {
    return 'BaseDao';
  }

  String get _lastUpdatedKey => 'key_${toString()}_last_update';

  int lastUpdated() {
    if (lastUpdatedTime > 0) return lastUpdatedTime;

    return lastUpdatedTime = _preferences.getInt(_lastUpdatedKey) ?? 0;
  }
}
