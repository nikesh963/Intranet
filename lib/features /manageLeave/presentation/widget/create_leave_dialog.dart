import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Common/CommonSnackBar.dart';
import '../../../../core/theme/app_theme.dart';
import '../controller/manage_leave_controller.dart';

class CreateLeaveDialog extends StatefulWidget {
  const CreateLeaveDialog({Key? key}) : super(key: key);

  @override
  State<CreateLeaveDialog> createState() => _CreateLeaveDialogState();
}

class _CreateLeaveDialogState extends State<CreateLeaveDialog> {
  // Controllers
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final ManageLeaveController controller = Get.find<ManageLeaveController>();

  // Dropdown values
  String? _selectedLeaveType;
  String? _selectedStartDay;
  String? _selectedEndDay;

  // Date variables
  DateTime? _startDate;
  DateTime? _endDate;

  DateTime getMinimumDate() {

    /// LOP => allow all previous dates
    if (_selectedLeaveType == 'LOP (Loss Of Pay)') {
      return DateTime(2000);
    }

    /// Earned => allow only after 3 days
    return DateTime.now().add(const Duration(days: 3));
  }
  // Leave type options
  final List<String> _leaveTypeOptions = [
    'LOP (Loss Of Pay)',
    'Earned'
  ];

  // Day options
  final List<String> _dayOptions = [
    'Full Day',
    'First Half',
    'Second Half'
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
                  'Create New Leave',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),

                // Leave Type Dropdown
                // DropdownButtonFormField<String>(
                //   decoration: InputDecoration(
                //     labelText: 'Leave Type',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.r),
                //     ),
                //   ),
                //   value: _selectedLeaveType,
                //   items: _leaveTypeOptions.map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedLeaveType = newValue;
                //     });
                //   },
                //   hint: Text('Select Leave Type'),
                // ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  offset: Offset(0, 5.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 14.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedLeaveType ?? 'Select Leave Type'),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 150.w,
                    maxWidth: 300.h,
                    maxHeight: 300.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 8,
                  menuPadding: EdgeInsets.all(12.w),

                  itemBuilder: (BuildContext context) {
                    return _leaveTypeOptions.map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        child: Text(value),
                      );
                    }).toList();
                  },
                  // onSelected: (String newValue) {
                  //   setState(() {
                  //     _selectedLeaveType = newValue;
                  //   });
                  // },
                  onSelected: (String newValue) {
                    setState(() {

                      _selectedLeaveType = newValue;

                      /// RESET DATES
                      _startDate = null;
                      _endDate = null;

                      _startDateController.clear();
                      _endDateController.clear();

                      _selectedStartDay = null;
                      _selectedEndDay = null;
                    });
                  },
                ),
                SizedBox(height: 16.h),

                // Start Date Section
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Start Date Calendar
                //     Expanded(
                //       flex: 2,
                //       child: TextField(
                //         controller: _startDateController,
                //         readOnly: true,
                //         decoration: InputDecoration(
                //           labelText: 'Start Date',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.r),
                //           ),
                //           suffixIcon: Icon(Icons.calendar_today),
                //         ),
                //         onTap: () => _selectStartDate(context),
                //       ),
                //     ),
                //     SizedBox(width: 4.w),
                //     // Start Day Dropdown
                //     Expanded(
                //       flex: 2,
                //       child: DropdownButtonFormField<String>(
                //         decoration: InputDecoration(
                //           labelText: 'Select Day',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.r),
                //           ),
                //         ),
                //         value: _selectedStartDay,
                //         items: _dayOptions.map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             _selectedStartDay = newValue;
                //           });
                //         },
                //         hint: Text('Select'),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Start Date Calendar
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _startDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () => _selectStartDate(context),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    // Start Day Dropdown
                    Expanded(
                      flex: 2,
                      child: PopupMenuButton<String>(
                        color: Colors.white,
                        offset: Offset(0, 5.h),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_selectedStartDay ?? 'Select'),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 150.w,
                          maxWidth: 300.w,
                          maxHeight: 300.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 8,
                        menuPadding: EdgeInsets.all(12.w),
                        itemBuilder: (BuildContext context) {
                          return _dayOptions.map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              child: Text(value),
                            );
                          }).toList();
                        },
                        onSelected: (String newValue) {
                          setState(() {
                            _selectedStartDay = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // End Date Section
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // End Date Calendar
                //     Expanded(
                //       flex: 2,
                //       child: TextField(
                //         controller: _endDateController,
                //         readOnly: true,
                //         decoration: InputDecoration(
                //           labelText: 'End Date',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.r),
                //           ),
                //           suffixIcon: Icon(Icons.calendar_today),
                //         ),
                //         onTap: () => _selectEndDate(context),
                //       ),
                //     ),
                //     SizedBox(width: 4.w),
                //
                //     // End Day Dropdown
                //     Expanded(
                //       flex: 2,
                //       child: DropdownButtonFormField<String>(
                //         decoration: InputDecoration(
                //           labelText: 'Select Day',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.r),
                //           ),
                //         ),
                //         value: _selectedEndDay,
                //         items: _dayOptions.map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             _selectedEndDay = newValue;
                //           });
                //         },
                //         hint: Text('Select'),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // End Date Calendar
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _endDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () => _selectEndDate(context),
                      ),
                    ),
                    SizedBox(width: 4.w),

                    // End Day Dropdown
                    Expanded(
                      flex: 2,
                      child: PopupMenuButton<String>(
                        color: Colors.white,
                        offset: Offset(0, 5.h),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_selectedEndDay ?? 'Select'),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 150.w,
                          maxWidth: 300.w,
                          maxHeight: 300.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 8,
                        menuPadding: EdgeInsets.all(12.w),
                        itemBuilder: (BuildContext context) {
                          return _dayOptions.map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              child: Text(value),
                            );
                          }).toList();
                        },
                        onSelected: (String newValue) {
                          setState(() {
                            _selectedEndDay = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Reason TextField
                TextField(
                  controller: _reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    // labelText: 'Leave Reason',
                    hintText: 'Leave Reason',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
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
                          await _createLeave();
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
                    // Cancel Button
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
                    SizedBox(width: 10.w,),
                    ElevatedButton(
                      onPressed: () async {
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Select Start Date
  Future<void> _selectStartDate(BuildContext context) async {
    if (_selectedLeaveType == null) {
      SnackBarService.showErrorSnackBar(
        "Please select leave type first",
      );
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: DateTime.now(),
      initialDate: _selectedLeaveType == 'LOP (Loss Of Pay)'
          ? DateTime.now()
          : getMinimumDate(),

      // firstDate: DateTime.now(),
      firstDate: getMinimumDate(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Primary color (header, selected date, etc.)
            primaryColor: Colors.blue, // Change this to your desired color
            // Background color of the date picker
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Header background and selected date
              onPrimary: Colors.white, // Text color on header
              surface: Colors.white, // Background color
              onSurface: Colors.black, // Text color
            ),
            // Button colors
            dialogBackgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);

        // If end date is before start date, clear end date
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = null;
          _endDateController.clear();
          _selectedEndDay = null;
        }
      });
    }
  }

  // Select End Date
  Future<void> _selectEndDate(BuildContext context) async {
    if (_selectedLeaveType == null) {
      SnackBarService.showErrorSnackBar(
        "Please select leave type first",
      );
      return;
    }
    // final DateTime initialDate = _startDate ?? DateTime.now();
    final DateTime initialDate =
        _startDate ??
            (_selectedLeaveType == 'LOP (Loss Of Pay)'
                ? DateTime.now()
                : getMinimumDate());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,

      // firstDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? getMinimumDate(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Primary color (header, selected date, etc.)
            primaryColor: Colors.blue, // Change this to your desired color
            // Background color of the date picker
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Header background and selected date
              onPrimary: Colors.white, // Text color on header
              surface: Colors.white, // Background color
              onSurface: Colors.black, // Text color
            ),
            // Button colors
            dialogBackgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Validate Form
  bool _validateForm() {
    if (_selectedLeaveType == null || _selectedLeaveType!.isEmpty) {
      SnackBarService.showErrorSnackBar('Please select leave type');
      return false;
    }

    if (_startDateController.text.isEmpty) {
      SnackBarService.showErrorSnackBar('Please select start date');
      return false;
    }

    if (_selectedStartDay == null || _selectedStartDay!.isEmpty) {
      SnackBarService.showErrorSnackBar('Please select start day');
      return false;
    }

    if (_endDateController.text.isEmpty) {
      SnackBarService.showErrorSnackBar('Please select end date');
      return false;
    }

    if (_selectedEndDay == null || _selectedEndDay!.isEmpty) {
      SnackBarService.showErrorSnackBar('Please select end day');
      return false;
    }

    if (_reasonController.text.isEmpty) {
      SnackBarService.showErrorSnackBar('Please enter leave reason');
      return false;
    }

    return true;
  }

  // Create Leave
  Future<void> _createLeave() async {

    final bool isSuccess = await controller.createLeave(
      leaveType: _selectedLeaveType!,
      startDate: _startDateController.text.trim(),
      endDate: _endDateController.text.trim(),
      leaveReason: _reasonController.text.trim(),
      startDay: _selectedStartDay!,
      endDay: _selectedEndDay!,
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}