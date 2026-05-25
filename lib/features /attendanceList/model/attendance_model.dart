// To parse this JSON data, do
//
//     final attendance = attendanceFromJson(jsonString);

import 'dart:convert';

Attendance attendanceFromJson(String str) => Attendance.fromJson(json.decode(str));

String attendanceToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
  bool? success;
  Data? data;

  Attendance({
    this.success,
    this.data,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  List<AttendanceElement>? attendance;
  List<AllEmpLeaf>? allEmpLeaves;
  List<dynamic>? forMonthlyShow;
  Branch? branch;
  Department? department;
  AttendanceStatus? attendanceStatus;
  Filters? filters;
  Pagination? pagination;
  String? viewType;

  Data({
    this.attendance,
    this.allEmpLeaves,
    this.forMonthlyShow,
    this.branch,
    this.department,
    this.attendanceStatus,
    this.filters,
    this.pagination,
    this.viewType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attendance: json["attendance"] == null ? [] : List<AttendanceElement>.from(json["attendance"]!.map((x) => AttendanceElement.fromJson(x))),
    allEmpLeaves: json["all_emp_leaves"] == null ? [] : List<AllEmpLeaf>.from(json["all_emp_leaves"]!.map((x) => AllEmpLeaf.fromJson(x))),
    forMonthlyShow: json["for_monthly_show"] == null ? [] : List<dynamic>.from(json["for_monthly_show"]!.map((x) => x)),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    department: json["department"] == null ? null : Department.fromJson(json["department"]),
    attendanceStatus: json["attendance_status"] == null ? null : AttendanceStatus.fromJson(json["attendance_status"]),
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
    viewType: json["view_type"],
  );

  Map<String, dynamic> toJson() => {
    "attendance": attendance == null ? [] : List<dynamic>.from(attendance!.map((x) => x.toJson())),
    "all_emp_leaves": allEmpLeaves == null ? [] : List<dynamic>.from(allEmpLeaves!.map((x) => x.toJson())),
    "for_monthly_show": forMonthlyShow == null ? [] : List<dynamic>.from(forMonthlyShow!.map((x) => x)),
    "branch": branch?.toJson(),
    "department": department?.toJson(),
    "attendance_status": attendanceStatus?.toJson(),
    "filters": filters?.toJson(),
    "pagination": pagination?.toJson(),
    "view_type": viewType,
  };
}

class AllEmpLeaf {
  DateTime? leaveDate;
  String? type;
  String? status;
  String? day;

  AllEmpLeaf({
    this.leaveDate,
    this.type,
    this.status,
    this.day,
  });

  factory AllEmpLeaf.fromJson(Map<String, dynamic> json) => AllEmpLeaf(
    leaveDate: json["leaveDate"] == null ? null : DateTime.parse(json["leaveDate"]),
    type: json["type"],
    status: json["status"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "leaveDate": "${leaveDate!.year.toString().padLeft(4, '0')}-${leaveDate!.month.toString().padLeft(2, '0')}-${leaveDate!.day.toString().padLeft(2, '0')}",
    "type": type,
    "status": status,
    "day": day,
  };
}

class AttendanceElement {
  int? id;
  int? employeeId;
  DateTime? date;
  String? day;
  String? clockIn;
  String? clockOut;
  dynamic duration;
  dynamic hubstuffDuration;
  dynamic punchRecords;
  String? late;
  String? earlyLeaving;
  String? overtime;
  String? totalRest;
  String? mannualEdit;
  StatusCode? statusCode;
  Status? status;
  int? isSandwich;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic updateBy;
  String? ticket;
  String? ticketStatus;
  int? ticketId;
  String? employeeName;
  dynamic updateByName;

  AttendanceElement({
    this.id,
    this.employeeId,
    this.date,
    this.day,
    this.clockIn,
    this.clockOut,
    this.duration,
    this.hubstuffDuration,
    this.punchRecords,
    this.late,
    this.earlyLeaving,
    this.overtime,
    this.totalRest,
    this.mannualEdit,
    this.statusCode,
    this.status,
    this.isSandwich,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.updateBy,
    this.ticket,
    this.ticketStatus,
    this.ticketId,
    this.employeeName,
    this.updateByName,
  });

  factory AttendanceElement.fromJson(Map<String, dynamic> json) => AttendanceElement(
    id: json["id"],
    employeeId: json["employee_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"],
    clockIn: json["clock_in"],
    clockOut: json["clock_out"],
    duration: json["duration"],
    hubstuffDuration: json["hubstuff_duration"],
    punchRecords: json["punch_records"],
    late: json["late"],
    earlyLeaving: json["early_leaving"],
    overtime: json["overtime"],
    totalRest: json["total_rest"],
    mannualEdit: json["mannual_edit"],
    statusCode: statusCodeValues.map[json["status_code"]],
    status: statusValues.map[json["status"]],
    isSandwich: json["is_sandwich"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updateBy: json["update_by"],
    ticket: json["ticket"],
    ticketStatus: json["ticket_status"],
    ticketId: json["ticket_id"],
    employeeName: json["employee_name"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day,
    "clock_in": clockIn,
    "clock_out": clockOut,
    "duration": duration,
    "hubstuff_duration": hubstuffDuration,
    "punch_records": punchRecords,
    "late": late,
    "early_leaving": earlyLeaving,
    "overtime": overtime,
    "total_rest": totalRest,
    "mannual_edit": mannualEdit,
    "status_code": statusCodeValues.reverse[statusCode],
    "status": statusValues.reverse[status],
    "is_sandwich": isSandwich,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "update_by": updateBy,
    "ticket": ticket,
    "ticket_status": ticketStatus,
    "ticket_id": ticketId,
    "employee_name": employeeName,
    "update_by_name": updateByName,
  };
}


enum Status {
  ABSENT,
  HALF_DAY,
  PRESENT
}

final statusValues = EnumValues({
  "Absent": Status.ABSENT,
  "HalfDay": Status.HALF_DAY,
  "Present": Status.PRESENT
});

enum StatusCode {
  A,
  H,
  P
}

final statusCodeValues = EnumValues({
  "a": StatusCode.A,
  "h": StatusCode.H,
  "p": StatusCode.P
});

class AttendanceStatus {
  double? present;
  double? absent;

  AttendanceStatus({
    this.present,
    this.absent,
  });

  factory AttendanceStatus.fromJson(Map<String, dynamic> json) => AttendanceStatus(
    present: json["present"]?.toDouble(),
    absent: json["absent"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "present": present,
    "absent": absent,
  };
}

class Branch {
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? empty;

  Branch({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.empty,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    empty: json[""],
  );

  Map<String, dynamic> toJson() => {
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "": empty,
  };
}

class Department {
  String? empty;

  Department({
    this.empty,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    empty: json[""],
  );

  Map<String, dynamic> toJson() => {
    "": empty,
  };
}

class Filters {
  String? type;
  String? month;

  Filters({
    this.type,
    this.month,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    type: json["type"],
    month: json["month"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "month": month,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "from": from,
    "to": to,
  };
}