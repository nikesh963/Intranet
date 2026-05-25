import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../controller/manage_ticket_controller.dart';

class CreateTicketDialog extends StatefulWidget {
  const CreateTicketDialog({Key? key}) : super(key: key);

  @override
  State<CreateTicketDialog> createState() => _CreateTicketDialog();
}

class _CreateTicketDialog extends State<CreateTicketDialog> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ManageTicketsController controller =
  Get.find<ManageTicketsController>();
  String? _selectedPriority;
  String? _selectedDepartment;
  // PlatformFile? _selectedFile;
  List<PlatformFile> _selectedFiles = [];
  // Priority options
  final Map<String, String> _priorityOptions = {
    "low": "Low",
    "medium": "Medium",
    "high": "High",
    "critical": "Critical",
  };

  // Department options
  final Map<String, String> _departmentOptions = {
    "hr": "HR Department",
    "hardware": "Hardware(IT Support)",
    "reporting_officer": "Reporting Officer",
    "software": "Software(IT Support)",
  };

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
                  'Create New Ticket',
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
                // DropdownButtonFormField<String>(
                //   decoration: InputDecoration(
                //     labelText: 'Priority',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.r),
                //     ),
                //   ),
                //   value: _selectedPriority,
                //   items: _priorityOptions.map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedPriority = newValue;
                //     });
                //   },
                //   hint: Text('Select Priority'),
                // ),
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
                        Text(
                          _selectedPriority != null
                              ? _priorityOptions[_selectedPriority]!
                              : 'Select Priority',
                        ),
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

                    return _priorityOptions.entries.map((entry) {

                      return PopupMenuItem<String>(
                        value: entry.key,

                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),

                        child: Text(entry.value),
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

                // Department Dropdown
                // DropdownButtonFormField<String>(
                //   decoration: InputDecoration(
                //     labelText: 'Department',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.r),
                //     ),
                //   ),
                //   value: _selectedDepartment,
                //   items: _departmentOptions.map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedDepartment = newValue;
                //     });
                //   },
                //   hint: Text('Select Department'),
                // ),
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
                        Text(
                          _selectedDepartment != null
                              ? _departmentOptions[_selectedDepartment]!
                              : 'Select Department',
                        ),
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

                    return _departmentOptions.entries.map((entry) {

                      return PopupMenuItem<String>(
                        value: entry.key,

                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),

                        child: Text(entry.value),
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
                    hintText: 'Description',
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

                        final result =
                        await FilePicker.platform.pickFiles(

                          allowMultiple: true,

                          type: FileType.custom,

                          allowedExtensions: [
                            'jpg',
                            'jpeg',
                            'png',
                            'pdf',
                            'doc',
                            'docx',
                            'xls',
                            'xlsx',
                          ],
                        );

                        if (result != null) {

                          setState(() {

                            _selectedFiles = result.files;
                          });
                        }

                      } catch (e) {

                        debugPrint("FILE PICK ERROR : $e");

                        SnackBarService.showErrorSnackBar(
                          'Error picking file',
                        );
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
                                _selectedFiles.isNotEmpty
                                    ? "${_selectedFiles.length} files selected"
                                    : "Attach file",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  // color: _selectedFile != null
                                  //     ? Colors.black
                                  //     : Colors.grey,
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
                        // Handle create ticket logic
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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
                    // TextButton(
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    //   style: TextButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 24.w,
                    //       vertical: 12.h,
                    //     ),
                    //   ),
                    //   child: Text(
                    //     'Cancel',
                    //     style: TextStyle(fontSize: 14.sp),
                    //   ),
                    // ),
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

    final bool isSuccess =
    await controller.createTicket(

      title: _subjectController.text.trim(),

      priority: _selectedPriority!,

      department: _selectedDepartment!,

      description:
      _descriptionController.text.trim(),

      files: _selectedFiles,
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