import 'dart:convert';

import 'package:clone_981_park_app/model/date_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final DateProvider = FutureProvider<List<DateModel>>((ref) async {
  final dateJsonFile = await rootBundle.loadString('assets/jsons/date.json');
  final jsonData = json.decode(dateJsonFile);

  final DateModel dateModel = DateModel.fromJson(jsonData);
  return [dateModel];
});
