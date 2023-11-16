import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketInformaionWidget extends StatelessWidget {
  const TicketInformaionWidget({
    super.key,
    required this.data,
    required this.deviceWidth,
  });

  final data;
  final deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
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
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
              ),
              Text(
                data[0].data.productDisplayName.replaceAll('\\n', '\n'),
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
                '${NumberFormat('###,###,###,###').format(data[0].data.ticketPrice)}원',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: const Color.fromARGB(255, 206, 206, 206),
                  fontSize: deviceWidth / 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 4.0,
                ),
              ),
              Text(
                '${NumberFormat('###,###,###,###').format(data[0].data.ticketSalePrice)}원',
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
    );
  }
}
