part of 'table_page_cubit.dart';

sealed class TablePageState {}

final class TablePageLoading extends TablePageState {}

final class TablePageIdle extends TablePageState {
  TablePageIdle({
    required this.columnHeaders,
    required this.rowHeaders,
    required this.tableData,
  });

  TablePageIdle copyWith({
    List<int>? columnHeaders,
    List<String>? rowHeaders,
    List<List<double>>? tableData,
  }) {
    return TablePageIdle(
      columnHeaders: columnHeaders ?? this.columnHeaders,
      rowHeaders: rowHeaders ?? this.rowHeaders,
      tableData: tableData ?? this.tableData,
    );
  }

  final List<int> columnHeaders;
  final List<String> rowHeaders;
  final List<List<double>> tableData;
}
