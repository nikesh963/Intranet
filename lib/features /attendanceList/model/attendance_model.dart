class AttendanceRecord {
  final String employee;
  final String date;
  final String day;
  final String status;
  final String statusCode;
  final bool hasTicket;
  final String punchingTime;
  final String hubstuffTime;
  final String leaveRecord;
  final String punchRecords;
  final String clockIn;
  final String clockOut;
  final String late;
  final String earlyLeaving;
  final String overtime;
  final String updatedBy;
  final String updateAt;

  AttendanceRecord({
    required this.employee,
    required this.date,
    required this.day,
    required this.status,
    required this.statusCode,
    required this.hasTicket,
    required this.punchingTime,
    required this.hubstuffTime,
    required this.leaveRecord,
    required this.punchRecords,
    required this.clockIn,
    required this.clockOut,
    required this.late,
    required this.earlyLeaving,
    required this.overtime,
    required this.updatedBy,
    required this.updateAt,
  });
}
