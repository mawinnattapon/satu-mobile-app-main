// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  String? token;
  String? tokenType;
  DateTime? expire;
  String? expiresIn;
  Profile? profile;

  UserProfile({
    this.token,
    this.tokenType,
    this.expire,
    this.expiresIn,
    this.profile,
  });

  factory UserProfile.fromDB(Map<String, dynamic> json) => UserProfile(
        token: json["token"],
      );

  factory UserProfile.fromJson(Map<String, dynamic> json,
          {String? keyId_, String? key_, String? atext_, String? token_}) =>
      UserProfile(
        token: token_ ?? json['token'],
        tokenType: json["tokenType"],
        expire: json["expire"] == null ? null : DateTime.parse(json["expire"]),
        expiresIn: json["expiresIn"],
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "tokenType": tokenType,
        "expire": expire?.toIso8601String(),
        "expiresIn": expiresIn,
        "profile": profile?.toJson(),
      };
}

class Profile {
  int id = 1;
  String? username;
  String? email;
  String? mobile;
  int? prefixId;
  String? prefixName;
  String? firstName;
  String? lastName;
  String? fullName;
  String? nickname;
  int? sex;
  DateTime? birthday;
  String? pid;
  String? pidEnc;
  String? passcode;
  int? biometric;
  String? httpToken;
  String? photo;
  String? contactName;
  String? contactPhone;
  String? source;
  int? compId;
  String? compname;
  int? premium;
  String? verifyCode;
  String? roleLevel;
  int? roleId;
  String? roleName;
  int? active;
  int? status;
  DateTime? activatedAt;
  DateTime? lastLogin;

  String? keyId;
  String? key;
  String? atext;
  String? token;
  int? gender;
  String? position;
  String? empno;

  String get iconName {
    return (fullName ?? "").isEmpty ? "U" : (fullName ?? "U").substring(0, 1).toUpperCase();
  }

  Profile({
    this.id = 1,
    this.username,
    this.email,
    this.mobile,
    this.prefixId,
    this.prefixName,
    this.firstName,
    this.lastName,
    this.fullName,
    this.nickname,
    this.sex,
    this.birthday,
    this.pid,
    this.pidEnc,
    this.passcode,
    this.biometric,
    this.httpToken,
    this.photo,
    this.contactName,
    this.contactPhone,
    this.source,
    this.compId,
    this.premium,
    this.verifyCode,
    this.roleLevel,
    this.roleId,
    this.roleName,
    this.active,
    this.status,
    this.activatedAt,
    this.lastLogin,
    this.keyId,
    this.key,
    this.atext,
    this.token,
    this.compname,
    this.gender,
    this.position,
    this.empno,
  });

  set setPasscode(String passcode) => this.passcode = passcode;
  void clearPasscode() => passcode = null;
  set setBiometric(int biometric) => this.biometric = biometric;
  set setHttpToken(String httpToken) => this.httpToken = httpToken;

  Profile.fromLogin(this.pid, this.httpToken);

  Profile.fromJsonDbPin(Map<String, dynamic> json) {
    id = 1;
    pid = json['pid'] ?? pid;
    pidEnc = json['pid_enc'] ?? pidEnc;
    passcode = json['passcode'] ?? passcode;
    biometric = json['biometric'] ?? biometric;
    httpToken = json['http_token'] ?? httpToken;
  }
  Map<String, dynamic> toJsonDbPin() {
    final json = <String, dynamic>{};
    json['id'] = 1;
    json['pid'] = pid;
    json['pid_enc'] = pidEnc;
    json['passcode'] = passcode;
    json['biometric'] = biometric;
    json['http_token'] = httpToken;
    return json;
  }

  Map<String, dynamic> toJsonDbUser() {
    final json = <String, dynamic>{};
    json['id'] = 1;
    json['token'] = token;
    return json;
  }

  factory Profile.fromJsonUser(Map<String, dynamic> json) => Profile(
        id: 1,
        token: json["token"],
      );

  factory Profile.fromJson(Map<String, dynamic> json, {String? token_}) => Profile(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        mobile: json["mobile"],
        prefixId: json["prefix_id"],
        prefixName: json["prefix_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        nickname: json["nickname"],
        sex: json["sex"],
        birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        pid: json["pid"],
        pidEnc: json["pid_enc"],
        passcode: json["passcode"],
        biometric: json["biometric"],
        httpToken: json["httpToken"],
        photo: json["photo"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        source: json["source"],
        compId: json["comp_id"],
        compname: json["comp_name"],
        premium: json["premium"],
        verifyCode: json["verify_code"],
        roleLevel: json["role_level"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        active: json["active"],
        status: json["status"],
        token: token_ ?? json["token"],
        activatedAt: json["activated_at"] == null ? null : DateTime.parse(json["activated_at"]),
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        gender: json["gender"],
        position: json["position"],
        empno: json["emp_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "mobile": mobile,
        "prefix_id": prefixId,
        "prefix_name": prefixName,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "nickname": nickname,
        "sex": sex,
        "birthday": birthday?.toIso8601String(),
        "pid": pid,
        "pid_enc": pidEnc,
        "passcode": passcode,
        "biometric": biometric,
        "httpToken": httpToken,
        "photo": photo,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "source": source,
        "comp_id": compId,
        "comp_name": compname,
        "premium": premium,
        "verify_code": verifyCode,
        "role_level": roleLevel,
        "role_id": roleId,
        "role_name": roleName,
        "active": active,
        "status": status,
        "keyId": keyId,
        "key": key,
        "atext": atext,
        "token": token,
        "activated_at": activatedAt?.toIso8601String(),
        "last_login": lastLogin?.toIso8601String(),
        "gender": gender,
        "position": position,
        "emp_no": empno,
      };
}
