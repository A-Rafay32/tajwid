import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/app_text_field_themes.dart';
import 'package:tajwid/features/auth/screens/widgets/custom_text_field.dart';

class DatePickerField extends StatefulWidget {
  DatePickerField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
  });

  final String label;
  final String hint;
  TextEditingController controller;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  bool isDatePicked = false;
  void setText(String value) {
    setState(() {
      widget.controller.text = value;
      isDatePicked = true;
    });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(),
            scaffoldBackgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
              ).copyWith(secondary: AppColors.primaryColor),
              buttonColor: AppColors.primaryColor,
            ),
            textTheme: TextTheme(
              titleLarge: TextStyle(color: AppColors.primaryColor),
              bodyMedium: TextStyle(color: AppColors.primaryColor),
            ),
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
            ).copyWith(secondary: AppColors.primaryColor),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      fieldHintText: widget.hint,
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      setText("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onTap: () => selectDate(context),
      controller: widget.controller,
      inputDecoration: AppTextFieldDecorations.genericInputDecoration(
        hint: widget.hint,
        label: widget.label,
      ),
    );
  }
}

class TimePickerField extends StatefulWidget {
  const TimePickerField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
  });

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  bool isTimePicked = false;

  void setText(String value) {
    setState(() {
      widget.controller.text = value;
      isTimePicked = true;
    });
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: AppColors.primaryColor,
              dayPeriodTextColor: AppColors.primaryColor,
              dialHandColor: AppColors.primaryColor,
              entryModeIconColor: AppColors.primaryColor,
            ),
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              secondary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      setText("$hour:$minute");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onTap: () => selectTime(context),
      controller: widget.controller,
      inputDecoration: AppTextFieldDecorations.genericInputDecoration(
        hint: widget.hint,
        label: widget.label,
      ),
    );
  }
}
