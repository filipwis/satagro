import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'table_page_state.dart';

@injectable
class TablePageCubit extends Cubit<TablePageState> {
  TablePageCubit() : super(TablePageLoading());

  final List<String> _rowHeaders = [
    'Wodór',
    'Hel',
    'Lit',
    'Beryl',
    'Fosfor',
    'Polon',
    'Srebro',
    'Węgiel'
  ];

  final List<int> _columnHeaders = List.generate(8, (index) => index + 1);

  final List<List<double>> _tableData = List.generate(
    8,
    (_) => List.generate(
      8,
      (_) => Random().nextDouble() * 100,
    ),
  );

  final List<SortOption> _rowsSortedBy =
      List.generate(8, (_) => SortOption.orginal);

  void init() {
    emit(TablePageIdle(
      columnHeaders: _columnHeaders,
      rowHeaders: _rowHeaders,
      tableData: _tableData,
    ));
  }

  void sortRow(int rowIndex) {
    List<List<double>> updatedTableData =
        _tableData.map((row) => List<double>.from(row)).toList();
    List<double> row = updatedTableData[rowIndex];

    switch (_rowsSortedBy[rowIndex]) {
      case SortOption.asc:
        row.sort((a, b) => b.compareTo(a));

        updatedTableData[rowIndex] = row;

        _rowsSortedBy[rowIndex] = SortOption.desc;

      case SortOption.desc:
        _rowsSortedBy[rowIndex] = SortOption.orginal;

      case SortOption.orginal:
        row.sort((a, b) => a.compareTo(b));

        updatedTableData[rowIndex] = row;

        _rowsSortedBy[rowIndex] = SortOption.asc;
    }

    if (state case final TablePageIdle state) {
      emit(state.copyWith(tableData: List.from(updatedTableData)));
    }
  }
}

enum SortOption {
  asc,
  desc,
  orginal,
}
