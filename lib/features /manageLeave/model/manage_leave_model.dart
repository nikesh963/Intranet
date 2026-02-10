class ManageLeaveModel {
  final String employee;
  final String ro;
  final String leaveType;
  final String appliedOn;
  final String startDate;
  final String endDate;
  final String totalDays;
  final String status;
  final String lastUpdatedBy;

  ManageLeaveModel({
    required this.employee,
    required this.ro,
    required this.leaveType,
    required this.appliedOn,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.status,
    required this.lastUpdatedBy,
  });
}
