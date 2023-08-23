import 'dart:convert';
import 'package:clone_981_park_app/model/time_model.dart';
import 'package:clone_981_park_app/riverpod/date_time_select_screen_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final TimeProvider = FutureProvider<List<TimeModel>>((ref) async {
  final selectDate = ref.watch(SelectDateProvider);
  final dateJsonFile = selectDate == '2021-04-02'
      ? await rootBundle.loadString('assets/jsons/basic.json')
      : selectDate == '2021-04-04'
          ? await rootBundle.loadString('assets/jsons/sunday.json')
          : null;
  final jsonData = json.decode(dateJsonFile!);

  final TimeModel basicModel = TimeModel.fromJson(jsonData);
  return [basicModel];
});
