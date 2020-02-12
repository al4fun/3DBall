import 'package:flutter/material.dart';
import 'horizontal_numberpicker.dart';

///对HorizontalNumberPicker进行简单包装，添加顶部的选中值显示和两边的半透明遮罩
// ignore: must_be_immutable
class HorizontalNumberPickerWrapper extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final String unit;

  ///控件的宽度
  final int widgetWidth;

  ///一大格中有多少个小格
  final int subGridCountPerGrid;

  ///每一小格的宽度
  final int subGridWidth;

  final void Function(int) onSelectedChanged;

  ///返回上方大标题所展示的数值字符串
  String Function(int) titleTransformer;

  ///返回标尺刻度所展示的数值字符串
  final String Function(int) scaleTransformer;

  ///标题文字颜色
  final Color titleTextColor;

  ///刻度颜色
  final Color scaleColor;

  ///指示器颜色
  final Color indicatorColor;

  ///刻度文字颜色
  final Color scaleTextColor;

  HorizontalNumberPickerWrapper({
    Key key,
    this.initialValue = 500,
    this.minValue = 100,
    this.maxValue = 900,
    this.step = 1,
    this.unit = "",
    this.widgetWidth = 200,
    this.subGridCountPerGrid = 10,
    this.subGridWidth = 8,
    @required this.onSelectedChanged,
    this.titleTransformer,
    this.scaleTransformer,
    this.titleTextColor = const Color(0xFF3995FF),
    this.scaleColor = const Color(0xFFE9E9E9),
    this.indicatorColor = const Color(0xFF3995FF),
    this.scaleTextColor = const Color(0xFF8E99A0),
  }) : super(key: key) {
    if (titleTransformer == null) {
      titleTransformer = (value) {
        return value.toString();
      };
    }
  }

  @override
  State<StatefulWidget> createState() {
    return HorizontalNumberPickerWrapperState();
  }
}

class HorizontalNumberPickerWrapperState
    extends State<HorizontalNumberPickerWrapper> {
  int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  ///处理state的复用
  void didUpdateWidget(HorizontalNumberPickerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    int numberPickerHeight = 60;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //上方选中值
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(
              widget.titleTransformer(_selectedValue),
              style: TextStyle(
                color: widget.titleTextColor,
                fontSize: 40,
                //fontFamily: "Montserrat",
              ),
            ),
            Text(
              ' ${widget.unit}',
              style: TextStyle(
                color: widget.titleTextColor,
                fontSize: 14,
                //fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
        Container(width: 0, height: 10),
        //可滚动标尺
        Stack(
          children: <Widget>[
            HorizontalNumberPicker(
              initialValue: widget.initialValue,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              step: widget.step,
              widgetWidth: widget.widgetWidth,
              widgetHeight: numberPickerHeight,
              subGridCountPerGrid: widget.subGridCountPerGrid,
              subGridWidth: widget.subGridWidth,
              onSelectedChanged: (value) {
                widget.onSelectedChanged(value);
                setState(() {
                  _selectedValue = value;
                });
              },
              scaleTransformer: widget.scaleTransformer,
              scaleColor: widget.scaleColor,
              indicatorColor: widget.indicatorColor,
              scaleTextColor: widget.scaleTextColor,
            ),
            //左右半透明遮罩
            Positioned(
              left: 0,
              child: Container(
                width: 20,
                height: numberPickerHeight.toDouble(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0)
                  ]),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 20,
                height: numberPickerHeight.toDouble(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.8)
                  ]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
