import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/material.dart';

Widget dataPrintList(){
  return DataTable(
    headingRowColor: MaterialStateColor.resolveWith((states) => btnBgVerColor),
    dataRowHeight: 40,
    columnSpacing: 20,
    // horizontalMargin: 20,
    columns: const [
      DataColumn(label: Text('TYPE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_SMALL))),
      DataColumn(label: Text('BARCODE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_SMALL))),
      DataColumn(label: Text('CODE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_SMALL))),
      DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_SMALL))),
      DataColumn(label: Text('MD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_SMALL)))
    ],
    rows: List<DataRow>.generate(
          20,
          (index) => DataRow(
                  color: MaterialStateProperty.resolveWith<Color>( (Set<MaterialState> states) {
                        if (index % 2 == 0) {
                          return const Color.fromARGB(255, 210, 210, 210).withOpacity(0.3);
                        }
                        return const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3);
                  }),
                  cells: const [
                    DataCell(Text('PIN')),
                    DataCell(Text('8851123212021')),
                    DataCell(Text('100572635')),
                    DataCell(Text('BP เครื่องดื่ม M-150')),
                    DataCell(Text('BP เครื่องดื่ม M-150'))
                  ]
          ),
    ),
  );
}