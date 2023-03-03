import 'package:flutter/material.dart';
import 'dart:convert';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// Vamos precisar de uma aplicação com estado
class SorteiosListView extends StatefulWidget {
  @override
  _SorteiosListViewState createState() => _SorteiosListViewState();
}

class _SorteiosListViewState extends State<SorteiosListView> {
  bool loading = true;
  List<Sorteio> players = List<Sorteio>.empty(); // Lista dos players




  // Construtor, atualiza com setState a lista de filmes.
  _SorteiosListViewState() {
    API.getSorteios().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body); // Usamos um iterator
        players = lista.map((model) => Sorteio.fromJson(model)).toList();
        loading = false;
      });
    });
  }

  Future<List<Sorteio>> sorteioList() async {
    API.getSorteios().then((response) {
      Iterable lista = json.decode(response.body); // Usamos um iterator
      players = lista.map((model) => Sorteio.fromJson(model)).toList();
      loading = false;
    });
    return players;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("MIRUDUS"),
          ),
          body: FutureBuilder(
            future: getSorteioDataSource(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.hasData
                  ? SfDataGrid(
                  source: snapshot.data,
                  columnWidthMode: ColumnWidthMode.lastColumnFill,
                  columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
                  columns: getColumns())
                  : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );
            },
          ),
        ));
  }

  Future<SorteioDataGridSource> getSorteioDataSource() async {
    var sorteioList = await generateSorteioList();
    return SorteioDataGridSource(sorteioList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridTextColumn(
          columnName: 'date',
          label: Container(
              padding: EdgeInsets.all(18),
              alignment: Alignment.center,
              child: const Text('Data',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'time1',
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Time 1',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'media1',
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Média 1',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'time2',
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Time 2',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'media2',
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('Média 2',
                  overflow: TextOverflow.clip, softWrap: true))),


    ];
  }

  Future<List<Sorteio>> generateSorteioList() async {
    var response = await http.get(Uri.parse(
        '${baseUrl}list_sorteios.php'));
    var decodedSorteios =
    json.decode(response.body).cast<Map<String, dynamic>>();
    List<Sorteio> sorteioList = await decodedSorteios
        .map<Sorteio>((json) => Sorteio.fromJson(json))
        .toList();
    return sorteioList;
  }

}

class SorteioDataGridSource extends DataGridSource {
  SorteioDataGridSource(this.sorteioList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Sorteio> sorteioList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      )
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = sorteioList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'date', value: dataGridRow.date),
        DataGridCell<String>(
            columnName: 'time1', value: dataGridRow.time1),
        DataGridCell<String>(
            columnName: 'media1', value: dataGridRow.media1),
        DataGridCell<String>(
            columnName: 'time2', value: dataGridRow.time2),
        DataGridCell<String>(
            columnName: 'media2', value: dataGridRow.media2)
      ]);
    }).toList(growable: false);
  }
}
