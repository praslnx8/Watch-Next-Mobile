import 'package:flutter/material.dart';

class AppbarDropDownWidget extends StatefulWidget {
  @override
  _AppbarDropDownState createState() => _AppbarDropDownState();
}

class _AppbarDropDownState extends State<AppbarDropDownWidget> {
  final _dropDownValues = ["Movies", "TV Series"];
  var _value = "";

  @override
  void initState() {
    super.initState();
    _value = _dropDownValues[0];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _value,
          iconEnabledColor: Colors.white,
          items: _dropDownValues
              .map((value) => DropdownMenuItem(
            child: Text(value),
            value: value,
          ))
              .toList(),
          onChanged: (String value) {
            setState(() => _value = value);
          },
        ),
      ),
    );
  }
}
