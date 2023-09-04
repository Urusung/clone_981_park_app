import 'package:clone_981_park_app/model/time_model.dart';
import 'package:clone_981_park_app/riverpod/ticket_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/time_proivder.dart';
import 'package:clone_981_park_app/screen/date_time_select_screen/date_time_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TicketTwoButtonWidget extends ConsumerWidget {
  const TicketTwoButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicValue = ref.watch(TimeProvider);
    final deviceWidth = MediaQuery.of(context).size.width;

    return Row(
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
                deviceWidth / 10,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(deviceWidth / 2),
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
                deviceWidth / 10,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(deviceWidth / 2),
              ),
            ),
          ),
          onPressed: () {
            ref.read(NumberOfPeopleToPurchaseProvider.notifier).state = 1;
            reservationInfomationShowModalBottomSheet(
                deviceWidth, context, basicValue);
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
    );
  }

  Future<dynamic> reservationInfomationShowModalBottomSheet(double deviceWidth,
      BuildContext context, AsyncValue<List<TimeModel>> basicValue) {
    return showModalBottomSheet(
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
          builder: (BuildContext context, ref, child) {
            final numberOfPeopleToPurchaseValue =
                ref.watch(NumberOfPeopleToPurchaseProvider);
            return Padding(
              padding: EdgeInsets.only(
                top: 42,
                left: 24,
                right: 24,
                bottom: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    basicValue.asData!.value[0].data.productDisplayName
                        .replaceAll('\\n', '\n'),
                    style: TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170),
                      fontSize: deviceWidth / 22,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    NumberFormat('###,###,###,###원').format(
                        basicValue.asData!.value[0].data.ticketSalePrice *
                            numberOfPeopleToPurchaseValue),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: deviceWidth / 12,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    height: 0.2,
                    color: Color.fromARGB(255, 206, 206, 206),
                  ),
                  Text(
                    '구매할 인원 선택헤주세요',
                    style: TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170),
                      fontSize: deviceWidth / 22,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: numberOfPeopleToPurchaseValue > 1
                            ? () {
                                ref
                                    .read(NumberOfPeopleToPurchaseProvider
                                        .notifier)
                                    .state--;
                              }
                            : null,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: SizedBox(
                          height: deviceWidth / 6,
                          width: deviceWidth / 6,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(deviceWidth / 40),
                              width: deviceWidth / 10,
                              height: deviceWidth / 10,
                              decoration: BoxDecoration(
                                color: numberOfPeopleToPurchaseValue == 1
                                    ? Color.fromARGB(255, 203, 203, 203)
                                    : Color.fromARGB(255, 7, 105, 254),
                                borderRadius: BorderRadius.circular(
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
                            numberOfPeopleToPurchaseValue.toString(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 105, 254),
                              fontSize: deviceWidth / 5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: numberOfPeopleToPurchaseValue < 8
                            ? () {
                                ref
                                    .read(NumberOfPeopleToPurchaseProvider
                                        .notifier)
                                    .state++;
                              }
                            : null,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: SizedBox(
                          height: deviceWidth / 6,
                          width: deviceWidth / 6,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(deviceWidth / 40),
                              width: deviceWidth / 10,
                              height: deviceWidth / 10,
                              decoration: BoxDecoration(
                                color: numberOfPeopleToPurchaseValue < 8
                                    ? Color.fromARGB(255, 7, 105, 254)
                                    : Color.fromARGB(255, 203, 203, 203),
                                borderRadius: BorderRadius.circular(
                                  deviceWidth / 12,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Divider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.white,
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
                      backgroundColor: MaterialStateProperty.all(
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
                          borderRadius: BorderRadius.circular(deviceWidth / 2),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DateTimeSelectScreen(),
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
  }
}
