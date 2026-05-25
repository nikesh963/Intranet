// To parse this JSON data, do
//
//     final ticketReply = ticketReplyFromJson(jsonString);

import 'dart:convert';

TicketReply ticketReplyFromJson(String str) => TicketReply.fromJson(json.decode(str));

String ticketReplyToJson(TicketReply data) => json.encode(data.toJson());

class TicketReply {
  bool? success;
  Data? data;

  TicketReply({
    this.success,
    this.data,
  });

  factory TicketReply.fromJson(Map<String, dynamic> json) => TicketReply(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  Ticket? ticket;
  List<Reply>? replies;
  Pagination? pagination;
  String? attendanceId;
  String? attendanceStatus;

  Data({
    this.ticket,
    this.replies,
    this.pagination,
    this.attendanceId,
    this.attendanceStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ticket: json["ticket"] == null ? null : Ticket.fromJson(json["ticket"]),
    replies: json["replies"] == null ? [] : List<Reply>.from(json["replies"]!.map((x) => Reply.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    attendanceId: json["attendance_id"],
    attendanceStatus: json["attendance_status"],
  );

  Map<String, dynamic> toJson() => {
    "ticket": ticket?.toJson(),
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "attendance_id": attendanceId,
    "attendance_status": attendanceStatus,
  };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}

class Reply {
  int? id;
  int? ticketId;
  int? employeeId;
  String? description;
  String? attechedFile;
  int? isRead;
  int? createdBy;
  String? createdByName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Reply({
    this.id,
    this.ticketId,
    this.employeeId,
    this.description,
    this.attechedFile,
    this.isRead,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    ticketId: json["ticket_id"],
    employeeId: json["employee_id"],
    description: json["description"],
    attechedFile: json["atteched_file"],
    isRead: json["is_read"],
    createdBy: json["created_by"],
    createdByName: json["created_by_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "employee_id": employeeId,
    "description": description,
    "atteched_file": attechedFile,
    "is_read": isRead,
    "created_by": createdBy,
    "created_by_name": createdByName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Ticket {
  int? id;
  String? title;
  int? employeeId;
  String? department;
  String? branchName;
  String? priority;
  String? endDate;
  String? description;
  String? ticketCode;
  int? ticketCreated;
  int? createdBy;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? attechedFile;
  String? ticketDepartment;

  Ticket({
    this.id,
    this.title,
    this.employeeId,
    this.department,
    this.branchName,
    this.priority,
    this.endDate,
    this.description,
    this.ticketCode,
    this.ticketCreated,
    this.createdBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.attechedFile,
    this.ticketDepartment,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    title: json["title"],
    employeeId: json["employee_id"],
    department: json["department"],
    branchName: json["branch_name"],
    priority: json["priority"],
    endDate: json["end_date"],
    description: json["description"],
    ticketCode: json["ticket_code"],
    ticketCreated: json["ticket_created"],
    createdBy: json["created_by"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    attechedFile: json["atteched_file"],
    ticketDepartment: json["ticket_department"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "employee_id": employeeId,
    "department": department,
    "branch_name": branchName,
    "priority": priority,
    "end_date": endDate,
    "description": description,
    "ticket_code": ticketCode,
    "ticket_created": ticketCreated,
    "created_by": createdBy,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "atteched_file": attechedFile,
    "ticket_department": ticketDepartment,
  };
}
