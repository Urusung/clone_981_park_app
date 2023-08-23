import 'package:clone_981_park_app/riverpod/ticket_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/time_proivder.dart';
import 'package:clone_981_park_app/screen/date_time_select_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TicketSelectScreen extends ConsumerStatefulWidget {
  TicketSelectScreen({super.key});

  @override
  ConsumerState<TicketSelectScreen> createState() => _TicketSelectScreen();
}

class _TicketSelectScreen extends ConsumerState<TicketSelectScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final basicValue = ref.watch(TimeProvider);

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
        ),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              splashRadius: 24,
              icon: Icon(
                CupertinoIcons.chevron_left,
              ),
              onPressed: () {},
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
                  '1',
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
              '티켓 선택',
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
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: basicValue.when(
        data: (data) {
          return ListView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: deviceWidth / 9,
                                height: deviceWidth / 9,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                              ),
                              Text(
                                data[0]
                                    .data
                                    .productDisplayName
                                    .replaceAll('\\n', '\n'),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: deviceWidth / 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                NumberFormat('###,###,###,###')
                                        .format(data[0].data.ticketPrice) +
                                    '원',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Color.fromARGB(255, 206, 206, 206),
                                  fontSize: deviceWidth / 28,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 4.0,
                                ),
                              ),
                              Text(
                                NumberFormat('###,###,###,###')
                                        .format(data[0].data.ticketSalePrice) +
                                    '원',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: deviceWidth / 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      height: 0.2,
                      color: Color.fromARGB(255, 206, 206, 206),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 18.0, left: 18.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 210, 227, 255),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth / 16,
                                  height: deviceWidth / 16,
                                  padding: EdgeInsets.all(
                                    4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 7, 105, 254),
                                    borderRadius:
                                        BorderRadius.circular(deviceWidth / 8),
                                  ),
                                  child: Image.asset(
                                    'assets/images/wheel.png',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.0,
                                      right: 8.0,
                                      bottom: 4.0,
                                      left: 4.0),
                                  child: Text(
                                    'GR-E/D',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 7, 105, 254),
                                        fontSize: deviceWidth / 30,
                                        fontWeight: FontWeight.w400,
                                        height: 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 4.0,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 210, 227, 255),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth / 16,
                                  height: deviceWidth / 16,
                                  padding: EdgeInsets.all(
                                    4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 7, 105, 254),
                                    borderRadius:
                                        BorderRadius.circular(deviceWidth / 8),
                                  ),
                                  child: Image.asset(
                                    'assets/images/wheel.png',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.0,
                                      right: 8.0,
                                      bottom: 4.0,
                                      left: 4.0),
                                  child: Text(
                                    '초급,중급,중상급',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 7, 105, 254),
                                        fontSize: deviceWidth / 30,
                                        fontWeight: FontWeight.w400,
                                        height: 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 243, 243),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 16.0,
                                bottom: 16.0,
                                right: 10.0,
                                left: 10.0),
                            height: 0.2,
                            color: Color.fromARGB(255, 206, 206, 206),
                          ),
                        ),
                        Container(
                          width: 6,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 243, 243),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 248, 248, 248),
                              ),
                              fixedSize: MaterialStateProperty.all(
                                Size(
                                  deviceWidth / 2 - 36,
                                  deviceHeight / 18,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth / 2),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '자세히보기',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: deviceWidth / 28,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 105, 254),
                              ),
                              fixedSize: MaterialStateProperty.all(
                                Size(
                                  deviceWidth / 2 - 36,
                                  deviceHeight / 18,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth / 2),
                                ),
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(
                                      NumberOfPeopleToPurchaseProvider.notifier)
                                  .state = 1;
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(deviceWidth / 24),
                                    topRight: Radius.circular(deviceWidth / 24),
                                  ),
                                ),
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return Consumer(
                                    builder:
                                        (BuildContext context, ref, child) {
                                      final numberOfPeopleToPurchaseValue =
                                          ref.watch(
                                              NumberOfPeopleToPurchaseProvider);
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          top: 42,
                                          left: 24,
                                          right: 24,
                                          bottom: 24,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              basicValue.asData!.value[0].data
                                                  .productDisplayName
                                                  .replaceAll('\\n', '\n'),
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 170, 170, 170),
                                                fontSize: deviceWidth / 22,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
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
                                                fontSize: deviceWidth / 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 12.0, bottom: 12.0),
                                              height: 0.2,
                                              color: Color.fromARGB(
                                                  255, 206, 206, 206),
                                            ),
                                            Text(
                                              '구매할 인원 선택헤주세요',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 170, 170, 170),
                                                fontSize: deviceWidth / 22,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap:
                                                      numberOfPeopleToPurchaseValue >
                                                              1
                                                          ? () {
                                                              ref
                                                                  .read(NumberOfPeopleToPurchaseProvider
                                                                      .notifier)
                                                                  .state--;
                                                            }
                                                          : null,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(50),
                                                  ),
                                                  child: SizedBox(
                                                    height: deviceWidth / 6,
                                                    width: deviceWidth / 6,
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            deviceWidth / 40),
                                                        width: deviceWidth / 10,
                                                        height:
                                                            deviceWidth / 10,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              numberOfPeopleToPurchaseValue ==
                                                                      1
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          203,
                                                                          203,
                                                                          203)
                                                                  : Color
                                                                      .fromARGB(
                                                                          255,
                                                                          7,
                                                                          105,
                                                                          254),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            deviceWidth / 12,
                                                          ),
                                                        ),
                                                        child: Divider(
                                                          color: Colors.white,
                                                          thickness: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  width: deviceWidth / 3,
                                                  child: Center(
                                                    child: Text(
                                                      numberOfPeopleToPurchaseValue
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 7, 105, 254),
                                                        fontSize:
                                                            deviceWidth / 5,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap:
                                                      numberOfPeopleToPurchaseValue <
                                                              8
                                                          ? () {
                                                              ref
                                                                  .read(NumberOfPeopleToPurchaseProvider
                                                                      .notifier)
                                                                  .state++;
                                                            }
                                                          : null,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(50),
                                                  ),
                                                  child: SizedBox(
                                                    height: deviceWidth / 6,
                                                    width: deviceWidth / 6,
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            deviceWidth / 40),
                                                        width: deviceWidth / 10,
                                                        height:
                                                            deviceWidth / 10,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              numberOfPeopleToPurchaseValue <
                                                                      8
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          7,
                                                                          105,
                                                                          254)
                                                                  : Color
                                                                      .fromARGB(
                                                                          255,
                                                                          203,
                                                                          203,
                                                                          203),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            deviceWidth / 12,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Divider(
                                                              thickness: 2,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            VerticalDivider(
                                                              thickness: 2,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 7, 105, 254),
                                                ),
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                  Size(
                                                    deviceWidth,
                                                    deviceHeight / 16,
                                                  ),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            deviceWidth / 2),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DateTimeSelectScreen(),
                                                  ),
                                                );
                                              },
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
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Text(
                              '예약하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceWidth / 28,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => Center(
          child: CupertinoActivityIndicator(),
        ),
        error: (error, stackTrace) {
          print(error);
          return Container();
        },
      ),
    );
  }
}
