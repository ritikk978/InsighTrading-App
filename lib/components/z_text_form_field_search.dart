import 'package:insigh/components/z_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

typedef Null ValueChangeCallback(String value);

class ZSearch extends StatefulWidget {
  const ZSearch({Key? key, this.onValueChanged, this.controller, this.initialValue, this.margin}) : super(key: key);
  final ValueChangeCallback? onValueChanged;
  final TextEditingController? controller;
  final String? initialValue;
  final EdgeInsets? margin;

  @override
  State<ZSearch> createState() => _ZSearchState();
}

class _ZSearchState extends State<ZSearch> {
  TextEditingController? valueController;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    print('initState');
    valueController = widget.controller ?? TextEditingController.fromValue(TextEditingValue(text: widget.initialValue ?? ""));
    valueController?.addListener(() {
      if (widget.onValueChanged != null) widget.onValueChanged!(valueController?.text ?? '');
      setState(() {});
    });
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ZCard(
        margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadiusColor: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(14),
        color: isLightTheme ? Colors.grey.shade100 : Colors.grey.shade900,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade400, size: 16),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                onChanged: (v) {
                  if (widget.onValueChanged != null) widget.onValueChanged!(v);
                },
                cursorColor: Colors.grey.shade400,
                cursorHeight: 14,
                controller: valueController,
                decoration: InputDecoration(
                  hintText: 'Search signals...',
                  hintStyle: TextStyle(fontSize: 13),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 2),
                ),
              ),
            ),
            getSuffixIcon()
          ],
        ));
  }

  getSuffixIcon() {
    if (valueController?.text != null && valueController!.text.length > 0)
      return ZCard(
        color: Colors.transparent,
        onTap: () {
          valueController?.clear();
          if (widget.onValueChanged != null) widget.onValueChanged!('');
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {});
        },
        borderRadius: BorderRadius.circular(100),
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.only(bottom: 3),
        child: Icon(AntDesign.closecircle, color: Colors.grey.shade600, size: 16),
      );

    return Container();
  }
}
