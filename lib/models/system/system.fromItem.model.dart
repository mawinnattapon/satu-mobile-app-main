import 'dart:convert';

SystemFromItemModel systemFromItemModelFromJson(String str) => SystemFromItemModel.fromJson(json.decode(str));

String systemFromItemModelToJson(SystemFromItemModel data) => json.encode(data.toJson());

class SystemFromItemModel {
  int id;
  String name;
  String? savetype;
  int typeId;
  String typeName;
  bool allowRepeat;
  int equipmentId;
  int? assmId;
  int? assmStatus;
  int? assmStatusby;
  String? assmStatusbyname;
  int? assmResult;
  String? assmResultAt;
  String? assmStatusat;
  String? assmCreatedAt;
  String? assmUpdatedAt;
  String? docurl;
  List<Question> questions = [];

  SystemFromItemModel({
    required this.id,
    required this.name,
    this.savetype,
    required this.typeId,
    required this.typeName,
    required this.allowRepeat,
    required this.equipmentId,
    this.assmId,
    this.assmStatus,
    this.assmStatusby,
    this.assmStatusat,
    this.assmStatusbyname,
    this.assmResult,
    this.assmResultAt,
    this.assmCreatedAt,
    this.assmUpdatedAt,
    this.docurl,
    required this.questions,
  });

  factory SystemFromItemModel.fromJson(Map<String, dynamic> json) => SystemFromItemModel(
        id: json["id"],
        name: json["name"],
        savetype: json["save_type"],
        typeId: json["type_id"],
        typeName: json["type_name"],
        allowRepeat: json["allow_repeat"],
        equipmentId: json["equipment_id"],
        assmId: json["assm_id"],
        assmStatus: json["assm_status"],
        assmStatusby: json["assm_status_by"],
        assmStatusat: json["assm_status_at"],
        assmStatusbyname: json["assm_status_by_name"],
        assmResult: json["assm_result"],
        assmResultAt: json["assm_result_at"],
        assmCreatedAt: json["assm_created_at"],
        assmUpdatedAt: json["assm_updated_at"],
        docurl: json["doc_url"],
        questions: List.from(json["questions"] ?? []).map((x) => Question.fromJson(x)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "save_type": savetype,
        "equipment_id": equipmentId,
        "assm_id": assmId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };

  Map<String, dynamic> toForm() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type_id'] = typeId;
    data['type_name'] = typeName;
    data['allow_repeat'] = allowRepeat;
    data['equipment_id'] = equipmentId;
    data['assm_id'] = assmId;
    data['assm_status'] = assmStatus;
    data['assm_result'] = assmResult;
    data['assm_result_at'] = assmResultAt;
    data['assm_created_at'] = assmCreatedAt;
    data['assm_updated_at'] = assmUpdatedAt;
    data['questions'] = List<dynamic>.from(questions.map((x) => x.toJson()));
    return data;
  }
}

class Question {
  int id;
  String title;
  String? detail;
  String inputType;
  bool requiredPhoto;
  bool requiredNote;
  int? assmQstId;
  String? assmQstNote;
  bool? isAssmAwsChecked;
  List<String>? assmQstPhoto;
  List<Answer>? answers;

  int isselected;
  int? dropdownVal;

  Question({
    required this.id,
    required this.title,
    required this.inputType,
    required this.requiredPhoto,
    required this.requiredNote,
    this.detail,
    this.assmQstId,
    this.assmQstNote,
    this.assmQstPhoto,
    this.answers,
    this.isAssmAwsChecked,
    this.isselected = 0,
    this.dropdownVal,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"],
      title: json["title"],
      detail: json["detail"],
      inputType: json["input_type"],
      requiredPhoto: json["required_photo"],
      requiredNote: json["required_note"],
      assmQstId: json["assm_qst_id"],
      assmQstNote: json["assm_qst_note"],
      isAssmAwsChecked: json["isAssmAwsChecked"],
      assmQstPhoto: List<String>.from(json["assm_qst_photo"].map((x) => x)),
      answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "assm_qst_id": assmQstId,
        "assm_qst_note": assmQstNote,
        "assm_qst_photo": List<String>.from(assmQstPhoto!.map((x) => x)),
        "answers": List<dynamic>.from(answers!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toForm() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['input_type'] = inputType;
    data['required_photo'] = requiredPhoto;
    data['required_note'] = requiredNote;
    data['assm_qst_id'] = assmQstId;
    data['assm_qst_note'] = assmQstNote;
    data['assm_qst_photo'] = List<String>.from(assmQstPhoto!.map((x) => x));
    data['answers'] = List<dynamic>.from(answers!.map((x) => x.toJson()));
    return data;
  }
}

class Answer {
  late int id;
  late String title;
  String? subTitle;
  Map<String, dynamic> extra = {};
  late bool warning;
  int? assmAwsId;
  String? assmAwsLabel;
  dynamic assmAwsPayload;
  bool? assmAwsChecked;
  List<dynamic> tableLiter = [];
  List<dynamic> tableGallon = [];

  Answer({
    required this.id,
    required this.title,
    this.subTitle,
    required this.warning,
    required this.extra,
    this.assmAwsId,
    this.assmAwsLabel,
    required this.assmAwsPayload,
    this.assmAwsChecked,
  });

  bool get requiredPhoto => extra.containsKey("photo") && extra["photo"] == true;

  Answer.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    subTitle = json["sub_title"];
    extra = json["extra"] ?? <String, dynamic>{};
    warning = json["warning"];
    assmAwsId = json["assm_aws_id"];
    assmAwsLabel = json["assm_aws_label"];
    assmAwsPayload = json["assm_aws_payload"];
    assmAwsChecked = json["assm_aws_checked"];
    // tableLiter = (extra['liter'] as List).map((data) => TableAws.fromJson(data)).toList();
    // print(tableLiter);
    // return Answer(
    //   id: json["id"],
    //   title: json["title"],
    //   subTitle: json["sub_title"],
    //   extra: json["extra"] ?? <String, dynamic>{},
    //   warning: json["warning"],
    //   assmAwsId: json["assm_aws_id"],
    //   assmAwsLabel: json["assm_aws_label"],
    //   assmAwsPayload: json["assm_aws_payload"],
    //   assmAwsChecked: json["assm_aws_checked"],
    // );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "assm_aws_id": assmAwsId,
        "assm_aws_label": assmAwsLabel,
        "assm_aws_payload": assmAwsPayload,
        "assm_aws_checked": assmAwsChecked,
      };
}

class TableAws {
  double? value;
  bool? readonly;

  TableAws({this.value, this.readonly});

  TableAws.fromJson(Map<String, dynamic> json) {
    value = json['value'] ?? "";
    readonly = json['readonly'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['readonly'] = readonly;

    return data;
  }
}
