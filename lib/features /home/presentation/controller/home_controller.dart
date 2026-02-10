import 'package:get/get.dart';

import '../../../../Common/helper/ApiHelper.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/network/network_info.dart';
import '../../model/home_model.dart';

class HomeController extends GetxController {

  final RxInt selectedTab = 0.obs; // 0 for TOTAL, 1 for TECHNICAL
  var currentBannerIndex = 0.obs;

  // Banner images
  final List<String> bannerImages = [
   AppImages.LOGO,
   AppImages.LOGO,
   AppImages.LOGO,
    // AppImages.BANNER,
    // AppImages.BANNER,
  ];
  final RxList<LeaveTicket> leaveTickets = <LeaveTicket>[
    LeaveTicket(
      employee: 'John Doe',
      ro: 'RO001',
      leaveType: 'Loss Of Pay(LOP)',
      appliedOn: '2023-12-15',
      startDate: '2023-12-20',
      endDate: '2023-12-22',
      totalDays: '3',
      status: 'Approved',
      lastUpdatedBy: 'Admin',
    ),
    LeaveTicket(
      employee: 'Jane Smith',
      ro: 'RO002',
      leaveType: 'Loss Of Pay(LOP)',
      appliedOn: '2023-12-14',
      startDate: '2023-12-16',
      endDate: '2023-12-17',
      totalDays: '2',
      status: 'Pending',
      lastUpdatedBy: 'Manager',
    ),
    LeaveTicket(
      employee: 'Bob Johnson',
      ro: 'RO003',
      leaveType: 'Earned',
      appliedOn: '2023-12-10',
      startDate: '2023-12-25',
      endDate: '2023-12-31',
      totalDays: '7',
      status: 'Approved',
      lastUpdatedBy: 'HR',
    ),
    LeaveTicket(
      employee: 'Alice Brown',
      ro: 'RO004',
      leaveType: 'Earned',
      appliedOn: '2023-12-01',
      startDate: '2024-01-01',
      endDate: '2024-04-01',
      totalDays: '90',
      status: 'Approved',
      lastUpdatedBy: 'HR Manager',
    ),
    LeaveTicket(
      employee: 'Charlie Wilson',
      ro: 'RO005',
      leaveType: 'Earned',
      appliedOn: '2023-12-18',
      startDate: '2023-12-19',
      endDate: '2023-12-19',
      totalDays: '1',
      status: 'Rejected',
      lastUpdatedBy: 'Supervisor',
    ),
    LeaveTicket(
      employee: 'David Miller',
      ro: 'RO006',
      leaveType: 'Earned',
      appliedOn: '2023-12-12',
      startDate: '2023-12-28',
      endDate: '2023-12-29',
      totalDays: '2',
      status: 'Pending',
      lastUpdatedBy: 'Team Lead',
    ),
    LeaveTicket(
      employee: 'Eva Davis',
      ro: 'RO007',
      leaveType: 'Earned',
      appliedOn: '2023-12-05',
      startDate: '2024-01-15',
      endDate: '2024-01-30',
      totalDays: '16',
      status: 'Approved',
      lastUpdatedBy: 'HR',
    ),
    LeaveTicket(
      employee: 'Frank Thomas',
      ro: 'RO008',
      leaveType: 'Earned',
      appliedOn: '2023-12-16',
      startDate: '2023-12-18',
      endDate: '2023-12-20',
      totalDays: '3',
      status: 'Approved',
      lastUpdatedBy: 'Manager',
    ),
  ].obs;


  // Future methods for API integration (you can add later)
  Future<void> fetchData() async {
    // Implement API call here
  }

  @override
  void onInit() {
    super.onInit();
    // You can fetch initial data here
    // fetchData();
  }


}