import 'package:clone_981_park_app/riverpod/date_time_select_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateSelectHorizontalScrollWidget extends ConsumerWidget {
  const DateSelectHorizontalScrollWidget({
    super.key,
    required this.data,
    required this.scrollController,
  });
  final data;
  final scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollMonth = ref.watch(ScrollMonthProvider);
    final selectDate = ref.watch(SelectDateProvider);

    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      color: const Color.fromARGB(255, 243, 243, 243),
      padding: const EdgeInsets.only(top: 16.0, bottom: 24.0, right: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  scrollMonth,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: deviceWidth / 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('yyyy.MM.dd (E)', 'ko_KR').format(
                    DateTime.parse(
                      selectDate,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: deviceWidth / 26,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ScrollConfiguration(
            behavior:
                const MaterialScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: data[0].data.map<Widget>(
                  (e) {
                    String dayOfTheWeek = e.date == '2021-04-02'
                        ? '오늘'
                        : DateFormat('E', 'ko_KR')
                            .format(DateTime.parse(e.date));
                    return Padding(
                      padding: EdgeInsets.only(
                          left: dayOfTheWeek == '오늘' ? 14.0 : 4.0, right: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(SelectDateProvider.notifier)
                              .update((state) => e.date);
                          ref
                              .read(SelectTimeProvider.notifier)
                              .update((state) => '');
                        },
                        child: Column(
                          children: [
                            Container(
                              width: deviceWidth / 10,
                              height: deviceWidth / 10,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth / 5),
                                color: e.date == selectDate
                                    ? const Color.fromARGB(255, 7, 105, 254)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('d')
                                      .format(DateTime.parse(e.date)),
                                  style: TextStyle(
                                    color: e.date == selectDate
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: deviceWidth / 24,
                                    fontWeight: e.date == selectDate
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              dayOfTheWeek,
                              style: TextStyle(
                                color:
                                    e.date == selectDate || dayOfTheWeek == '오늘'
                                        ? const Color.fromARGB(255, 7, 105, 254)
                                        : dayOfTheWeek == '일'
                                            ? Colors.red
                                            : Colors.black,
                                fontSize: deviceWidth / 24,
                                fontWeight: e.date == selectDate
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
