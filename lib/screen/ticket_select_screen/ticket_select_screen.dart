import 'package:clone_981_park_app/riverpod/time_proivder.dart';
import 'package:clone_981_park_app/screen/ticket_select_screen/ticket_additional_widget.dart';
import 'package:clone_981_park_app/screen/ticket_select_screen/ticket_informaion_widget.dart';
import 'package:clone_981_park_app/screen/ticket_select_screen/ticket_two_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketSelectScreen extends ConsumerWidget {
  const TicketSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicValue = ref.watch(TimeProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
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
                    TicketInformaionWidget(
                        data: data, deviceWidth: deviceWidth),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      height: 0.2,
                      color: Color.fromARGB(255, 206, 206, 206),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 18.0, left: 18.0),
                      child: Row(
                        children: [
                          TicketAdditionalWidget(
                            data: 'GR-E/D',
                            imageUrl: 'assets/images/handle.png',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 4.0,
                            ),
                          ),
                          TicketAdditionalWidget(
                            data: '초급,중급,중상급',
                            imageUrl: 'assets/images/wheel.png',
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
                      child: TicketTwoButtonWidget(),
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
