import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommaToDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (newText.isNotEmpty && newText[newText.length - 1] == ',') {
      newText = newText.substring(0, newText.length - 1) + '.';
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class DecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith('.')) {
      return oldValue;
    }
    String newText = newValue.text;
    int commaIndex = newText.indexOf('.');
    if (commaIndex != -1) {
      newText = newText.substring(0, commaIndex + 1) +
          newText.substring(commaIndex + 1).replaceAll('.', '');
    }
    return newValue.copyWith(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}

class IntergerFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Xóa tất cả các dấu chấm trong chuỗi mới
    String newText = newValue.text.replaceAll('.', '');

    // Trả về giá trị mới sau khi loại bỏ dấu chấm
    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }
}

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###.###", "en_US");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    String newText = newValue.text;
    bool endsWithComma = newValue.text.endsWith('.');
    if (endsWithComma) {
      newText = newText.replaceAll(',', '').replaceAll('.', '');
    } else {
      newText = newText.replaceAll(',', '');
    }
    try {
      double value = double.parse(newText);
      String formattedValue = _formatter.format(value);
      if (endsWithComma) {
        formattedValue += '.';
      }

      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } catch (e) {
      return oldValue;
    }
  }
}

double convertToDouble(value) {
  if (value.endsWith('.')) {
    value = value.replaceAll(',', '').replaceAll('.', '');
    return double.parse(value);
  } else {
    value = value.replaceAll(',', '');
    return double.parse(value);
  }
}

int convertToInt(value) {
  value = value.replaceAll(',', '');
  return int.parse(value);
}

String convertToString(value) {
  final NumberFormat _formatter = NumberFormat("#,###.###", "en_US");
  return _formatter.format(value);
}
