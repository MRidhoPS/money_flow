import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;
    final String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final String formattedDigits = _formatter.format(int.parse(digits));

    return TextEditingValue(
      text: formattedDigits,
      selection: TextSelection.collapsed(
        offset: formattedDigits.length - selectionIndexFromTheRight,
      ),
    );
  }
}
