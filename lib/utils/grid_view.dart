import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  Iterable<Widget> children = [];
  int columnCount;

  CustomGridView({this.columnCount = 2, required this.children});

  @override
  Widget build(BuildContext context) {
    return buildTableView();
  }

  List<TableRow> getColumChildren() {
    List<List<Widget>> rowLists = getRowList();
    List<TableRow> columnList = [];
    for (int i = 0; i < rowLists.length; i++) {
      columnList.add(getRowChildren(rowLists[i]));
    }
    return columnList;
  }

  TableRow getRowChildren(List<Widget> rowChildren) {
    return TableRow(children: rowChildren);
  }

  Widget buildTableView() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: getColumChildren(),
    );
  }

  List<List<Widget>> getRowList() {
    List<List<Widget>> widgetList = [];
    List<Widget> widgetRowList = [];

    for (Widget widget in children) {
      widgetRowList.add(widget);
      if (widgetRowList.length == columnCount) {
        widgetList.add(new List<Widget>.from(widgetRowList));
        widgetRowList.clear();
      }
    }

    if (widgetRowList.isNotEmpty) {
      widgetList.add(new List<Widget>.from(widgetRowList));
      widgetRowList.clear();
    }

    return widgetList;
  }
}
