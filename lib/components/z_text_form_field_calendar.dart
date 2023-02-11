import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef Null ValueChangeCallback(DateTime value);
typedef Null OnSavedChangeCallback(DateTime value);

bool isLight = true;
Color disabledBorderColor = isLight ? Color(0xFFE6E7EA) : Colors.black12;
Color enabledBorderColor = isLight ? Color(0xFFE8EBF7) : Colors.white38;
Color errorBorderColor = isLight ? Color(0xFFE20000) : Color(0xFFE20000);
Color focusedBorderColor = isLight ? Color(0xFF5A7EFF) : Colors.white;
Color focusedErrorBorderColor = isLight ? Color(0xFF5C00E4) : Color(0xFFE20000);

class ZTextFormFieldCalendar extends StatefulWidget {
  final AutovalidateMode? autovalidateMode;
  final Color? containerColor;
  final DateTime? initialValue;
  final String? Function(String?)? validator;
  final String labelText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;

  final ValueChangeCallback onSaved;
  final ValueChangeCallback onValueChanged;
  final bool isEnabled;
  final bool isNumberCurrencyInput;

  final bool readyOnly;
  final bool isTimeOnly;
  final bool isDateOnly;
  final int? maxLength;
  final int? maxLines;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final EdgeInsets? margin;
  final Widget? prefix;

  ZTextFormFieldCalendar(
      {required this.labelText,
      Key? key,
      this.autovalidateMode,
      this.containerColor,
      this.controller,
      this.initialValue,
      this.isEnabled = true,
      this.isNumberCurrencyInput = false,
      this.maxLength,
      this.maxLines,
      required this.onSaved,
      required this.onValueChanged,
      this.readyOnly = false,
      this.isTimeOnly = false,
      this.isDateOnly = false,
      this.textCapitalization,
      this.validator,
      this.firstDate,
      this.lastDate,
      this.prefix,
      this.margin})
      : super(key: key);

  @override
  _ZTextFormFieldCalendarState createState() => _ZTextFormFieldCalendarState();
}

class _ZTextFormFieldCalendarState extends State<ZTextFormFieldCalendar> {
  TextEditingController? valueController;
  DateTime? _date;
  FocusNode _focus = new FocusNode();
  TimeOfDay _time = TimeOfDay.now();
  BorderRadius borderRadius = BorderRadius.circular(10);

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _date = widget.initialValue!;
    }

    if (widget.controller != null) {
      valueController = widget.controller;
    }

    if (widget.controller == null) {
      if (widget.isTimeOnly) {
        valueController = TextEditingController.fromValue(TextEditingValue(text: timeFormatStr(TimeOfDay.fromDateTime(_date ?? DateTime.now()))));
        return;
      }

      if (widget.isDateOnly) {
        valueController = TextEditingController.fromValue(TextEditingValue(text: dateFormatStr(_date)));
        return;
      }

      valueController = TextEditingController.fromValue(TextEditingValue(text: dateTimeFormatStr(_date)));
    }

    _onFocusChange();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
              maxLength: widget.maxLength ?? null,
              maxLines: widget.maxLines ?? 1,
              enabled: widget.isEnabled,
              readOnly: true,
              onTap: () async {
                if (widget.isTimeOnly) return updateTimeValues();
                if (widget.isDateOnly) return updateDateValues();
                updateDateTimeValues();
              },
              onSaved: (String? value) {
                if (_date != null) widget.onSaved(_date!);
              },
              onChanged: (String? value) {
                if (_date != null) widget.onValueChanged(_date!);
              },
              focusNode: _focus,
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w400),
              textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
              controller: valueController,
              validator: widget.validator ??
                  (String? value) {
                    if (value != null && value.isEmpty) return 'This field is required';
                    return null;
                  },
              decoration: InputDecoration(
                  labelText: '${widget.labelText}',
                  prefixIcon: widget.prefix ?? null,
                  prefixStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                  fillColor: Colors.grey.shade100,
                  suffixStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                  labelStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: enabledBorderColor, width: 1), borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: focusedBorderColor, width: 1), borderRadius: borderRadius),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBorderColor, width: 1), borderRadius: borderRadius),
                  focusedErrorBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: focusedErrorBorderColor, width: 1), borderRadius: borderRadius),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: disabledBorderColor, width: 1), borderRadius: borderRadius),
                  isDense: true)),
        ],
      ),
    );
  }

  void updateDateTimeValues() async {
    DateTime _initialDate = widget.initialValue ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime _firstDate = widget.firstDate ?? DateTime(DateTime.now().day);
    DateTime _lastDate = widget.lastDate ?? DateTime(DateTime.now().year + 2);

    var day = await showDatePicker(useRootNavigator: true, context: context, initialDate: _initialDate, firstDate: _firstDate, lastDate: _lastDate);
    if (day == null) return;

    var time = await showTimePicker(initialTime: TimeOfDay.now(), useRootNavigator: true, context: context);
    if (time == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());

    DateTime dateTime = DateTime(day.year, day.month, day.day, time.hour, time.minute);
    _date = dateTime;
    valueController?.text = dateTimeFormatStr(_date);

    if (_date != null) widget.onValueChanged(_date!);
    setState(() {});
  }

  void updateDateValues() async {
    DateTime _initialDate = widget.initialValue ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime _firstDate = widget.firstDate ?? DateTime(DateTime.now().day);
    DateTime _lastDate = widget.lastDate ?? DateTime(DateTime.now().year + 2);

    var day = await showDatePicker(useRootNavigator: true, context: context, initialDate: _initialDate, firstDate: _firstDate, lastDate: _lastDate);
    if (day == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());

    DateTime dateTime = DateTime(day.year, day.month, day.day);
    _date = dateTime;
    valueController?.text = dateFormatStr(_date);

    if (_date != null) widget.onValueChanged(_date!);
    setState(() {});
  }

  void updateTimeValues() async {
    var result = await showTimePicker(initialTime: TimeOfDay.now(), useRootNavigator: true, context: context);
    if (result == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());

    _time = result;
    valueController?.text = timeFormatStr(_time);

    if (_date != null) widget.onValueChanged(_date!);
    setState(() {});
  }

  dateTimeFormatStr(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("MMM dd, yyyy 'at' h:mm a").format(dateTime);
  }

  dateFormatStr(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("MMM dd, yyyy").format(dateTime);
  }

  timeFormatStr(TimeOfDay? dateTime) {
    if (dateTime == null) return '';
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute).format(context).toString();
  }
}
