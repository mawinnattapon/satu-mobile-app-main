import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.images.dart';
import 'package:satu/constants/app.modal.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/layout.main.dart';
import 'package:satu/library/button.dart';
import 'package:satu/library/input.dart';
import 'package:satu/library/loading.dart';
import 'package:satu/models/system/system.fromItem.model.dart';
import 'package:satu/models/system/systeminfo.model.dart';
import 'package:satu/modules/controller/scanner.ctrl.dart';
import 'package:satu/modules/controller/systeminfo.ctrl.dart';
import 'package:satu/modules/controller/user.ctrl.dart';
import 'package:satu/utils/date_util.dart';
import 'package:satu/widget/app/card.border.dart';
import 'package:satu/widget/app/checkbox.detail.widget.dart';
import 'package:satu/widget/app/checkbox.widget.dart';
import 'package:satu/widget/app/custom.radiogroup.dart';
import 'package:satu/widget/camera/camera.widget.dart';
import 'package:satu/widget/main.header.dart';
import 'package:satu/widget/pickimage/list.imageitem.dart';
import 'package:satu/widget/step.system/scrollable.table.dart';
import 'package:satu/widget/step.system/tbl.confirm.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StepSystemScreen extends StatefulWidget {
  const StepSystemScreen({super.key});

  @override
  State<StepSystemScreen> createState() => _StepSystemScreenState();
}

class _StepSystemScreenState extends State<StepSystemScreen> {
  final systemCtrl = SystemInfoController.instance;
  final scannerCtrl = ScannerController.instance;
  final userCtrl = UserController.instance;

  // final ImagePicker picker = ImagePicker();
  final _scrollController = ScrollController();
  late SystemInfoModel data;
  // ByteData? signature;
  // List<XFile>? filemuti = [];
  // int? dropdownVal;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    Loading.show();
    data = Get.arguments;
    await systemCtrl.fetchSystemItem(
        eqmId: scannerCtrl.scanModel!.id!, formsId: data.id);
    setState(() {});
    Loading.close();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      isbottomSheet: false,
      title: data.name,
      child: GetBuilder<SystemInfoController>(builder: (_) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 5.h),
                MainHeader(scanModel: scannerCtrl.scanModel!),
                SizedBox(height: 4.h),
                buildBody(),
              ],
            ),
          ),
        );
      }),
    );
  }

  SizedBox buildBody() {
    return SizedBox(
      width: 75.w,
      child: CardBorder(
        isShadow: false,
        isBorder: false,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImage.imageLogo,
                    fit: BoxFit.fill,
                    height: 4.h,
                  ),
                  systemCtrl.systemFromItemModel?.docurl == null
                      ? Container()
                      : GestureDetector(
                          onTap: () async {
                            if (systemCtrl.systemFromItemModel != null) {
                              String url = systemCtrl
                                  .systemFromItemModel!.docurl
                                  .toString();
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                AppModal.alert(
                                  title: 'Could not launch $url',
                                );
                              }
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.description_outlined,
                                size: 25,
                                color: AppColor.sky,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Manual',
                                style: AppTextStyle.b1Style()
                                    .copyWith(color: AppColor.sky),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              SizedBox(height: 2.h),
              Text.rich(
                TextSpan(
                    text: 'Last Updated: ',
                    style: AppTextStyle.setStyle(
                      colors: AppColor.dark.shade100,
                      size: 2.5.h,
                    ),
                    children: [
                      TextSpan(
                        text: ' ${DateUtil.dateDay(data.lastDate)}',
                        style: AppTextStyle.setStyle(
                          colors: AppColor.primary,
                          size: 2.5.h,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                controller: _scrollController,
                itemCount:
                    systemCtrl.systemFromItemModel?.questions.length ?? 0,
                itemBuilder: (context, index) {
                  Question question =
                      systemCtrl.systemFromItemModel!.questions[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${question.title}',
                        style: AppTextStyle.b1Style(),
                      ),
                      question.detail != null && question.detail!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '     ${question.detail}',
                                style: AppTextStyle.b2Style(),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 1.h),
                      question.inputType == 'short_text'
                          ? Column(
                              children: List.generate(
                                question.answers?.length ?? 0,
                                (index) {
                                  Answer answer = question.answers![index];
                                  return FormInput(
                                    hintText: answer.subTitle,
                                    initialValue: answer.assmAwsLabel,
                                    type: TextInputType.multiline,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      answer.assmAwsLabel = value;
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(),
                      question.inputType == 'long_text'
                          ? Column(
                              children: List.generate(
                                question.answers?.length ?? 0,
                                (index) {
                                  Answer answer = question.answers![index];
                                  return FormInput(
                                    hintText: answer.subTitle,
                                    initialValue: answer.assmAwsLabel,
                                    type: TextInputType.multiline,
                                    maxLines: 2,
                                    onChanged: (value) {
                                      answer.assmAwsLabel = value;
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(),
                      question.inputType == 'choice'
                          ? CustomRadioGroup(
                              onValueSelected: (value) {
                                setState(() {
                                  question.isselected = value!;
                                  for (var element in question.answers!) {
                                    if (question.isselected == element.id) {
                                      element.assmAwsChecked = true;
                                    } else {
                                      element.assmAwsChecked = false;
                                    }
                                  }
                                });
                              },
                              items: question.answers!,
                              groupValue: question.isselected,
                            )
                          : Container(),
                      question.inputType == 'checkbox'
                          ? SizedBox(
                              width: 20.w,
                              child: Wrap(
                                children: List.generate(
                                    question.answers?.length ?? 0, (index) {
                                  Answer answer = question.answers![index];
                                  return CheckboxWidget(
                                      checkbox: answer.assmAwsChecked!,
                                      title: answer.title,
                                      callback: (value) {
                                        answer.assmAwsChecked = value;
                                        setState(() {});
                                      });
                                }),
                              ),
                            )
                          : Container(),
                      question.inputType == 'checkbox-detail'
                          ? Column(
                              children: List.generate(
                                  question.answers?.length ?? 0, (index) {
                                Answer answer = question.answers![index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CheckboxDetailWidget(
                                        checkbox: answer.assmAwsChecked!,
                                        title: answer.title,
                                        subTitle: answer.subTitle,
                                        callback: (value) {
                                          answer.assmAwsChecked = value;
                                          setState(() {});
                                        }),
                                    answer.requiredPhoto
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                answer.assmAwsPayload == null
                                                    ? _addAwsPhoto(
                                                        answer,
                                                        answer.assmAwsChecked ??
                                                            false)
                                                    : Container(),
                                                answer.assmAwsPayload == null
                                                    ? Container()
                                                    : GridView(
                                                        gridDelegate:
                                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              15.h,
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                        ),
                                                        shrinkWrap: true,
                                                        controller:
                                                            _scrollController,
                                                        children: answer
                                                                .assmAwsPayload
                                                                .map<Widget>(
                                                                    (e) {
                                                              // cheack
                                                              //ถ้าเป็น http cheack
                                                              return SizedBox(
                                                                key: Key(e
                                                                    .toString()),
                                                                child:
                                                                    ListImageItem(
                                                                  file: e,
                                                                  onDelete: (path) =>
                                                                      _removeAwsPhoto(
                                                                          path,
                                                                          answer),
                                                                  isMouse:
                                                                      false,
                                                                ),
                                                              );
                                                            }).toList() +
                                                            (answer.assmAwsPayload !=
                                                                    null
                                                                ? [
                                                                    _addAwsPhoto(
                                                                        answer,
                                                                        answer.assmAwsChecked ??
                                                                            false)
                                                                  ]
                                                                : []),
                                                      ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                );
                              }),
                            )
                          : Container(),
                      question.inputType == 'dropdown'
                          ? SizedBox(
                              width: 30.w,
                              child: DropdownButtonFormField(
                                value: systemCtrl.dropdownVal.isEmpty
                                    ? null
                                    : systemCtrl.dropdownVal,
                                onChanged: (value) {
                                  systemCtrl.setDropdownVal(value.toString());
                                  for (var element in question.answers!) {
                                    if (systemCtrl.dropdownVal ==
                                        element.id.toString()) {
                                      element.assmAwsChecked = true;
                                    } else {
                                      element.assmAwsChecked = false;
                                    }
                                  }
                                  setState(() {});
                                },
                                hint: Text(
                                  'dropdown',
                                  style: AppTextStyle.p3Style(),
                                ),
                                items: question.answers?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.id.toString(),
                                    child: Text(e.title,
                                        style: AppTextStyle.b2Style()),
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(),
                      question.requiredNote
                          ? FormInput(
                              initialValue: question.assmQstNote,
                              type: TextInputType.multiline,
                              hintText: 'Note',
                              maxLines: 3,
                              onChanged: (value) {
                                question.assmQstNote = value;
                                setState(() {});
                              },
                            )
                          : Container(),
                      SizedBox(height: 1.h),
                      question.requiredPhoto
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                question.assmQstPhoto!.isEmpty
                                    ? _addQstPhoto(question)
                                    : Container(),
                                question.assmQstPhoto!.isEmpty
                                    ? Container()
                                    : GridView(
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 15.h,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        shrinkWrap: true,
                                        controller: _scrollController,
                                        children: question.assmQstPhoto!
                                                .map<Widget>(
                                              (e) {
                                                // cheack
                                                //ถ้าเป็น http cheack
                                                return SizedBox(
                                                  key: Key(e.toString()),
                                                  child: ListImageItem(
                                                    file: e,
                                                    onDelete: (path) {
                                                      _removeQstPhoto(
                                                          path, question);
                                                    },
                                                    isMouse: false,
                                                  ),
                                                );
                                              },
                                            ).toList() +
                                            (question.assmQstPhoto!.isNotEmpty
                                                ? [_addQstPhoto(question)]
                                                : []),
                                      ),
                              ],
                            )
                          : Container(),
                      question.inputType == 'tbl-measuring'
                          ? Column(
                              children: List.generate(
                                question.answers?.length ?? 0,
                                (index) {
                                  Answer answer = question.answers![index];
                                  return answer.assmAwsPayload != null
                                      ? ScrollableTable(
                                          tableLiter:
                                              answer.assmAwsPayload['liter'],
                                          tableGallon:
                                              answer.assmAwsPayload['gallon'],
                                          onDataChanged: (liter, gallon) {
                                            // Update the answer payload with complete table data
                                            answer.assmAwsPayload['liter'] = liter;
                                            answer.assmAwsPayload['gallon'] = gallon;
                                          },
                                        )
                                      : Container();
                                },
                              ),
                            )
                          : Container(),
                      question.inputType == 'tbl-confirm'
                          ? SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: List.generate(
                                  question.answers?.length ?? 0,
                                  (index) {
                                    Answer answer = question.answers![index];
                                    return answer.assmAwsPayload != null
                                        ? TblConfirm(
                                            name: answer.assmAwsPayload['name'],
                                            signature: answer
                                                .assmAwsPayload['signature'],
                                            company: answer
                                                .assmAwsPayload['company'],
                                            date: answer.assmAwsPayload['date'],
                                          )
                                        : Container();
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 1.h),
                    ],
                  );
                },
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 30.h,
                    child: ButtonOutline(
                      color: ButtonColor.black,
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: AppTextStyle.b1Style(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.h,
                    child: ButtonOutline(
                      color: ButtonColor.black,
                      onPressed: () async {
                        Loading.show();
                        bool isCheck = await _processImage(
                            systemCtrl.systemFromItemModel!.questions);
                        if (isCheck) {
                          systemCtrl.systemFromItemModel!.savetype = 'draft';
                          bool isData = await systemCtrl.fetchSystemSave(
                              model: systemCtrl.systemFromItemModel!);
                          if (isData) {
                            await systemCtrl.fetchSystemItem(
                                eqmId: scannerCtrl.scanModel!.id!,
                                formsId: data.id);
                            AppModal.succfu(
                              title: 'successful',
                            );
                          }
                        }
                        Loading.close();
                      },
                      child: Text(
                        'Save as Draft',
                        style: AppTextStyle.b1Style(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.h,
                    child: Button(
                      onPressed: () async {
                        // Get.toNamed(AppRoutes.completedScreen);
                        log('message :: ${systemCtrl.systemFromItemModel!.toJson()}');
                        Loading.show();
                        bool isCheck = await _processImage(
                            systemCtrl.systemFromItemModel!.questions);
                        if (isCheck) {
                          systemCtrl.systemFromItemModel!.savetype = 'submit';
                          bool isData = await systemCtrl.fetchSystemSave(
                              model: systemCtrl.systemFromItemModel!);
                          if (isData) {
                            Get.toNamed(AppRoutes.completedScreen);
                          }
                        }
                        Loading.close();
                      },
                      color: ButtonColor.black,
                      child: Text(
                        'Submit',
                        style: AppTextStyle.w1Style(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _processImage(List<Question> questions) async {
    for (var question in questions) {
      if (question.assmQstPhoto!.isNotEmpty) {
        for (var item in question.assmQstPhoto!) {
          if (!item.startsWith('http')) {
            String? dataImage = await systemCtrl.fetchUploadImage(image: item);
            if (dataImage != null && dataImage.startsWith('http')) {
              var index = question.assmQstPhoto!.indexOf(item);
              question.assmQstPhoto!
                  .replaceRange(index, index + 1, [dataImage]);
            } else {
              return false;
            }
          }
        }
      }

      for (var answer in question.answers!) {
        if (question.inputType == "checkbox-detail") {
          for (var img in answer.assmAwsPayload) {
            if (!img.startsWith('http')) {
              String? dataImage = await systemCtrl.fetchUploadImage(image: img);
              if (dataImage != null && dataImage.startsWith('http')) {
                var index = answer.assmAwsPayload.indexOf(img);
                answer.assmAwsPayload[index] = dataImage;
              } else {
                return false;
              }
            }
          }
        }
      }
    }
    return true;
  }

  Widget _addQstPhoto(Question question) => SizedBox(
        key: const Key("selector"),
        child: GestureDetector(
          onTap: () async {
            Get.to(
              fullscreenDialog: true,
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 300),
              () => CameraWidget(
                onPressed: (photo) {
                  setState(() {
                    question.assmQstPhoto!.add(photo.path);
                  });
                },
              ),
            );
            // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
            // if (photo != null) {
            //   setState(() {
            //     // filemuti!.add(photo);
            //     question.assmQstPhoto!.add(photo.path);
            //   });
            // }
          },
          child: Container(
            width: 15.h,
            height: 15.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade50,
                    blurRadius: 1.0,
                    spreadRadius: 0.4,
                  ),
                ]),
            child: const Center(
              child: Icon(
                Icons.add_circle,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
        ),
      );

  void _removeQstPhoto(String imageFile, Question question) {
    setState(() {
      question.assmQstPhoto!.remove(imageFile);
    });
  }

  Widget _addAwsPhoto(Answer aws, bool enable) => SizedBox(
        key: const Key("awsPhoto"),
        child: GestureDetector(
          onTap: enable
              ? () async {
                  Get.to(
                    fullscreenDialog: true,
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 300),
                    () => CameraWidget(
                      onPressed: (photo) {
                        setState(() {
                          aws.assmAwsPayload.add(photo.path);
                        });
                      },
                    ),
                  );

                  // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                  // if (photo != null) {
                  //   setState(() {
                  //     aws.assmAwsPayload.add(photo.path);
                  //   });
                  // }
                }
              : null,
          child: Container(
            width: 15.h,
            height: 15.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade50,
                    blurRadius: 1.0,
                    spreadRadius: 0.4,
                  ),
                ]),
            child: Center(
              child: Icon(
                Icons.add_circle,
                color: enable ? Colors.black : Colors.grey,
                size: 32,
              ),
            ),
          ),
        ),
      );

  void _removeAwsPhoto(String imageFile, Answer aws) {
    setState(() {
      aws.assmAwsPayload.remove(imageFile);
    });
  }
}
