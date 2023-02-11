import 'package:flutter/material.dart';

typedef Null OnValueChangeCallBack(String value);
typedef Null OnSavedChangeCallback(String value);

class ZTextFormFieldBottomSheet extends StatefulWidget {
  final List<String> items;
  final OnValueChangeCallBack onValueChanged;
  final String hint;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final OnSavedChangeCallback? onSaved;
  final EdgeInsets? margin;
  final AutovalidateMode? autovalidateMode;

  ZTextFormFieldBottomSheet({
    Key? key,
    required this.hint,
    required this.items,
    this.controller,
    this.isEnabled = true,
    required this.onValueChanged,
    this.onSaved,
    this.initialValue,
    this.validator,
    this.margin,
    this.autovalidateMode,
  }) : super(key: key);

  _ZTextFormFieldBottomSheetState createState() => _ZTextFormFieldBottomSheetState();
}

class _ZTextFormFieldBottomSheetState extends State<ZTextFormFieldBottomSheet> {
  String _selectedVal = '';
  BorderRadius borderRadius = BorderRadius.circular(10);
  Color disabledBorderColor = Color(0xFFE6E7EA);
  Color enabledBorderColor = Color(0xFFE8EBF7);
  Color errorBorderColor = Color(0xFFE20000);
  Color focusedBorderColor = Color(0xFF5A7EFF);
  Color focusedErrorBorderColor = Color(0xFF5C00E4);

  TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    _selectedVal = widget.initialValue ?? widget.items[0];
    valueController = widget.controller ?? TextEditingController.fromValue(TextEditingValue(text: widget.initialValue ?? ""));
    valueController.addListener(() {
      widget.onValueChanged(valueController.text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextFormField(
        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
        maxLines: null,
        controller: valueController,
        autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
        enabled: true,
        readOnly: true,
        onSaved: (String? value) {
          if (widget.onSaved != null) {
            widget.onSaved!(value ?? '');
          }
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        obscureText: false,
        onTap: () {
          if (widget.isEnabled) {
            _showModalBottomSheet(context: context);
          }
        },
        validator: widget.validator ??
            (String? value) {
              if (value != null && value.isEmpty) return 'This field is required';
              return null;
            },
        decoration: InputDecoration(
            labelText: '${widget.hint}',
            prefixStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
            fillColor: Colors.grey.shade100,
            suffixIcon: Icon(Icons.arrow_drop_down),
            suffixStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
            labelStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: enabledBorderColor, width: 1), borderRadius: borderRadius),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: focusedBorderColor, width: 1), borderRadius: borderRadius),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBorderColor, width: 1), borderRadius: borderRadius),
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: focusedErrorBorderColor, width: 1), borderRadius: borderRadius),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: disabledBorderColor, width: 1), borderRadius: borderRadius),
            isDense: true),
      ),
    );
  }

  void _showModalBottomSheet({context}) {
    showModalBottomSheet(
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Scrollbar(
              child: ListView(shrinkWrap: true, padding: EdgeInsets.all(0), children: [
                for (var item in widget.items)
                  Column(
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              widget.items.indexOf(item) == 0 ? BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)) : null,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              item,
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          onTap: () {
                            _selectedVal = item;
                            valueController.text = item;
                            widget.onValueChanged(_selectedVal);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Divider(height: 0, color: Colors.black12)
                    ],
                  ),
                SizedBox(height: 25)
              ]),
            ),
          );
        });
  }
}
