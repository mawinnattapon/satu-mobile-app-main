import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';

class ScrollableTable extends StatefulWidget {
  final List<dynamic> tableLiter;
  final List<dynamic> tableGallon;
  final Function(List<dynamic> liter, List<dynamic> gallon)? onDataChanged;
  
  const ScrollableTable({
    super.key,
    required this.tableLiter,
    required this.tableGallon,
    this.onDataChanged,
  });

  @override
  State<ScrollableTable> createState() => _ScrollableTableState();
}

class _ScrollableTableState extends State<ScrollableTable> {
  // --- Controllers for Liter Table ---
  final List<TextEditingController> col1Liter = [];
  final List<TextEditingController> col2Liter = [];
  final List<TextEditingController> col3Liter = [];
  final List<TextEditingController> col4Liter = [];
  final List<TextEditingController> col5Liter = [];
  final List<TextEditingController> col6Liter = [];
  final List<TextEditingController> col7Liter = [];
  final List<TextEditingController> col8Liter = [];
  final List<TextEditingController> col9Liter = [];
  final List<TextEditingController> col10Liter = [];

  // --- Controllers for Gallon Table ---
  final List<TextEditingController> col1Gallon = [];
  final List<TextEditingController> col2Gallon = [];
  final List<TextEditingController> col3Gallon = [];
  final List<TextEditingController> col4Gallon = [];
  final List<TextEditingController> col5Gallon = [];
  final List<TextEditingController> col6Gallon = [];
  final List<TextEditingController> col7Gallon = [];
  final List<TextEditingController> col8Gallon = [];
  final List<TextEditingController> col9Gallon = [];
  final List<TextEditingController> col10Gallon = [];

  // --- Focus Nodes for Keyboard Navigation ---
  final List<List<FocusNode>> focusNodesLiter = [];
  final List<List<FocusNode>> focusNodesGallon = [];

  // --- Internal Data Models ---
  // These lists are guaranteed to have 10 rows to prevent index errors.
  late List<dynamic> processedLiterTable;
  late List<dynamic> processedGallonTable;

  @override
  void initState() {
    super.initState();
    _initializeDataAndControllers();
  }

  /// Initializes data by padding it to 10 rows and sets up all controllers.
  void _initializeDataAndControllers() {
    // 1. Pad data to ensure both tables always have 10 rows.
    // This prevents "RangeError" if the initial data has less than 10 rows.
    processedLiterTable = List.from(widget.tableLiter);
    while (processedLiterTable.length < 10) {
      // Add a default empty, editable row structure for Liter.
      processedLiterTable.add(List.generate(10, (_) => {'readonly': false, 'value': ''}));
    }

    processedGallonTable = List.from(widget.tableGallon);
    while (processedGallonTable.length < 10) {
      // Add a default empty, read-only row for Gallon as it's auto-calculated.
      processedGallonTable.add(List.generate(10, (_) => {'readonly': true, 'value': ''}));
    }
    
    // 2. Initialize all TextEditingControllers and FocusNodes for the 10 rows.
    _initControllers();
  }

  /// Sets up TextEditingControllers and FocusNodes for all 10 rows.
  void _initControllers() {
    const int numRows = 10;
    
    // Group controller lists for easier iteration.
    final allLiterControllers = [col1Liter, col2Liter, col3Liter, col4Liter, col5Liter, col6Liter, col7Liter, col8Liter, col9Liter, col10Liter];
    final allGallonControllers = [col1Gallon, col2Gallon, col3Gallon, col4Gallon, col5Gallon, col6Gallon, col7Gallon, col8Gallon, col9Gallon, col10Gallon];

    for (int i = 0; i < numRows; i++) {
      // Initialize Liter controllers using the padded data.
      for(int j = 0; j < allLiterControllers.length; j++) {
        allLiterControllers[j].add(TextEditingController(text: processedLiterTable[i][j]['value']));
      }
      focusNodesLiter.add(List.generate(10, (_) => FocusNode()));

      // Initialize Gallon controllers using the padded data.
      for(int j = 0; j < allGallonControllers.length; j++) {
        allGallonControllers[j].add(TextEditingController(text: processedGallonTable[i][j]['value']));
      }
      focusNodesGallon.add(List.generate(10, (_) => FocusNode()));
    }
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes to prevent memory leaks.
    final allControllers = [
      ...col1Liter, ...col2Liter, ...col3Liter, ...col4Liter, ...col5Liter, ...col6Liter, ...col7Liter, ...col8Liter, ...col9Liter, ...col10Liter,
      ...col1Gallon, ...col2Gallon, ...col3Gallon, ...col4Gallon, ...col5Gallon, ...col6Gallon, ...col7Gallon, ...col8Gallon, ...col9Gallon, ...col10Gallon,
    ];
    for (final controller in allControllers) {
      controller.dispose();
    }
    
    final allFocusNodes = [...focusNodesLiter.expand((e) => e), ...focusNodesGallon.expand((e) => e)];
    for (final node in allFocusNodes) {
      node.dispose();
    }
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('Table'),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FixedColumnWidth(50.0), 1: FixedColumnWidth(100.0),
              2: FixedColumnWidth(100.0), 3: FixedColumnWidth(100.0),
              4: FixedColumnWidth(100.0), 5: FixedColumnWidth(100.0),
              6: FixedColumnWidth(100.0), 7: FixedColumnWidth(100.0),
              8: FixedColumnWidth(100.0), 9: FixedColumnWidth(100.0),
              10: FixedColumnWidth(100.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            children: [
              // --- Main Header ---
              _buildHeaderRow(),
              // --- Unit Header ---
              _buildUnitHeaderRow(),
              // --- Liter Data Rows ---
              for (int i = 0; i < 10; i++) 
                _buildDataRowLiter(i, processedLiterTable[i]),
              // --- Gallon Unit Header ---
              _buildGallonUnitHeaderRow(),
              // --- Gallon Data Rows ---
              for (int i = 0; i < 10; i++) 
                _buildDataRowGallon(i, processedGallonTable[i]),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a data row for the Liter table.
  TableRow _buildDataRowLiter(int index, List<dynamic> tableLiterRow) {
    // NOTE: The logic to make rows 6-10 readonly is removed.
    // Editability is now controlled by the 'readonly' property from the data source,
    // except for auto-calculated columns.

    return TableRow(
      children: [
        Center(child: Padding(padding: const EdgeInsets.only(top: 10), child: Text('0${index + 1}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        _buildEditableCell(col1Liter[index], focusNodesLiter[index][0], index, tableLiterRow[0]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col2Liter[index], focusNodesLiter[index][1], index, tableLiterRow[1]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col3Liter[index], focusNodesLiter[index][2], index, tableLiterRow[2]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col4Liter[index], focusNodesLiter[index][3], index, true, tableSource: 'liter'), // Always readonly (auto-calculated)
        _buildEditableCell(col5Liter[index], focusNodesLiter[index][4], index, tableLiterRow[4]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col6Liter[index], focusNodesLiter[index][5], index, tableLiterRow[5]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col7Liter[index], focusNodesLiter[index][6], index, true, tableSource: 'liter'), // Always readonly (auto-calculated)
        _buildEditableCell(col8Liter[index], focusNodesLiter[index][7], index, tableLiterRow[7]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col9Liter[index], focusNodesLiter[index][8], index, tableLiterRow[8]['readonly'], tableSource: 'liter'),
        _buildEditableCell(col10Liter[index], focusNodesLiter[index][9], index, true, tableSource: 'liter'), // Always readonly (auto-calculated)
      ],
    );
  }

  /// Builds a data row for the Gallon table. All cells are read-only.
  TableRow _buildDataRowGallon(int index, List<dynamic> tableGallonRow) {
    return TableRow(
      children: [
        Center(child: Padding(padding: const EdgeInsets.only(top: 10), child: Text('0${index + 1}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        _buildEditableCell(col1Gallon[index], focusNodesGallon[index][0], index, true, tableSource: 'gallon'),
        _buildEditableCell(col2Gallon[index], focusNodesGallon[index][1], index, true, tableSource: 'gallon'),
        _buildEditableCell(col3Gallon[index], focusNodesGallon[index][2], index, true, tableSource: 'gallon'),
        _buildEditableCell(col4Gallon[index], focusNodesGallon[index][3], index, true, tableSource: 'gallon'),
        _buildEditableCell(col5Gallon[index], focusNodesGallon[index][4], index, true, tableSource: 'gallon'),
        _buildEditableCell(col6Gallon[index], focusNodesGallon[index][5], index, true, tableSource: 'gallon'),
        _buildEditableCell(col7Gallon[index], focusNodesGallon[index][6], index, true, tableSource: 'gallon'),
        _buildEditableCell(col8Gallon[index], focusNodesGallon[index][7], index, true, tableSource: 'gallon'),
        _buildEditableCell(col9Gallon[index], focusNodesGallon[index][8], index, true, tableSource: 'gallon'),
        _buildEditableCell(col10Gallon[index], focusNodesGallon[index][9], index, true, tableSource: 'gallon'),
      ],
    );
  }

  /// Generic cell builder for both tables.
  Widget _buildEditableCell(TextEditingController controller, FocusNode focusNode, int rowIndex, bool isReadOnly, {required String tableSource}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        fillColor: isReadOnly ? AppColor.grey.shade200 : AppColor.white,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.primary)),
      ),
      readOnly: isReadOnly,
      onChanged: (value) {
        // Calculations should only trigger when editing a non-readonly cell in the 'liter' table.
        if (!isReadOnly && tableSource == 'liter') {
          _calculateAllColumns(rowIndex);
        }
      },
      onFieldSubmitted: (value) {
        // Navigate to the next editable field in the same row when Enter/Done is pressed.
        if (tableSource == 'liter') {
            final focusableNodes = focusNodesLiter[rowIndex].where((node) {
                // Find next node that is not attached to a readonly field
                final cellIndex = focusNodesLiter[rowIndex].indexOf(node);
                final isCellLocked = processedLiterTable[rowIndex][cellIndex]['readonly'];
                // Columns 4, 7, 10 are always readonly
                final isAutoCalc = [3, 6, 9].contains(cellIndex);
                // The cell is focusable if it's not locked by data and not auto-calculated.
                return !(isCellLocked || isAutoCalc);
            }).toList();
            
            int currentFocusableIndex = focusableNodes.indexOf(focusNode);
            if (currentFocusableIndex != -1 && currentFocusableIndex < focusableNodes.length - 1) {
                FocusScope.of(context).requestFocus(focusableNodes[currentFocusableIndex + 1]);
            }
        }
      },
    );
  }
  
  /// Central calculation logic. Triggers on any change in an editable Liter cell.
  void _calculateAllColumns(int index) {
    // Helper to safely parse text from controllers to double.
    double? tryParse(TextEditingController controller) => double.tryParse(controller.text.replaceAll(',', ''));

    // --- Read editable values from Liter controllers ---
    final col1L = tryParse(col1Liter[index]);
    final col2L = tryParse(col2Liter[index]);
    final col3L = tryParse(col3Liter[index]);
    final col5L = tryParse(col5Liter[index]);
    final col6L = tryParse(col6Liter[index]);
    final col8L = tryParse(col8Liter[index]);
    final col9L = tryParse(col9Liter[index]);

    // --- Perform Auto-Calculations for Liter Table ---
    // Column 4 = Column 1 + Column 3
    final col4L = (col1L != null && col3L != null) ? (col1L + col3L) : null;
    // Column 7 = Column 5 - Column 6
    final col7L = (col5L != null && col6L != null) ? (col5L - col6L) : null;
    // Column 10 = (Column 3 / Column 4) * 100
    final col10L = (col3L != null && col4L != null && col4L != 0) ? (col3L / col4L * 100) : null;

    // --- Perform Unit Conversions to Gallon/PSI ---
    const literToGallon = 3.78541;
    const barToPsi = 14.5038;

    final col1G = col1L != null ? (col1L / literToGallon) : null;
    final col2G = col2L; // No conversion for rotation
    final col3G = col3L != null ? (col3L / literToGallon) : null;
    final col4G = col4L != null ? (col4L / literToGallon) : null;
    final col5G = col5L != null ? (col5L * barToPsi) : null;
    final col6G = col6L != null ? (col6L * barToPsi) : null;
    final col7G = col7L != null ? (col7L * barToPsi) : null;
    final col8G = col8L != null ? (col8L * barToPsi) : null;
    final col9G = col9L; // No conversion for percentage
    final col10G = col10L; // No conversion for percentage
    
    // Number formatter for consistent display.
    final format = NumberFormat("#,##0.00", "en_US");
    
    // Update UI controllers within setState to refresh the view.
    setState(() {
      // Update auto-calculated Liter columns
      col4Liter[index].text = col4L != null ? format.format(col4L) : '';
      col7Liter[index].text = col7L != null ? format.format(col7L) : '';
      col10Liter[index].text = col10L != null ? format.format(col10L) : '';

      // Update all Gallon columns
      col1Gallon[index].text = col1G != null ? format.format(col1G) : '';
      col2Gallon[index].text = col2G != null ? col2G.toStringAsFixed(0) : '';
      col3Gallon[index].text = col3G != null ? format.format(col3G) : '';
      col4Gallon[index].text = col4G != null ? format.format(col4G) : '';
      col5Gallon[index].text = col5G != null ? format.format(col5G) : '';
      col6Gallon[index].text = col6G != null ? format.format(col6G) : '';
      col7Gallon[index].text = col7G != null ? format.format(col7G) : '';
      col8Gallon[index].text = col8G != null ? format.format(col8G) : '';
      col9Gallon[index].text = col9G != null ? col9G.toStringAsFixed(2) : '';
      col10Gallon[index].text = col10G != null ? col10G.toStringAsFixed(2) : '';

      // Update the underlying data source. This is crucial for state persistence if you need to save the data.
      final allLiterValues = [col1L, col2L, col3L, col4L, col5L, col6L, col7L, col8L, col9L, col10L];
      for(int i = 0; i < allLiterValues.length; i++) {
        processedLiterTable[index][i]['value'] = allLiterValues[i]?.toString() ?? '';
      }
      final allGallonValues = [col1G, col2G, col3G, col4G, col5G, col6G, col7G, col8G, col9G, col10G];
       for(int i = 0; i < allGallonValues.length; i++) {
        processedGallonTable[index][i]['value'] = allGallonValues[i]?.toString() ?? '';
      }

      // Call the callback function to send updated table data back to parent widget
      if (widget.onDataChanged != null) {
        widget.onDataChanged!(processedLiterTable, processedGallonTable);
      }
    });
  }

  // --- UI Builder Helper Methods ---

  TableRow _buildHeaderRow() {
    return const TableRow(
      children: [
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Nr.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Flow rate of \nthe extinguishing water', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Rotation at \nwatermotor', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Flow rate of \nfoam agent', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Flow rate \ntotal', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Inlet \npressure', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Outlet \npressure', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Pressure \ndrop', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Back pressure at \nproport. pump', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Adjusted \n(target) \nproportion- \ning rate', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Proportion \nrate', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
      ],
    );
  }

  TableRow _buildUnitHeaderRow() {
     return TableRow(
      children: [
        const Center(child: Text('', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [RichText(text: TextSpan(text: 'Q', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.black), children: [WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('w', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold))))])), SizedBox(height: 1.h), const Text('[l/min]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [const Text('n', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 1.h), const Text('[min-1]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [RichText(text: TextSpan(text: 'Q', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.black), children: [WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('F', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold))))])), SizedBox(height: 1.h), const Text('[l/min]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [RichText(text: TextSpan(text: 'Q', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.black), children: [WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('G', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold)))), const TextSpan(text: '='), const TextSpan(text: 'Q', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black)), WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('w', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold)))), const TextSpan(text: '+'), const TextSpan(text: 'Q', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black)), WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('F', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold))))])), SizedBox(height: 1.h), const Text('[l/min]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [const Text('p1', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 1.h), const Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [const Text('p2', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 1.h), const Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [const Text('Δp', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 1.h), const Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [RichText(text: TextSpan(text: 'P', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.black), children: [WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('G', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold, fontSize: 13))))])), SizedBox(height: 1.h), const Text('[bar]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [RichText(text: TextSpan(text: 'Z', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.black), children: [WidgetSpan(child: Transform.translate(offset: const Offset(0.0, 4.0), child: Text('s', style: AppTextStyle.b3Style().copyWith(fontWeight: FontWeight.bold))))])), SizedBox(height: 1.h), const Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
        Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [const Text('Z', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 1.h), const Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))]))),
      ],
    );
  }

  TableRow _buildGallonUnitHeaderRow() {
    return const TableRow(
      children: [
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[gal/min..]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[gal/min..]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[gal/min..]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[psi_xxxx]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[psi_xxxx]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[psi_xxxx]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[psi_xxxx]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
        Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('[%]', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)))),
      ],
    );
  }
}