Map<String, dynamic> compareJson(Map<dynamic, dynamic> json1, Map<String, dynamic> json2) {
  final Map<String, dynamic> diff = <String, dynamic>{};

  json1.forEach((dynamic key, dynamic value) {
    final String stringKey = key.toString();
    if (!json2.containsKey(stringKey)) {
      diff[stringKey] = value;
    } else if (json2[stringKey] != value) {
      if (value is Map && json2[stringKey] is Map) {
        final Map<String, dynamic> nestedDiff = compareJson(value, json2[stringKey] as Map<String, dynamic>);
        if (nestedDiff.isNotEmpty) {
          diff[stringKey] = nestedDiff;
        }
      } else {
        diff[stringKey] = json2[stringKey];
      }
    }
  });

  json2.forEach((String key, dynamic value) {
    if (!json1.containsKey(key)) {
      diff[key] = value;
    }
  });

  return diff;
}
