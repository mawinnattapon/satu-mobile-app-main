// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:satu/constants/app.colors.dart';
// import 'package:satu/models/system/system.fromItem.model.dart';

// class ScrollableTable extends StatefulWidget {
//   final List<dynamic> tableLiter;
//   final List<dynamic> tableGallon;
//   const ScrollableTable({
//     super.key,
//     required this.tableLiter,
//     required this.tableGallon,
//   });

//   @override
//   State<ScrollableTable> createState() => _ScrollableTableState();
// }

// class _ScrollableTableState extends State<ScrollableTable> {
//   // tableLiter
//   List<TextEditingController> col1Liter = [];
//   List<TextEditingController> col2Liter = [];
//   List<TextEditingController> col3Liter = [];
//   List<TextEditingController> col4Liter = [];
//   List<TextEditingController> col5Liter = [];
//   List<TextEditingController> col6Liter = [];
//   List<TextEditingController> col7Liter = [];
//   List<TextEditingController> col8Liter = [];
//   List<TextEditingController> col9Liter = [];
//   List<TextEditingController> col10Liter = [];

//   // tableGallon
//   List<TextEditingController> col1Gallon = [];
//   List<TextEditingController> col2Gallon = [];
//   List<TextEditingController> col3Gallon = [];
//   List<TextEditingController> col4Gallon = [];
//   List<TextEditingController> col5Gallon = [];
//   List<TextEditingController> col6Gallon = [];
//   List<TextEditingController> col7Gallon = [];
//   List<TextEditingController> col8Gallon = [];
//   List<TextEditingController> col9Gallon = [];
//   List<TextEditingController> col10Gallon = [];
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   Future init() async {
//     for (int i = 0; i < widget.tableLiter.length; i++) {
//       col1Liter.add(TextEditingController());
//       col2Liter.add(TextEditingController());
//       col3Liter.add(TextEditingController());
//       col4Liter.add(TextEditingController());
//       col5Liter.add(TextEditingController());
//       col6Liter.add(TextEditingController());
//       col7Liter.add(TextEditingController());
//       col8Liter.add(TextEditingController());
//       col9Liter.add(TextEditingController());
//       col10Liter.add(TextEditingController());
//     }
//     for (int i = 0; i < widget.tableGallon.length; i++) {
//       col1Gallon.add(TextEditingController());
//       col2Gallon.add(TextEditingController());
//       col3Gallon.add(TextEditingController());
//       col4Gallon.add(TextEditingController());
//       col5Gallon.add(TextEditingController());
//       col6Gallon.add(TextEditingController());
//       col7Gallon.add(TextEditingController());
//       col8Gallon.add(TextEditingController());
//       col9Gallon.add(TextEditingController());
//       col10Gallon.add(TextEditingController());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(widget.tableLiter[0]);
//     // print('tableGallon ${widget.tableGallon[0]}');
//     return SingleChildScrollView(
//       key: const Key('Table'),
//       scrollDirection: Axis.horizontal,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Table(
//             border: TableBorder.all(),
//             columnWidths: const {
//               0: FixedColumnWidth(50.0),
//               1: FixedColumnWidth(100.0),
//               2: FixedColumnWidth(100.0),
//               3: FixedColumnWidth(100.0),
//               4: FixedColumnWidth(100.0),
//               5: FixedColumnWidth(100.0),
//               6: FixedColumnWidth(100.0),
//               7: FixedColumnWidth(100.0),
//               8: FixedColumnWidth(100.0),
//               9: FixedColumnWidth(100.0),
//               10: FixedColumnWidth(100.0),
//             },
//             defaultVerticalAlignment: TableCellVerticalAlignment.top,
//             children: [
//               // Table header
//               const TableRow(
//                 children: [
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Nr.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Flow rate of \nthe extinguishing water',
//                         textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child:
//                         Text('Rotation at \nwatermotor', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child:
//                         Text('Flow rate of \nfoam agent', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Flow rate \ntotal', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Inlet \npressure', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Outlet \npressure', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Pressure \ndrop', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Back pressure at \nproport. pump',
//                         textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Adjusted \n(target) \nproportioning \nrate',
//                         textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Proportion \nrate', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                 ],
//               ),
//               const TableRow(
//                 children: [
//                   Center(child: Text('', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('QW', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[l/min]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('n', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[min-1]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('QF', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[l/min]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('QG=QW+QF', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[l/min]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('p1', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('p2', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('Δp', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('pg', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('Zs', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('Z', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // Table rows with data
//               for (int i = 0; i < widget.tableLiter.length; i++) _buildDataRowLiter(i, widget.tableLiter[i]),
//               const TableRow(
//                 children: [
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[gal/min]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[gal/min]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[gal/min]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[psi]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[psi]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[psi]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[psi]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                   Center(
//                       child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                   )),
//                 ],
//               ),
//               for (int i = 0; i < widget.tableGallon.length; i++) _buildDataRowGallon(i, widget.tableGallon[i]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   TableRow _buildDataRowLiter(int index, List<dynamic> tableLiter) {
//     return TableRow(
//       children: [
//         Center(
//             child: Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Text(
//             '0${index + 1}',
//             textAlign: TextAlign.center,
//           ),
//         )),
//         _buildEditableCell(col1Liter[index], index, tableLiter[0]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col2Liter[index], index, tableLiter[1]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col3Liter[index], index, tableLiter[2]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col4Liter[index], index, tableLiter[3]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col5Liter[index], index, tableLiter[4]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col6Liter[index], index, tableLiter[5]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col7Liter[index], index, tableLiter[6]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col8Liter[index], index, tableLiter[7]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col9Liter[index], index, tableLiter[8]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//         _buildEditableCell(col10Liter[index], index, tableLiter[9]['readonly'],
//             valueL: tableLiter, valueG: widget.tableGallon[index]),
//       ],
//     );
//   }

//   TableRow _buildDataRowGallon(int index, List<dynamic> tableGallon) {
//     return TableRow(
//       children: [
//         Center(
//             child: Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Text(
//             '0${index + 1}',
//             textAlign: TextAlign.center,
//           ),
//         )),
//         _buildEditableCell(col1Gallon[index], index, tableGallon[0]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col2Gallon[index], index, tableGallon[1]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col3Gallon[index], index, tableGallon[2]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col4Gallon[index], index, tableGallon[3]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col5Gallon[index], index, tableGallon[4]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col6Gallon[index], index, tableGallon[5]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col7Gallon[index], index, tableGallon[6]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col8Gallon[index], index, tableGallon[7]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col9Gallon[index], index, tableGallon[8]['readonly'], valueL: [], valueG: []),
//         _buildEditableCell(col10Gallon[index], index, tableGallon[9]['readonly'], valueL: [], valueG: []),
//       ],
//     );
//   }

//   Widget _buildEditableCell(TextEditingController controller, int index, bool isEditable,
//       {required List<dynamic> valueL, required List<dynamic> valueG}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         fillColor: isEditable ? AppColor.grey.shade300 : null,
//         enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
//         border: const OutlineInputBorder(borderSide: BorderSide.none),
//         focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
//         disabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
//         errorBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
//         focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
//       ),
//       readOnly: isEditable,
//       onChanged: (value) {
//         if (!isEditable) {
//           calculateColumn4(index, valueL: valueL, valueG: valueG);
//           calculateColumn7(index, valueL: valueL, valueG: valueG);
//           calculateColumn10(index, valueL: valueL, valueG: valueG);
//         }
//         calculateColumn(index, valueL: valueL, valueG: valueG);
//       },
//     );
//   }

//   void calculateColumn(int index, {required List<dynamic> valueL, required List<dynamic> valueG}) {
//     double col1Value = double.tryParse(col1Liter[index].text) ?? 0;
//     double colG1Value = col1Value / 3.785;
//     double col2Value = double.tryParse(col2Liter[index].text) ?? 0;
//     double col3Value = double.tryParse(col3Liter[index].text) ?? 0;
//     double colG3Value = col3Value / 3.785;
//     double col5Value = double.tryParse(col5Liter[index].text) ?? 0;
//     double colG5Value = col5Value / 14.5038;
//     double col6Value = double.tryParse(col6Liter[index].text) ?? 0;
//     double colG6Value = col6Value / 14.5038;
//     double col8Value = double.tryParse(col8Liter[index].text) ?? 0;
//     double colG8Value = col8Value / 14.5038;
//     double col9Value = double.tryParse(col9Liter[index].text) ?? 0;

//     setState(() {
//       col1Gallon[index].text = colG1Value.toStringAsFixed(2);
//       col2Gallon[index].text = col2Value.toStringAsFixed(0);
//       col3Gallon[index].text = colG3Value.toStringAsFixed(2);
//       col5Gallon[index].text = colG5Value.toStringAsFixed(2);
//       col6Gallon[index].text = colG6Value.toStringAsFixed(2);
//       col8Gallon[index].text = colG8Value.toStringAsFixed(2);
//       col9Gallon[index].text = col9Value.toStringAsFixed(0);

//       valueL[0]['value'] = col1Value.toStringAsFixed(2);
//       valueL[1]['value'] = col2Value.toStringAsFixed(0);
//       valueL[2]['value'] = col3Value.toStringAsFixed(2);
//       valueL[4]['value'] = col5Value.toStringAsFixed(2);
//       valueL[5]['value'] = col6Value.toStringAsFixed(2);
//       valueL[7]['value'] = col8Value.toStringAsFixed(2);
//       valueL[8]['value'] = col9Value.toStringAsFixed(2);

//       valueG[0]['value'] = colG1Value.toStringAsFixed(2);
//       valueG[1]['value'] = col2Value.toStringAsFixed(0);
//       valueG[2]['value'] = colG3Value.toStringAsFixed(2);
//       valueG[4]['value'] = colG5Value.toStringAsFixed(2);
//       valueG[5]['value'] = colG6Value.toStringAsFixed(2);
//       valueG[7]['value'] = colG8Value.toStringAsFixed(2);
//       valueG[8]['value'] = col9Value.toStringAsFixed(2);
//     });
//   }

//   void calculateColumn4(int index, {required List<dynamic> valueL, required List<dynamic> valueG}) {
//     double col1Value = double.tryParse(col1Liter[index].text) ?? 0;
//     double col3Value = double.tryParse(col3Liter[index].text) ?? 0;
//     double col4Value = col1Value + col3Value;
//     double colG4Value = col4Value / 3.785;

//     setState(() {
//       col4Liter[index].text = col4Value.toStringAsFixed(2);
//       col4Gallon[index].text = colG4Value.toStringAsFixed(2);

//       valueL[3]['value'] = col4Value.toStringAsFixed(2);
//       valueG[3]['value'] = colG4Value.toStringAsFixed(2);
//     });
//   }

//   void calculateColumn7(int index, {required List<dynamic> valueL, required List<dynamic> valueG}) {
//     double col5Value = double.tryParse(col5Liter[index].text) ?? 0;
//     double col6Value = double.tryParse(col6Liter[index].text) ?? 0;
//     double col7Value = col5Value - col6Value;
//     double colG7Value = col7Value / 14.5038;

//     setState(() {
//       col7Liter[index].text = col7Value.toStringAsFixed(2);
//       col7Gallon[index].text = colG7Value.toStringAsFixed(2);

//       valueL[6]['value'] = col7Value.toStringAsFixed(2);
//       valueG[6]['value'] = colG7Value.toStringAsFixed(2);
//     });
//   }

//   void calculateColumn10(int index, {required List<dynamic> valueL, required List<dynamic> valueG}) {
//     double col3Value = double.tryParse(col3Liter[index].text) ?? 0;
//     double col4Value = double.tryParse(col4Liter[index].text) ?? 0;
//     double col10Value = col3Value / col4Value;

//     setState(() {
//       col10Liter[index].text = col10Value.isNaN ? '0.00' : col10Value.toStringAsFixed(2);
//       col10Gallon[index].text = col10Value.isNaN ? '0.00' : col10Value.toStringAsFixed(2);

//       valueL[9]['value'] = col10Value.isNaN ? '0.00' : col10Value.toStringAsFixed(2);
//       valueG[9]['value'] = col10Value.isNaN ? '0.00' : col10Value.toStringAsFixed(2);
//     });
//   }
// }
