import 'package:clone_981_park_app/riverpod/date_proivder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final ScrollMonthProvider = StateProvider<String>((ref) {
  final dateValue = ref.watch(DateProvider);

  return dateValue.when(
    data: (data) {
      return DateFormat('M', 'ko_KR').format(
        DateTime.parse(
          data[0].data[0].date,
        ),
      );
    },
    loading: () {
      return '';
    },
    error: (e, s) {
      return '';
    },
  );
});

final SelectDateProvider = StateProvider<String>((ref) {
  final dateValue = ref.watch(DateProvider);
  return dateValue.when(
    data: (data) {
      return data[0].data[0].date;
    },
    loading: () {
      return '';
    },
    error: (e, s) {
      return '';
    },
  );
});

final SelectTimeProvider = StateProvider((ref) {
  return '';
});
