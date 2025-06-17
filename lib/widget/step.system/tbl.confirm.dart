import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/library/button.dart';
import 'package:satu/library/loading.dart';
import 'package:satu/modules/controller/systeminfo.ctrl.dart';
import 'package:satu/utils/date_util.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class TblConfirm extends StatefulWidget {
  final List<dynamic> name;
  final List<dynamic> signature;
  final List<dynamic> company;
  final List<dynamic> date;
  const TblConfirm({super.key, required this.name, required this.signature, required this.company, required this.date});

  @override
  State<TblConfirm> createState() => _TblConfirmState();
}

class _TblConfirmState extends State<TblConfirm> {
  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  final systemCtrl = SystemInfoController.instance;

  List<TextEditingController> colN1 = [];
  List<TextEditingController> colN2 = [];
  List<TextEditingController> colN3 = [];
  List<TextEditingController> colN4 = [];

  List<TextEditingController> colC1 = [];
  List<TextEditingController> colC2 = [];
  List<TextEditingController> colC3 = [];
  List<TextEditingController> colC4 = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    for (int i = 0; i < widget.name.length; i++) {
      colN1.add(TextEditingController(text: widget.name[0]['value']));
      colN2.add(TextEditingController(text: widget.name[1]['value']));
      colN3.add(TextEditingController(text: widget.name[2]['value']));
      colN4.add(TextEditingController(text: widget.name[3]['value']));
    }
    for (int i = 0; i < widget.company.length; i++) {
      colC1.add(TextEditingController(text: widget.company[0]['value']));
      colC2.add(TextEditingController(text: widget.company[1]['value']));
      colC3.add(TextEditingController(text: widget.company[2]['value']));
      colC4.add(TextEditingController(text: widget.company[3]['value']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      // columnWidths: const {
      //   0: FixedColumnWidth(160.0),
      //   1: FixedColumnWidth(160.0),
      //   2: FixedColumnWidth(160.0),
      //   3: FixedColumnWidth(160.0),
      //   4: FixedColumnWidth(160.0),
      // },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        for (int i = 0; i < 1; i++) _buildDataRowName(i),
        for (int i = 0; i < 1; i++) _buildDataRowSignature(i),
        for (int i = 0; i < 1; i++) _buildDataRowConpany(i),
        for (int i = 0; i < 1; i++) _buildDataRowDate(i),
      ],
    );
  }

  TableRow _buildDataRowName(int index) {
    return TableRow(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Text('Name', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        _buildEditableCell(colN1[index], 0, data: widget.name),
        _buildEditableCell(colN2[index], 1, data: widget.name),
        _buildEditableCell(colN3[index], 2, data: widget.name),
        _buildEditableCell(colN4[index], 3, data: widget.name),
      ],
    );
  }

  TableRow _buildDataRowSignature(int index) {
    return TableRow(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Text('Signature', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        for (int i = 0; i < widget.signature.length; i++) _buildEditableSignature(i),
      ],
    );
  }

  TableRow _buildDataRowConpany(int index) {
    return TableRow(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Text('Company', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        _buildEditableCell(colC1[index], 0, data: widget.company),
        _buildEditableCell(colC2[index], 1, data: widget.company),
        _buildEditableCell(colC3[index], 2, data: widget.company),
        _buildEditableCell(colC4[index], 3, data: widget.company),
      ],
    );
  }

  TableRow _buildDataRowDate(int index) {
    return TableRow(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Text('Date', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        for (int i = 0; i < widget.date.length; i++) _buildEditableDate(i),
      ],
    );
  }

  Widget _buildEditableCell(TextEditingController controller, int index, {required List<dynamic> data}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
      onChanged: (value) {
        setState(() {
          data[index]['value'] = value;
        });
      },
    );
  }

  Widget _buildEditableSignature(int index) {
    return Stack(
      children: [
        Container(
          height: 15.h,
          width: double.infinity,
          color: AppColor.grey.shade200,
          child: widget.signature[index]['value'] == null ? null : Image.network(widget.signature[index]['value']),
        ),
        widget.signature[index]['value'] != null
            ? Container()
            : Positioned(
                bottom: 1,
                right: 1,
                top: 1,
                left: 1,
                child: Button(
                    color: ButtonColor.transparent,
                    child: const Icon(
                      Icons.edit_square,
                      size: 35,
                    ),
                    onPressed: () async {
                      handleSaveButtonPressed(
                        (signatures) async {
                          Loading.show();
                          String? dataImage =
                              await systemCtrl.fetchUploadsignature(imagebytes: signatures.buffer.asUint8List());
                          if (dataImage != null) {
                            setState(() {
                              widget.signature[index]['value'] = dataImage;
                              widget.date[index]['value'] = DateUtil.dateDay(DateTime.now().toString());
                            });
                          }
                          Loading.close();
                        },
                      );
                    }),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Button(
              color: ButtonColor.transparent,
              child: const Icon(
                Icons.delete,
                size: 25,
              ),
              onPressed: () async {
                setState(() {
                  widget.signature[index]['value'] = null;
                  widget.date[index]['value'] = null;
                });
              }),
        ),
      ],
    );
  }

  Widget _buildEditableDate(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          '${widget.date[index]['value'] ?? ""}',
          style: AppTextStyle.b3Style(),
        ),
      ),
    );
  }

  Future<dynamic> handleSaveButtonPressed(void Function(ByteData) onSave) {
    return Get.dialog(
      Container(
        margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(30),
        decoration: ShapeDecoration(
          color: AppColor.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        child: Stack(
          children: [
            SfSignaturePad(
              key: signaturePadKey,
              backgroundColor: AppColor.grey.shade200,
              strokeColor: Colors.black,
              minimumStrokeWidth: 4.0,
              maximumStrokeWidth: 4.0,
            ),
            Positioned(
              right: 1,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: AppColor.primary,
                    size: 50,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 30.w,
                  padding: const EdgeInsets.all(12),
                  child: Button(
                    onPressed: () async {
                      Get.back();
                      final data = await signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
                      final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
                      if (bytes != null) {
                        onSave(bytes);
                      }
                    },
                    child: Text(
                      'Save',
                      style: AppTextStyle.w1Style(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
