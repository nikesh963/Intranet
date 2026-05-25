// To parse this JSON data, do
//
//     final leaves = leavesFromJson(jsonString);

import 'dart:convert';

Leaves leavesFromJson(String str) => Leaves.fromJson(json.decode(str));

String leavesToJson(Leaves data) => json.encode(data.toJson());

class Leaves {
  bool? status;
  Data? data;

  Leaves({
    this.status,
    this.data,
  });

  factory Leaves.fromJson(Map<String, dynamic> json) => Leaves(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  List<Leaf>? leaves;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  int? totalEarnLeaveBalance;
  DateTime? start;
  DateTime? end;
  List<dynamic>? roNames;
  List<dynamic>? statusList;
  List<dynamic>? leaveTypes;
  List<dynamic>? empNames;

  Data({
    this.leaves,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.totalEarnLeaveBalance,
    this.start,
    this.end,
    this.roNames,
    this.statusList,
    this.leaveTypes,
    this.empNames,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaves: json["leaves"] == null ? [] : List<Leaf>.from(json["leaves"]!.map((x) => Leaf.fromJson(x))),
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
    totalEarnLeaveBalance: json["totalEarnLeaveBalance"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    roNames: json["roNames"] == null ? [] : List<dynamic>.from(json["roNames"]!.map((x) => x)),
    statusList: json["statusList"] == null ? [] : List<dynamic>.from(json["statusList"]!.map((x) => x)),
    leaveTypes: json["leaveTypes"] == null ? [] : List<dynamic>.from(json["leaveTypes"]!.map((x) => x)),
    empNames: json["empNames"] == null ? [] : List<dynamic>.from(json["empNames"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "leaves": leaves == null ? [] : List<dynamic>.from(leaves!.map((x) => x.toJson())),
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
    "totalEarnLeaveBalance": totalEarnLeaveBalance,
    "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
    "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
    "roNames": roNames == null ? [] : List<dynamic>.from(roNames!.map((x) => x)),
    "statusList": statusList == null ? [] : List<dynamic>.from(statusList!.map((x) => x)),
    "leaveTypes": leaveTypes == null ? [] : List<dynamic>.from(leaveTypes!.map((x) => x)),
    "empNames": empNames == null ? [] : List<dynamic>.from(empNames!.map((x) => x)),
  };
}

class Leaf {
  int? id;
  int? employeeId;
  String? employeeName;
  int? leaveTypeId;
  String? leaveTypeName;
  int? createdBy;
  String? createdByName;
  String? department;
  String? branchName;
  DateTime? appliedOn;
  DateTime? startDate;
  DateTime? endDate;
  String? totalLeaveDays;
  String? leaveReason;
  String? remark;
  String? status;
  String? startDay;
  String? endDay;
  DateTime? createdAt;
  DateTime? updatedAt;

  Leaf({
    this.id,
    this.employeeId,
    this.employeeName,
    this.leaveTypeId,
    this.leaveTypeName,
    this.createdBy,
    this.createdByName,
    this.department,
    this.branchName,
    this.appliedOn,
    this.startDate,
    this.endDate,
    this.totalLeaveDays,
    this.leaveReason,
    this.remark,
    this.status,
    this.startDay,
    this.endDay,
    this.createdAt,
    this.updatedAt,
  });

  factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
    id: json["id"],
    employeeId: json["employee_id"],
    employeeName: json["employee_name"],
    leaveTypeId: json["leave_type_id"],
    leaveTypeName: json["leave_type_name"],
    createdBy: json["created_by"],
    createdByName: json["created_by_name"],
    department: json["department"],
    branchName: json["branch_name"],
    appliedOn: json["applied_on"] == null ? null : DateTime.parse(json["applied_on"]),
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    totalLeaveDays: json["total_leave_days"],
    leaveReason: json["leave_reason"],
    remark: json["remark"],
    status: json["status"],
    startDay: json["start_day"],
    endDay: json["end_day"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "employee_name": employeeName,
    "leave_type_id": leaveTypeId,
    "leave_type_name": leaveTypeName,
    "created_by": createdBy,
    "created_by_name": createdByName,
    "department": department,
    "branch_name": branchName,
    "applied_on": "${appliedOn!.year.toString().padLeft(4, '0')}-${appliedOn!.month.toString().padLeft(2, '0')}-${appliedOn!.day.toString().padLeft(2, '0')}",
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "total_leave_days": totalLeaveDays,
    "leave_reason": leaveReason,
    "remark": remark,
    "status": status,
    "start_day": startDay,
    "end_day": endDay,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
