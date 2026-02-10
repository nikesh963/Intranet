import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../core/theme/app_theme.dart';

class AddTicketDialog extends StatefulWidget {
  final String date;

  const AddTicketDialog({Key? key, required this.date}) : super(key: key);

  @override
  State<AddTicketDialog> createState() => _AddTicketDialogState();
}

class _AddTicketDialogState extends State<AddTicketDialog> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedPriority;
  String? _selectedDepartment;
  PlatformFile? _selectedFile;

  @override
  void initState() {
    super.initState();
    // Set the initial value for description textfield
    _descriptionController.text = 'Hello\nKindly Change The Attendance Status As Per Below Details:\nDate : ${widget.date}\nCurrent Status : Absent\nNew Status Required :\nReason:';
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

                // Priority Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  value: _selectedPriority,
                  items: _priorityOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue;
                    });
                  },
                  hint: Text('Select Priority'),
                ),
                SizedBox(height: 16.h),

                // Department Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  value: _selectedDepartment,
                  items: _departmentOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDepartment = newValue;
                    });
                  },
                  hint: Text('Select Department'),
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
                              Icon(
                                Icons.attach_file,
                                size: 20.w,
                                color: _selectedFile != null ? AppTheme.colors.blue : Colors.grey,
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
                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Create Button
                    ElevatedButton(
                      onPressed: () async {
                        // Handle create ticket logic
                        if (_validateForm()) {
                         await _createTicket();
                           // Get.back();
                         Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
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

  Future<void> _createTicket() async {

   SnackBarService.showSuccessSnackBar(
      'Ticket created successfully for ${widget.date}',
    );
   await Future.delayed(Duration(milliseconds: 500));
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