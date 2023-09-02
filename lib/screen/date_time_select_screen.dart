import 'package:clone_981_park_app/riverpod/date_proivder.dart';
import 'package:clone_981_park_app/riverpod/date_time_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/ticket_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/time_proivder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeSelectScreen extends ConsumerStatefulWidget {
  DateTimeSelectScreen({super.key});

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
    final basicValue = ref.watch(TimeProvider);
    final scrollMonth = ref.watch(ScrollMonthProvider);
    final selectDate = ref.watch(SelectDateProvider);
    final selectTime = ref.watch(SelectTimeProvider);
    final numberOfPeopleToPurchaseValue =
        ref.read(NumberOfPeopleToPurchaseProvider);
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        title: Row(
          children: [
            IconButton(
              splashRadius: 24,
              icon: Icon(
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
                color: Color.fromARGB(255, 7, 105, 254),
                borderRadius: BorderRadius.circular(10.5),
              ),
              child: Center(
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
            Padding(
              padding: EdgeInsets.only(
                right: 12.0,
              ),
            ),
            Text(
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
            icon: Icon(
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
              return Container(
                color: Color.fromARGB(255, 243, 243, 243),
                padding: EdgeInsets.only(top: 16.0, bottom: 24.0, right: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
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
                          MaterialScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: data[0].data.map((e) {
                            String dayOfTheWeek = e.date == '2021-04-02'
                                ? '오늘'
                                : DateFormat('E', 'ko_KR')
                                    .format(DateTime.parse(e.date));
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: dayOfTheWeek == '오늘' ? 14.0 : 4.0,
                                  right: 4.0),
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
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth / 5),
                                        color: e.date == selectDate
                                            ? Color.fromARGB(255, 7, 105, 254)
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
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                    ),
                                    Text(
                                      dayOfTheWeek,
                                      style: TextStyle(
                                        color: e.date == selectDate ||
                                                dayOfTheWeek == '오늘'
                                            ? Color.fromARGB(255, 7, 105, 254)
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
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => CupertinoActivityIndicator(),
            error: (error, stackTrace) => Text('error'),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 28.0,
                left: 16.0,
                right: 16.0,
              ),
              child: basicValue.when(
                data: (data) {
                  return ShaderMask(
                    shaderCallback: (Rect bound) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.transparent],
                          stops: [0.75, 1.0]).createShader(bound);
                    },
                    blendMode: BlendMode.dstIn,
                    child: ScrollConfiguration(
                      behavior:
                          MaterialScrollBehavior().copyWith(overscroll: false),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.38,
                        ),
                        itemCount: data[0].data.timeList.length + 6,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < data[0].data.timeList.length) {
                            return data[0].data.timeList[index].enabled == true
                                ? GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(SelectTimeProvider.notifier)
                                          .update((state) => data[0]
                                              .data
                                              .timeList[index]
                                              .timeSlot);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4),
                                      padding: EdgeInsets.all(
                                        14.0,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                        ),
                                        color: selectTime ==
                                                data[0]
                                                    .data
                                                    .timeList[index]
                                                    .timeSlot
                                            ? Color.fromARGB(255, 7, 105, 254)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data[0]
                                                .data
                                                .timeList[index]
                                                .timeSlot,
                                            style: TextStyle(
                                                color: selectTime ==
                                                        data[0]
                                                            .data
                                                            .timeList[index]
                                                            .timeSlot
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: deviceWidth / 22,
                                                fontWeight: selectTime ==
                                                        data[0]
                                                            .data
                                                            .timeList[index]
                                                            .timeSlot
                                                    ? FontWeight.w700
                                                    : FontWeight.w400),
                                          ),
                                          data[0]
                                                      .data
                                                      .timeList[index]
                                                      .stockCount >
                                                  5
                                              ? Text(
                                                  '가능',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 82, 255, 0),
                                                      fontSize:
                                                          deviceWidth / 26,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              : Text(
                                                  '매진임박',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize:
                                                          deviceWidth / 26,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.all(6),
                                    padding: EdgeInsets.all(
                                      16.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data[0].data.timeList[index].timeSlot,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 170, 170, 170),
                                              fontSize: deviceWidth / 22,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '매진',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 170, 170, 170),
                                              fontSize: deviceWidth / 26,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  );
                          } else {
                            return Container(); // 공백 아이템
                          }
                        },
                      ),
                    ),
                  );
                },
                loading: () => CupertinoActivityIndicator(),
                error: (error, stackTrace) {
                  print(error);
                  return Container();
                },
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                selectTime == ''
                    ? Color.fromARGB(255, 221, 221, 221)
                    : Color.fromARGB(255, 7, 105, 254),
              ),
              fixedSize: MaterialStateProperty.all(
                Size(
                  deviceWidth - 32,
                  deviceWidth / 7.4,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(deviceWidth / 2),
                ),
              ),
            ),
            onPressed: selectTime == ''
                ? null
                : () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(deviceWidth / 24),
                          topRight: Radius.circular(deviceWidth / 24),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 32.0,
                                left: 24,
                                right: 24,
                                bottom: 24,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '상품명',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 170, 170, 170),
                                          fontSize: deviceWidth / 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        basicValue.asData!.value[0].data
                                            .productDisplayName
                                            .replaceAll('\\n', '\n'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: deviceWidth / 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 12.0, bottom: 24.0),
                                    height: 0.2,
                                    color: Color.fromARGB(255, 206, 206, 206),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '날짜시간',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 170, 170, 170),
                                          fontSize: deviceWidth / 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '${DateFormat('yyyy.MM.dd (E)', 'ko_KR').format(
                                          DateTime.parse(
                                            selectDate,
                                          ),
                                        )} $selectTime',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: deviceWidth / 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 24.0, bottom: 24.0),
                                    height: 0.2,
                                    color: Color.fromARGB(255, 206, 206, 206),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '구매인원',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 170, 170, 170),
                                          fontSize: deviceWidth / 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '$numberOfPeopleToPurchaseValue명',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: deviceWidth / 26,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 24.0),
                                    height: 0.2,
                                    color: Color.fromARGB(255, 206, 206, 206),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 48.0, bottom: 48.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '총합계',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: deviceWidth / 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat('###,###,###,###원')
                                              .format(basicValue
                                                      .asData!
                                                      .value[0]
                                                      .data
                                                      .ticketSalePrice *
                                                  numberOfPeopleToPurchaseValue),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: deviceWidth / 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Color.fromARGB(255, 7, 105, 254),
                                      ),
                                      fixedSize: MaterialStateProperty.all(
                                        Size(
                                          deviceWidth,
                                          deviceWidth / 7.4,
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth / 2),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      '다음',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: deviceWidth / 22,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
            child: Text(
              '다음',
              style: TextStyle(
                color: selectTime == ''
                    ? Color.fromARGB(255, 170, 170, 170)
                    : Colors.white,
                fontSize: deviceWidth / 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
