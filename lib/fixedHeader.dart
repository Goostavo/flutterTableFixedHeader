import 'package:flutter/material.dart';


class FixedHeaderTable extends StatefulWidget {
  FixedHeaderTable();

  FixedHeaderTableState createState() => new FixedHeaderTableState();
}
  class FixedHeaderTableState extends State<FixedHeaderTable>{

  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();
  final _columnHeader = "Corner";
  final _rowHeader = "Row";
  final totalRows = 20;
  final totalColumns = 20;

  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  List<int> _listOf(int count) => List.generate(count, (e) => e);

  Widget _buildFirstColumn() {
    return Material(
      color: Colors.lightBlueAccent,
      child: DataTable(
          columns: _listOf(1)
              .map((a) => DataColumn(label: Text(_columnHeader)))
              .toList(),
          rows: _listOf(totalRows)
              .map<DataRow>((row) => DataRow(
                    cells:
                        _listOf(1).map((a) => DataCell(Text("Column"))).toList(),
                  ))
              .toList()),
    );
  }

  Widget _buildFirstRow() {
    return Material(
      color: Colors.greenAccent,
      child: DataTable(
          columns: _listOf(totalColumns)
              .map((a) => DataColumn(label: Text(_rowHeader)))
              .toList(),
          rows: []),
    );
  }

  Widget _buildSubTable() {
    return Material(
      color: Colors.lightGreenAccent,
      child: DataTable(
          columns: _listOf(totalColumns)
              .map((a) => DataColumn(label: Text(_rowHeader)))
              .toList(),
          rows: _listOf(totalRows)
              .map<DataRow>((row) => DataRow(
                    cells: _listOf(totalRows)
                        .map((a) => DataCell(Text("Cell")))
                        .toList(),
                  ))
              .toList()),
    );
  }

  Widget _buildCornerCell() {
    return Material(
      color: Colors.amberAccent,
      child: DataTable(
          columns: _listOf(1)
              .map((a) => DataColumn(label: Text(_columnHeader)))
              .toList(),
          rows: []),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SingleChildScrollView(
                controller: _columnController,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                child: _buildFirstColumn(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  controller: _subTableXController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    controller: _subTableYController,
                    scrollDirection: Axis.vertical,
                    child: _buildSubTable(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _buildCornerCell(),
              Flexible(
                child: SingleChildScrollView(
                  controller: _rowController,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: _buildFirstRow(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}