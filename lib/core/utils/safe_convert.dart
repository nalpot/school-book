// Utility to safely convert various dynamic types to specific Dart types

int toInt(dynamic value, {int defaultValue = 0}) {
  if (value == null) return defaultValue;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is bool) return value ? 1 : 0;
  if (value is String) {
    final parsed = int.tryParse(value) ?? double.tryParse(value)?.toInt();
    return parsed ?? defaultValue;
  }
  return defaultValue;
}

double toDouble(dynamic value, {double defaultValue = 0.0}) {
  if (value == null) return defaultValue;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is bool) return value ? 1.0 : 0.0;
  if (value is String) return double.tryParse(value) ?? defaultValue;
  return defaultValue;
}

bool toBool(dynamic value, {bool defaultValue = false}) {
  if (value == null) return defaultValue;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final lower = value.toLowerCase();
    if (value == "1" || lower == "true") return true;
    if (value == "0" || lower == "false") return false;
  }
  return defaultValue;
}

String toString(dynamic value, {String defaultValue = ""}) {
  if (value == null) return defaultValue;
  if (value is String) return value;
  if (value is num || value is bool) return value.toString();
  return defaultValue;
}

Map<String, dynamic> toMap(
  dynamic value, {
  Map<String, dynamic>? defaultValue,
}) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return defaultValue ?? <String, dynamic>{};
}

List toList(dynamic value, {List? defaultValue}) {
  if (value is List) return value;
  if (value is Iterable) return value.toList();
  return defaultValue ?? [];
}

// --------- JSON Safe Extractors ---------

int asInt(Map<String, dynamic>? json, String key, {int defaultValue = 0}) =>
    toInt(json?[key], defaultValue: defaultValue);

double asDouble(
  Map<String, dynamic>? json,
  String key, {
  double defaultValue = 0.0,
}) => toDouble(json?[key], defaultValue: defaultValue);

bool asBool(
  Map<String, dynamic>? json,
  String key, {
  bool defaultValue = false,
}) => toBool(json?[key], defaultValue: defaultValue);

String asString(
  Map<String, dynamic>? json,
  String key, {
  String defaultValue = "",
}) => toString(json?[key], defaultValue: defaultValue);

Map<String, dynamic> asMap(
  Map<String, dynamic>? json,
  String key, {
  Map<String, dynamic>? defaultValue,
}) => toMap(json?[key], defaultValue: defaultValue);

List asList(Map<String, dynamic>? json, String key, {List? defaultValue}) =>
    toList(json?[key], defaultValue: defaultValue);

List<int> asListInt(
  Map<String, dynamic>? json,
  String key, {
  List? defaultValue,
}) =>
    asList(
      json,
      key,
      defaultValue: defaultValue,
    ).map(toInt).whereType<int>().toList();

List<T> asListMapped<T>(
  Map<String, dynamic>? json,
  String key, {
  required T Function(dynamic item) mapper,
  List<T> defaultValue = const [],
}) {
  final list = json?[key];
  if (list is List) {
    return list.map<T>(mapper).toList();
  }
  return defaultValue;
}

T asT<T>(Map<String, dynamic>? json, String key, {T? defaultValue}) {
  dynamic value = json?[key];

  if (value == null) return _defaultForType<T>(defaultValue);

  if (value is T) return value;

  try {
    if (T == int)
      return toInt(value, defaultValue: defaultValue as int? ?? 0) as T;
    if (T == double)
      return toDouble(value, defaultValue: defaultValue as double? ?? 0.0) as T;
    if (T == bool)
      return toBool(value, defaultValue: defaultValue as bool? ?? false) as T;
    if (T == String)
      return toString(value, defaultValue: defaultValue as String? ?? '') as T;
    if (T == List)
      return toList(value, defaultValue: defaultValue as List? ?? []) as T;
    if (T == Map<String, dynamic>) {
      return toMap(
            value,
            defaultValue: defaultValue as Map<String, dynamic>? ?? {},
          )
          as T;
    }
  } catch (_) {}

  return _defaultForType<T>(defaultValue);
}

T _defaultForType<T>(T? fallback) {
  if (fallback != null) return fallback;
  if (T == int) return 0 as T;
  if (T == double) return 0.0 as T;
  if (T == bool) return false as T;
  if (T == String) return '' as T;
  if (T == List) return [] as T;
  if (T == Map<String, dynamic>) return <String, dynamic>{} as T;
  throw UnsupportedError("Cannot infer default value for type $T");
}
