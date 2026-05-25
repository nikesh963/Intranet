// To parse this JSON data, do
//
//     final employeeProfile = employeeProfileFromJson(jsonString);

import 'dart:convert';

EmployeeProfile employeeProfileFromJson(String str) => EmployeeProfile.fromJson(json.decode(str));

String employeeProfileToJson(EmployeeProfile data) => json.encode(data.toJson());

class EmployeeProfile {
  bool? success;
  Data? data;

  EmployeeProfile({
    this.success,
    this.data,
  });

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) => EmployeeProfile(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  Employee? employee;
  String? employeeId;
  double? totalEarnLeave;
  double? totalLeaves;
  double? totalLeavesAppraisal;
  int? totalTickets;
  List<RecentLeaf>? recentLeaves;
  User? user;

  Data({
    this.employee,
    this.employeeId,
    this.totalEarnLeave,
    this.totalLeaves,
    this.totalLeavesAppraisal,
    this.totalTickets,
    this.recentLeaves,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    employeeId: json["employee_id"],
    totalEarnLeave: json["total_earn_leave"]?.toDouble(),
    totalLeaves: json["total_leaves"]?.toDouble(),
    totalLeavesAppraisal: json["total_leaves_appraisal"]?.toDouble(),
    totalTickets: json["total_tickets"],
    recentLeaves: json["recent_leaves"] == null ? [] : List<RecentLeaf>.from(json["recent_leaves"]!.map((x) => RecentLeaf.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "employee": employee?.toJson(),
    "employee_id": employeeId,
    "total_earn_leave": totalEarnLeave,
    "total_leaves": totalLeaves,
    "total_leaves_appraisal": totalLeavesAppraisal,
    "total_tickets": totalTickets,
    "recent_leaves": recentLeaves == null ? [] : List<dynamic>.from(recentLeaves!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class Employee {
  int? id;
  int? userId;
  String? tisId;
  String? profileImage;
  String? name;
  String? lastName;
  String? fatherName;
  String? motherName;
  String? personalEmail;
  dynamic dob;
  DateTime? officialDob;
  String? gender;
  String? phone;
  String? alternateContactNumber;
  String? emergencyContactNumber;
  String? emergencyContactPersonName;
  String? maritalStatus;
  String? panCard;
  String? address;
  String? temporaryAddress;
  String? email;
  String? password;
  String? bloodGroup;
  String? height;
  String? weight;
  String? aadharNumber;
  String? passportNumber;
  String? electionCardNumber;
  String? drivingLicenceNumber;
  dynamic skypeId;
  dynamic facebookProfileUrl;
  dynamic twitterProfileUrl;
  dynamic googlePlusProfileUrl;
  dynamic linkedinProfileUrl;
  String? employeeId;
  int? branchId;
  dynamic esicNumber;
  dynamic uanNumber;
  int? departmentId;
  int? designationId;
  DateTime? companyDoj;
  dynamic documents;
  String? accountHolderName;
  String? accountNumber;
  String? bankName;
  String? bankIdentifierCode;
  String? branchLocation;
  dynamic taxPayerId;
  dynamic salaryType;
  double? salary;
  int? isActive;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? teamName;
  DateTime? leaveStartDate;
  DateTime? leaveEndDate;
  double? leaveBalance;
  DateTime? nextApprisalDate;
  String? googleEventids;
  String? employeePicture;
  String? setTempalte;
  int? setHubstufftime;
  dynamic prevApprisalDate;
  double? allowedApprisalPeriodLeaves;

  Employee({
    this.id,
    this.userId,
    this.tisId,
    this.profileImage,
    this.name,
    this.lastName,
    this.fatherName,
    this.motherName,
    this.personalEmail,
    this.dob,
    this.officialDob,
    this.gender,
    this.phone,
    this.alternateContactNumber,
    this.emergencyContactNumber,
    this.emergencyContactPersonName,
    this.maritalStatus,
    this.panCard,
    this.address,
    this.temporaryAddress,
    this.email,
    this.password,
    this.bloodGroup,
    this.height,
    this.weight,
    this.aadharNumber,
    this.passportNumber,
    this.electionCardNumber,
    this.drivingLicenceNumber,
    this.skypeId,
    this.facebookProfileUrl,
    this.twitterProfileUrl,
    this.googlePlusProfileUrl,
    this.linkedinProfileUrl,
    this.employeeId,
    this.branchId,
    this.esicNumber,
    this.uanNumber,
    this.departmentId,
    this.designationId,
    this.companyDoj,
    this.documents,
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.bankIdentifierCode,
    this.branchLocation,
    this.taxPayerId,
    this.salaryType,
    this.salary,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.teamName,
    this.leaveStartDate,
    this.leaveEndDate,
    this.leaveBalance,
    this.nextApprisalDate,
    this.googleEventids,
    this.employeePicture,
    this.setTempalte,
    this.setHubstufftime,
    this.prevApprisalDate,
    this.allowedApprisalPeriodLeaves,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    userId: json["user_id"],
    tisId: json["tis_id"],
    profileImage: json["profile_image"],
    name: json["name"],
    lastName: json["last_name"],
    fatherName: json["father_name"],
    motherName: json["mother_name"],
    personalEmail: json["personal_email"],
    dob: json["dob"],
    officialDob: json["official_dob"] == null ? null : DateTime.parse(json["official_dob"]),
    gender: json["gender"],
    phone: json["phone"],
    alternateContactNumber: json["alternate_contact_number"],
    emergencyContactNumber: json["emergency_contact_number"],
    emergencyContactPersonName: json["emergency_contact_person_name"],
    maritalStatus: json["marital_status"],
    panCard: json["pan_card"],
    address: json["address"],
    temporaryAddress: json["temporary_address"],
    email: json["email"],
    password: json["password"],
    bloodGroup: json["blood_group"],
    height: json["height"],
    weight: json["weight"],
    aadharNumber: json["aadhar_number"],
    passportNumber: json["passport_number"],
    electionCardNumber: json["election_card_number"],
    drivingLicenceNumber: json["driving_licence_number"],
    skypeId: json["skype_id"],
    facebookProfileUrl: json["facebook_profile_url"],
    twitterProfileUrl: json["twitter_profile_url"],
    googlePlusProfileUrl: json["google_plus_profile_url"],
    linkedinProfileUrl: json["linkedin_profile_url"],
    employeeId: json["employee_id"],
    branchId: json["branch_id"],
    esicNumber: json["esic_number"],
    uanNumber: json["uan_number"],
    departmentId: json["department_id"],
    designationId: json["designation_id"],
    companyDoj: json["company_doj"] == null ? null : DateTime.parse(json["company_doj"]),
    documents: json["documents"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    bankName: json["bank_name"],
    bankIdentifierCode: json["bank_identifier_code"],
    branchLocation: json["branch_location"],
    taxPayerId: json["tax_payer_id"],
    salaryType: json["salary_type"],
    salary: json["salary"]?.toDouble(),
    isActive: json["is_active"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    teamName: json["team_name"],
    leaveStartDate: json["leave_start_date"] == null ? null : DateTime.parse(json["leave_start_date"]),
    leaveEndDate: json["leave_end_date"] == null ? null : DateTime.parse(json["leave_end_date"]),
    leaveBalance: json["leave_balance"]?.toDouble(),
    nextApprisalDate: json["next_apprisal_date"] == null ? null : DateTime.parse(json["next_apprisal_date"]),
    googleEventids: json["google_eventids"],
    employeePicture: json["employee_picture"],
    setTempalte: json["set_tempalte"],
    setHubstufftime: json["set_hubstufftime"],
    prevApprisalDate: json["prev_apprisal_date"],
    allowedApprisalPeriodLeaves:
    json["allowed_apprisal_period_leaves"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "tis_id": tisId,
    "profile_image": profileImage,
    "name": name,
    "last_name": lastName,
    "father_name": fatherName,
    "mother_name": motherName,
    "personal_email": personalEmail,
    "dob": dob,
    "official_dob": "${officialDob!.year.toString().padLeft(4, '0')}-${officialDob!.month.toString().padLeft(2, '0')}-${officialDob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "phone": phone,
    "alternate_contact_number": alternateContactNumber,
    "emergency_contact_number": emergencyContactNumber,
    "emergency_contact_person_name": emergencyContactPersonName,
    "marital_status": maritalStatus,
    "pan_card": panCard,
    "address": address,
    "temporary_address": temporaryAddress,
    "email": email,
    "password": password,
    "blood_group": bloodGroup,
    "height": height,
    "weight": weight,
    "aadhar_number": aadharNumber,
    "passport_number": passportNumber,
    "election_card_number": electionCardNumber,
    "driving_licence_number": drivingLicenceNumber,
    "skype_id": skypeId,
    "facebook_profile_url": facebookProfileUrl,
    "twitter_profile_url": twitterProfileUrl,
    "google_plus_profile_url": googlePlusProfileUrl,
    "linkedin_profile_url": linkedinProfileUrl,
    "employee_id": employeeId,
    "branch_id": branchId,
    "esic_number": esicNumber,
    "uan_number": uanNumber,
    "department_id": departmentId,
    "designation_id": designationId,
    "company_doj": "${companyDoj!.year.toString().padLeft(4, '0')}-${companyDoj!.month.toString().padLeft(2, '0')}-${companyDoj!.day.toString().padLeft(2, '0')}",
    "documents": documents,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "bank_name": bankName,
    "bank_identifier_code": bankIdentifierCode,
    "branch_location": branchLocation,
    "tax_payer_id": taxPayerId,
    "salary_type": salaryType,
    "salary": salary,
    "is_active": isActive,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "team_name": teamName,
    "leave_start_date": "${leaveStartDate!.year.toString().padLeft(4, '0')}-${leaveStartDate!.month.toString().padLeft(2, '0')}-${leaveStartDate!.day.toString().padLeft(2, '0')}",
    "leave_end_date": "${leaveEndDate!.year.toString().padLeft(4, '0')}-${leaveEndDate!.month.toString().padLeft(2, '0')}-${leaveEndDate!.day.toString().padLeft(2, '0')}",
    "leave_balance": leaveBalance,
    "next_apprisal_date": "${nextApprisalDate!.year.toString().padLeft(4, '0')}-${nextApprisalDate!.month.toString().padLeft(2, '0')}-${nextApprisalDate!.day.toString().padLeft(2, '0')}",
    "google_eventids": googleEventids,
    "employee_picture": employeePicture,
    "set_tempalte": setTempalte,
    "set_hubstufftime": setHubstufftime,
    "prev_apprisal_date": prevApprisalDate,
    "allowed_apprisal_period_leaves": allowedApprisalPeriodLeaves,
  };
}

class RecentLeaf {
  int? id;
  int? employeeId;
  String? department;
  String? branchName;
  int? leaveTypeId;
  DateTime? appliedOn;
  DateTime? startDate;
  DateTime? endDate;
  String? totalLeaveDays;
  String? leaveReason;
  String? remark;
  String? status;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? lastUpdatedBy;
  String? startDay;
  String? endDay;
  String? employeeName;
  String? roName;
  String? leaveTypeName;
  String? lastUpdatedByName;

  RecentLeaf({
    this.id,
    this.employeeId,
    this.department,
    this.branchName,
    this.leaveTypeId,
    this.appliedOn,
    this.startDate,
    this.endDate,
    this.totalLeaveDays,
    this.leaveReason,
    this.remark,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.lastUpdatedBy,
    this.startDay,
    this.endDay,
    this.employeeName,
    this.roName,
    this.leaveTypeName,
    this.lastUpdatedByName,
  });

  factory RecentLeaf.fromJson(Map<String, dynamic> json) => RecentLeaf(
    id: json["id"],
    employeeId: json["employee_id"],
    department: json["department"],
    branchName: json["branch_name"],
    leaveTypeId: json["leave_type_id"],
    appliedOn: json["applied_on"] == null ? null : DateTime.parse(json["applied_on"]),
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    totalLeaveDays: json["total_leave_days"],
    leaveReason: json["leave_reason"],
    remark: json["remark"],
    status: json["status"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    lastUpdatedBy: json["last_updated_by"],
    startDay: json["start_day"],
    endDay: json["end_day"],
    employeeName: json["employee_name"],
    roName: json["ro_name"],
    leaveTypeName: json["leave_type_name"],
    lastUpdatedByName: json["last_updated_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "department": department,
    "branch_name": branchName,
    "leave_type_id": leaveTypeId,
    "applied_on": "${appliedOn!.year.toString().padLeft(4, '0')}-${appliedOn!.month.toString().padLeft(2, '0')}-${appliedOn!.day.toString().padLeft(2, '0')}",
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "total_leave_days": totalLeaveDays,
    "leave_reason": leaveReason,
    "remark": remark,
    "status": status,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "last_updated_by": lastUpdatedBy,
    "start_day": startDay,
    "end_day": endDay,
    "employee_name": employeeName,
    "ro_name": roName,
    "leave_type_name": leaveTypeName,
    "last_updated_by_name": lastUpdatedByName,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? type;
  String? customRole;
  String? avatar;
  String? lang;
  dynamic plan;
  dynamic planExpireDate;
  DateTime? lastLogin;
  int? profileFillStatus;
  int? isActive;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.type,
    this.customRole,
    this.avatar,
    this.lang,
    this.plan,
    this.planExpireDate,
    this.lastLogin,
    this.profileFillStatus,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    type: json["type"],
    customRole: json["custom_role"],
    avatar: json["avatar"],
    lang: json["lang"],
    plan: json["plan"],
    planExpireDate: json["plan_expire_date"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    profileFillStatus: json["profile_fill_status"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "type": type,
    "custom_role": customRole,
    "avatar": avatar,
    "lang": lang,
    "plan": plan,
    "plan_expire_date": planExpireDate,
    "last_login": lastLogin?.toIso8601String(),
    "profile_fill_status": profileFillStatus,
    "is_active": isActive,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
