import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Row(
        children: [
          MaterialButton(
            padding: const EdgeInsets.all(0),
            minWidth: 10,
            height: 10,
            onPressed: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/icon/arrow-left.svg', width: 10),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
