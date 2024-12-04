import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../models/models.dart';

class DialogUtils {
  //
  // ** For Loading Process
  //
  static void showLoadingAnimation({
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Builder(builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xffDE221A),
            strokeCap: StrokeCap.round,
          ),
        );
      }),
    );
  }

  // ** For Notifition

  static void showToastAnimation({
    required DialogModel dialog,
    required BuildContext context,
  }) {
    showToastWidget(
      Container(
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 5,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: (dialog.isSuccess)
                      ? const Color(0xff017A39)
                      : const Color(0xffD50525),
                  borderRadius: BorderRadius.circular(
                      10)), // Set a width for the divider effect
            ),
            Text(
              dialog.message,
              style: const TextStyle(
                  color: Color(0xff1B1B1B),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 3),
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeOutBack,
    );
  }

  // //
  // // ** For Cormfim Action
  // //
  static void showConfirmDialog({
    required Widget widget,
    required VoidCallback callback,
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(25),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget,
                SizedBox(height: 20), // Khoảng trống giữa widget và buttons
                Row(
                  children: [
                    Expanded(
                      // Expanded cho button 1
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            callback();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets
                                .zero, // Loại bỏ padding của ElevatedButton
                            backgroundColor: Color(0xffDE221A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Xác nhận',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Khoảng trống giữa 2 buttons
                    Expanded(
                      // Expanded cho button 2
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 20),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets
                                .zero, // Loại bỏ padding của ElevatedButton
                            // backgroundColor: const Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: Color(0xffDE221A),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'Huỷ bỏ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffDE221A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //
  //* For Alert
  //
  static Future showBottomDialog(
      {required BuildContext context, required String message}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Lỗi',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              content: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                )
              ],
            ));
  }

  //
  //* For show Image
  static void showImagePopup(
      {required BuildContext context, required String imageFile}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Image.memory(base64Decode(imageFile)),
          ),
        );
      },
    );
  }
}
