import 'package:clone_981_park_app/riverpod/date_proivder.dart';
import 'package:clone_981_park_app/riverpod/date_time_select_screen_provider.dart';
import 'package:clone_981_park_app/screen/date_time_select_screen/date_select_horizontal_scroll_widget.dart';
import 'package:clone_981_park_app/screen/date_time_select_screen/date_time_next_button_widget.dart';
import 'package:clone_981_park_app/screen/date_time_select_screen/time_select_gride_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeSelectScreen extends ConsumerStatefulWidget {
  const DateTimeSelectScreen({super.key});

  @override
  ConsumerState<DateTimeSelectScreen> createState() =>
      _DateTimeSelectSelectScreen();
}

class _DateTimeSelectSelectScreen extends ConsumerState<DateTimeSelectScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(
      () {
        final dataList = ref.read(DateProvider).asData!.value[0].data;
        final double itemWidth = (MediaQuery.of(context).size.width / 10) + 8;
        final double firstItemWidth = itemWidth + 14;
        double scrollControllerOffSet = scrollController.offset - 14;
        double totalItemWidth = scrollControllerOffSet >= firstItemWidth
            ? itemWidth
            : firstItemWidth;
        int index = (scrollControllerOffSet / totalItemWidth).round();

        if (index >= 0 && index < dataList.length) {
          ref.read(ScrollMonthProvider.notifier).update(
                (state) => DateFormat('M', 'ko_KR').format(
                  DateTime.parse(
                    dataList[index].date,
                  ),
                ),
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateValue = ref.watch(DateProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        title: Row(
          children: [
            IconButton(
              splashRadius: 24,
              icon: const Icon(
                CupertinoIcons.chevron_left,
              ),
              onPressed: () {
                Navigator.pop(context);
                ref.read(SelectTimeProvider.notifier).update((state) => '');
                ref
                    .read(SelectDateProvider.notifier)
                    .update((state) => '2021-04-02');
              },
            ),
            Container(
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 7, 105, 254),
                borderRadius: BorderRadius.circular(10.5),
              ),
              child: const Center(
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
            ),
            const Text(
              '날짜 시간 선택',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: const Icon(
              CupertinoIcons.xmark,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          dateValue.when(
            data: (data) {
              return DateSelectHorizontalScrollWidget(
                  scrollController: scrollController, data: data);
            },
            loading: () => const CupertinoActivityIndicator(),
            error: (error, stackTrace) => const Text('error'),
          ),
          const TimeSelectGrideWidget(),
          const DateTimeNextButtonWidget(),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
