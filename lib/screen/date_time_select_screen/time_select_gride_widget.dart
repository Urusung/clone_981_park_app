import 'package:clone_981_park_app/riverpod/date_time_select_screen_provider.dart';
import 'package:clone_981_park_app/riverpod/time_proivder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSelectGrideWidget extends ConsumerWidget {
  const TimeSelectGrideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectTime = ref.watch(SelectTimeProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final basicValue = ref.watch(TimeProvider);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          top: 28.0,
          left: 16.0,
          right: 16.0,
        ),
        child: basicValue.when(
          data: (data) {
            return ShaderMask(
              shaderCallback: (Rect bound) {
                return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.transparent],
                    stops: [0.75, 1.0]).createShader(bound);
              },
              blendMode: BlendMode.dstIn,
              child: ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.38,
                  ),
                  itemCount: data[0].data.timeList.length + 6,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < data[0].data.timeList.length) {
                      return data[0].data.timeList[index].enabled == true
                          ? GestureDetector(
                              onTap: () {
                                ref.read(SelectTimeProvider.notifier).update(
                                    (state) =>
                                        data[0].data.timeList[index].timeSlot);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(
                                  14.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                  ),
                                  color: selectTime ==
                                          data[0].data.timeList[index].timeSlot
                                      ? const Color.fromARGB(255, 7, 105, 254)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data[0].data.timeList[index].timeSlot,
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
                                    data[0].data.timeList[index].stockCount > 5
                                        ? Text(
                                            '가능',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 82, 255, 0),
                                                fontSize: deviceWidth / 26,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : Text(
                                            '매진임박',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: deviceWidth / 26,
                                                fontWeight: FontWeight.w400),
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.all(
                                16.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 221, 221, 221),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data[0].data.timeList[index].timeSlot,
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                        fontSize: deviceWidth / 22,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '매진',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
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
          loading: () => const CupertinoActivityIndicator(),
          error: (error, stackTrace) {
            print(error);
            return Container();
          },
        ),
      ),
    );
  }
}
