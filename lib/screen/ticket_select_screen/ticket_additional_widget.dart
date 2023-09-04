import 'package:flutter/cupertino.dart';

class TicketAdditionalWidget extends StatelessWidget {
  const TicketAdditionalWidget({
    super.key,
    required this.data,
    required this.imageUrl,
  });

  final data;
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
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
              borderRadius: BorderRadius.circular(deviceWidth / 8),
            ),
            child: Image.asset(
              imageUrl,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 4.0, right: 8.0, bottom: 4.0, left: 4.0),
            child: Text(
              data,
              style: TextStyle(
                  color: Color.fromARGB(255, 7, 105, 254),
                  fontSize: deviceWidth / 30,
                  fontWeight: FontWeight.w400,
                  height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
