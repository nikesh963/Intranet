import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../model/attendance_model.dart';
import '../controller/attendance_controller.dart';

class AddTicketDialog extends StatefulWidget {
  final AttendanceElement record;

  const AddTicketDialog({Key? key, required this.record,}) : super(key: key);
  @override
  State<AddTicketDialog> createState() => _AddTicketDialogState();
}

class _AddTicketDialogState extends State<AddTicketDialog> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final AttendanceController controller =
  Get.find<AttendanceController>();
  // String? _selectedPriority;
  // String? _selectedDepartment;
  PlatformFile? _selectedFile;
// 👇 Preselected values
  String? _selectedPriority = 'Medium';
  String? _selectedDepartment = 'HR Department';

  @override
  void initState() {

    super.initState();

    _subjectController.text =
    "Attendance ${widget.record.employeeName ?? ""} : "
        "${widget.record.date?.toString().split(' ')[0] ?? ""}";

    _descriptionController.text =
    'Hello\n\n'
        'Kindly Change The Attendance Status As Per Below Details:\n\n'
        'Date : ${widget.record.date?.toString().split(' ')[0] ?? ""}\n'
        'Current Status : ${widget.record.status?.name ?? "Absent"}\n'
        'New Status Required :\n'
        'Reason :';
  }
  // Priority options
  final List<String> _priorityOptions = [
    'High',
    'Medium',
    'Low',
    'Critical'
  ];

  // Department options
  final List<String> _departmentOptions = [
    'HR Department',
    'Hardware and IT Support',
    'Reporting Officer',
    'Software IT Support'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          width: double.maxFinite,
          color: AppTheme.colors.white,
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Add ticket',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),

                // Subject TextField
                TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(

                    labelText: 'Subject',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                PopupMenuButton<String>(
                  color: Colors.white,
                  offset: Offset(0, 5.h), // Space between button and menu
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedPriority ?? 'Select Priority'),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),

                  // Control the menu appearance
                  constraints: BoxConstraints(

                    minWidth: 150.w,
                    maxWidth: 300.w,
                    maxHeight: 300.h,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  elevation: 8,

                  // This adds padding/margin around the entire dropdown content
                  menuPadding: EdgeInsets.all(12.w), // Creates space around the items

                  itemBuilder: (BuildContext context) {
                    return _priorityOptions.map((String value) {
                      return PopupMenuItem<String>(

                        value: value,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        child: Text(value),
                      );
                    }).toList();
                  },

                  onSelected: (String newValue) {
                    setState(() {
                      _selectedPriority = newValue;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                PopupMenuButton<String>(
                  color: Colors.white,
                  offset: Offset(0, 5.h), // Space between button and menu
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedDepartment ?? 'Select Department'),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),

                  // Control the menu appearance
                  constraints: BoxConstraints(
                    minWidth: 150.w,
                    maxWidth: 300.w,
                    maxHeight: 300.h,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  elevation: 8,

                  // This adds padding/margin around the entire dropdown content
                  menuPadding: EdgeInsets.all(12.w), // Creates space around the items

                  itemBuilder: (BuildContext context) {
                    return _departmentOptions.map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        child: Text(value),
                      );
                    }).toList();
                  },

                  onSelected: (String newValue) {
                    setState(() {
                      _selectedDepartment = newValue;
                    });
                  },
                ),
                SizedBox(height: 16.h),

                TextField(
                  controller: _descriptionController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    // labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      try {
                        final FilePicker filePicker = FilePicker.platform;
                        final result = await filePicker.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
                        );

                        if (result != null) {
                          setState(() {
                            _selectedFile = result.files.first;
                          });
                        }
                      } catch (e) {
                        print('Error picking file: $e');
                        SnackBarService.showErrorSnackBar('Error picking file');
                      }
                    },
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      child: CustomPaint(
                        painter: DashedBorderPainter(
                          context: context,
                          borderRadius: 8.r,
                          dashWidth: 6.0,
                          dashSpace: 4.0,
                          strokeWidth: 1.5.w,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.UPLOAD, // 👈 your upload SVG path
                                width: 20.w,
                                height: 20.w,
                                color:   AppTheme.colors.blue,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                _selectedFile?.name ?? 'Attach file',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: _selectedFile != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Create Button
                    ElevatedButton(
                      onPressed: () async {

                        if (_validateForm()) {

                          await _createTicket();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 44.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 44.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_subjectController.text.isEmpty) {
      SnackBarService.showErrorSnackBar('Please enter subject');
      return false;
    }
    if (_selectedPriority == null) {
      SnackBarService.showErrorSnackBar('Please select priority');
      return false;
    }
    if (_selectedDepartment == null) {
      SnackBarService.showErrorSnackBar('Please select department');
      return false;
    }
    return true;
  }
  String getPriorityKey(String value) {

    switch (value) {

      case "Low":
        return "low";

      case "Medium":
        return "medium";

      case "High":
        return "high";

      case "Critical":
        return "critical";

      default:
        return "medium";
    }
  }
  String getDepartmentKey(String value) {

    switch (value) {

      case "HR Department":
        return "hr";

      case "Hardware and IT Support":
        return "hardware";

      case "Reporting Officer":
        return "reporting_officer";

      case "Software IT Support":
        return "software";

      default:
        return "hr";
    }
  }

  Future<void> _createTicket() async {

    final bool isSuccess =
    await controller.createAttendanceTicket(

      title: _subjectController.text.trim(),

      priority: getPriorityKey(
        _selectedPriority!,
      ),

      department: getDepartmentKey(
        _selectedDepartment!,
      ),

      description:
      _descriptionController.text.trim(),

      attendanceId: widget.record.id ?? 0,

      file: _selectedFile,
    );

    debugPrint(
      "CREATE TICKET SUCCESS : $isSuccess",
    );
  }
  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}




class DashedBorderPainter extends CustomPainter {

  final BuildContext context;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;
  final Color? color;
  final double strokeWidth;

  DashedBorderPainter({
    required this.context,
    this.borderRadius = 5.0,
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
    this.color,
    // this.color = Theme.of(context).brightness == Brightness.light
    //     ? AppTheme.colors.white
    //     : AppTheme.colors.grey,
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create a rounded rectangle
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // Convert RRect to Path
    final path = Path()..addRRect(rect);

    // Draw dashed border along the path
    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path path = Path();
    double distance = 0.0;

    for (final PathMetric metric in source.computeMetrics()) {
      while (distance < metric.length) {
        final double nextDistance = distance + dashWidth;
        path.addPath(
          metric.extractPath(distance, nextDistance.clamp(0, metric.length)),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
      distance = 0.0; // reset for each contour
    }

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}