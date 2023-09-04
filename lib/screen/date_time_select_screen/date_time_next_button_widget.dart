import 'package:clone_981_park_app/model/time_model.dart';
import 'package:clone_981_park_app/riverpod/date_time_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/ticket_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/time_proivder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeNextButtonWidget extends ConsumerWidget {
  const DateTimeNextButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicValue = ref.watch(TimeProvider);
    final selectDate = ref.watch(SelectDateProvider);
    final selectTime = ref.watch(SelectTimeProvider);
    final numberOfPeopleToPurchaseValue =
        ref.read(NumberOfPeopleToPurchaseProvider);
    final deviceWidth = MediaQuery.of(context).size.width;

    return TextButton(
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
              buyInfomationShowModalBottomSheet(
                  deviceWidth,
                  context,
                  basicValue,
                  selectDate,
                  selectTime,
                  numberOfPeopleToPurchaseValue);
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
    );
  }

  Future<dynamic> buyInfomationShowModalBottomSheet(
      double deviceWidth,
      BuildContext context,
      AsyncValue<List<TimeModel>> basicValue,
      String selectDate,
      String selectTime,
      int numberOfPeopleToPurchaseValue) {
    return showModalBottomSheet(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '상품명',
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
                          fontSize: deviceWidth / 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        basicValue.asData!.value[0].data.productDisplayName
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
                    margin: EdgeInsets.only(top: 12.0, bottom: 24.0),
                    height: 0.2,
                    color: Color.fromARGB(255, 206, 206, 206),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '날짜시간',
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
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
                    margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
                    height: 0.2,
                    color: Color.fromARGB(255, 206, 206, 206),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '구매인원',
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
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
                    padding: EdgeInsets.only(top: 48.0, bottom: 48.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          NumberFormat('###,###,###,###원').format(
                              basicValue.asData!.value[0].data.ticketSalePrice *
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
  }
}
