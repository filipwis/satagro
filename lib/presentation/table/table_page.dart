import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:satagro/presentation/style/dimensions.dart';
import 'package:satagro/presentation/table/cubit/table_page_cubit.dart';

class TablePage extends HookWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<TablePageCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(() {
      cubit.init();
      return null;
    }, [cubit]);

    final controllerHorizontal = useScrollController();
    final controllerVertical = useScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Cel 2'),
        centerTitle: true,
      ),
      body: switch (state) {
        TablePageIdle(
          :final columnHeaders,
          :final rowHeaders,
          :final tableData,
        ) =>
          DataTable2(
            fixedTopRows: 1,
            scrollController: controllerVertical,
            fixedLeftColumns: 1,
            horizontalScrollController: controllerHorizontal,
            minWidth: 1000,
            dividerThickness: 0.6,
            dataRowHeight: 90,
            columns: [
              DataColumn(
                label: Text(''),
              ),
              ...columnHeaders.map(
                (col) => DataColumn2(
                  numeric: true,
                  label: Text(
                    col.toString(),
                  ),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              rowHeaders.length,
              (rowIndex) => DataRow(
                cells: [
                  DataCell(
                    onTap: () => cubit.sortRow(rowIndex),
                    Row(
                      children: [
                        Text(
                          rowHeaders[rowIndex],
                        ),
                        SizedBox(width: Dimensions.v8),
                        Icon(Icons.sort_outlined),
                      ],
                    ),
                  ),
                  ...tableData[rowIndex]
                      .map((val) => DataCell(Text(val.toStringAsFixed(2)))),
                ],
              ),
            ),
          ),
        TablePageLoading() => Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
