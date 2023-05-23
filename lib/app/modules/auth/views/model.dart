// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
    String message;
    LoginResponseData data;

    LoginResponse({
        required this.message,
        required this.data,
    });

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        data: LoginResponseData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class LoginResponseData {
    String type;
    String token;
    DataData data;

    LoginResponseData({
        required this.type,
        required this.token,
        required this.data,
    });

    factory LoginResponseData.fromRawJson(String str) => LoginResponseData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponseData.fromJson(Map<String, dynamic> json) => LoginResponseData(
        type: json["type"],
        token: json["token"],
        data: DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
        "data": data.toJson(),
    };
}

class DataData {
    String role;
    String country;
    String level;
    User user;

    DataData({
        required this.role,
        required this.country,
        required this.level,
        required this.user,
    });

    factory DataData.fromRawJson(String str) => DataData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        role: json["role"],
        country: json["country"],
        level: json["level"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "country": country,
        "level": level,
        "user": user.toJson(),
    };
}

class User {
    int id;
    DateTime date;
    String name;
    String slug;
    String email;
    dynamic emailVerifiedAt;
    dynamic lastLoggedIn;
    dynamic noOfLogins;
    String shortName;
    dynamic slogans;
    String schoolAddress;
    String phone;
    dynamic altPhone;
    dynamic registration;
    dynamic panNumber;
    String logo;
    dynamic sms;
    dynamic websiteApi;
    dynamic paymentApi;
    dynamic agreement;
    String status;
    String level;
    String updateTime;
    String country;
    String instituteId;
    dynamic createdAt;
    dynamic updatedAt;
    String isLoged;
    dynamic deletedAt;
    List<Role> roles;

    User({
        required this.id,
        required this.date,
        required this.name,
        required this.slug,
        required this.email,
        this.emailVerifiedAt,
        this.lastLoggedIn,
        this.noOfLogins,
        required this.shortName,
        this.slogans,
        required this.schoolAddress,
        required this.phone,
        this.altPhone,
        this.registration,
        this.panNumber,
        required this.logo,
        this.sms,
        this.websiteApi,
        this.paymentApi,
        this.agreement,
        required this.status,
        required this.level,
        required this.updateTime,
        required this.country,
        required this.instituteId,
        this.createdAt,
        this.updatedAt,
        required this.isLoged,
        this.deletedAt,
        required this.roles,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        slug: json["slug"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        lastLoggedIn: json["last_logged_in"],
        noOfLogins: json["no_of_logins"],
        shortName: json["short_name"],
        slogans: json["slogans"],
        schoolAddress: json["school_address"],
        phone: json["phone"],
        altPhone: json["alt_phone"],
        registration: json["registration"],
        panNumber: json["pan_number"],
        logo: json["logo"],
        sms: json["sms"],
        websiteApi: json["website_api"],
        paymentApi: json["payment_api"],
        agreement: json["agreement"],
        status: json["status"],
        level: json["level"],
        updateTime: json["update_time"],
        country: json["country"],
        instituteId: json["institute_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isLoged: json["is_loged"],
        deletedAt: json["deleted_at"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "name": name,
        "slug": slug,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "last_logged_in": lastLoggedIn,
        "no_of_logins": noOfLogins,
        "short_name": shortName,
        "slogans": slogans,
        "school_address": schoolAddress,
        "phone": phone,
        "alt_phone": altPhone,
        "registration": registration,
        "pan_number": panNumber,
        "logo": logo,
        "sms": sms,
        "website_api": websiteApi,
        "payment_api": paymentApi,
        "agreement": agreement,
        "status": status,
        "level": level,
        "update_time": updateTime,
        "country": country,
        "institute_id": instituteId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_loged": isLoged,
        "deleted_at": deletedAt,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    };
}

class Role {
    int id;
    String name;
    String guardName;
    dynamic createdAt;
    dynamic updatedAt;
    String instituteId;
    String sessionId;
    dynamic model;
    dynamic modelId;
    dynamic deletedAt;
    Pivot pivot;

    Role({
        required this.id,
        required this.name,
        required this.guardName,
        this.createdAt,
        this.updatedAt,
        required this.instituteId,
        required this.sessionId,
        this.model,
        this.modelId,
        this.deletedAt,
        required this.pivot,
    });

    factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        instituteId: json["institute_id"],
        sessionId: json["session_id"],
        model: json["model"],
        modelId: json["model_id"],
        deletedAt: json["deleted_at"],
        pivot: Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "institute_id": instituteId,
        "session_id": sessionId,
        "model": model,
        "model_id": modelId,
        "deleted_at": deletedAt,
        "pivot": pivot.toJson(),
    };
}

class Pivot {
    String modelId;
    String roleId;
    String modelType;

    Pivot({
        required this.modelId,
        required this.roleId,
        required this.modelType,
    });

    factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
    );

    Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
    };
}
