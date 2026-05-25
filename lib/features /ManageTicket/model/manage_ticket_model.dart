// To parse this JSON data, do
//
//     final tickets = ticketsFromJson(jsonString);

import 'dart:convert';

Tickets ticketsFromJson(String str) => Tickets.fromJson(json.decode(str));

String ticketsToJson(Tickets data) => json.encode(data.toJson());

class Tickets {
  bool? success;
  Data? data;

  Tickets({
    this.success,
    this.data,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  List<Ticket>? tickets;
  Pagination? pagination;
  Filters? filters;
  Meta? meta;
  Dropdowns? dropdowns;

  Data({
    this.tickets,
    this.pagination,
    this.filters,
    this.meta,
    this.dropdowns,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tickets: json["tickets"] == null ? [] : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    dropdowns: json["dropdowns"] == null ? null : Dropdowns.fromJson(json["dropdowns"]),
  );

  Map<String, dynamic> toJson() => {
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
    "filters": filters?.toJson(),
    "meta": meta?.toJson(),
    "dropdowns": dropdowns?.toJson(),
  };
}

class Dropdowns {
  List<dynamic>? roNames;
  List<dynamic>? ticketStatus;
  List<dynamic>? departmentTo;
  List<dynamic>? empNames;

  Dropdowns({
    this.roNames,
    this.ticketStatus,
    this.departmentTo,
    this.empNames,
  });

  factory Dropdowns.fromJson(Map<String, dynamic> json) => Dropdowns(
    roNames: json["ro_names"] == null ? [] : List<dynamic>.from(json["ro_names"]!.map((x) => x)),
    ticketStatus: json["ticket_status"] == null ? [] : List<dynamic>.from(json["ticket_status"]!.map((x) => x)),
    departmentTo: json["department_to"] == null ? [] : List<dynamic>.from(json["department_to"]!.map((x) => x)),
    empNames: json["emp_names"] == null ? [] : List<dynamic>.from(json["emp_names"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ro_names": roNames == null ? [] : List<dynamic>.from(roNames!.map((x) => x)),
    "ticket_status": ticketStatus == null ? [] : List<dynamic>.from(ticketStatus!.map((x) => x)),
    "department_to": departmentTo == null ? [] : List<dynamic>.from(departmentTo!.map((x) => x)),
    "emp_names": empNames == null ? [] : List<dynamic>.from(empNames!.map((x) => x)),
  };
}

class Filters {
  DateTime? start;
  DateTime? end;

  Filters({
    this.start,
    this.end,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
    "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
  };
}

class Meta {
  String? openTickets;
  String? closeTickets;

  Meta({
    this.openTickets,
    this.closeTickets,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    openTickets: json["open_tickets"],
    closeTickets: json["close_tickets"],
  );

  Map<String, dynamic> toJson() => {
    "open_tickets": openTickets,
    "close_tickets": closeTickets,
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
  String? employeeName;
  String? createdByName;
  String? ticketCreatedByName;

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
    this.employeeName,
    this.createdByName,
    this.ticketCreatedByName,
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
    employeeName: json["employee_name"],
    createdByName: json["created_by_name"],
    ticketCreatedByName: json["ticket_created_by_name"],
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
    "employee_name": employeeName,
    "created_by_name": createdByName,
    "ticket_created_by_name": ticketCreatedByName,
  };
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