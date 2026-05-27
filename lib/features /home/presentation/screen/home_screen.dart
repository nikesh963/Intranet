// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../../../../core/constants/icons.dart';
// import '../../../../core/theme/app_theme.dart';
// import '../controller/home_controller.dart';
// // class HomeScreen extends StatelessWidget {
// //   HomeScreen({super.key});
// //
// //   final HomeController controller = Get.put(HomeController());
// //
// //   final ScrollController scrollController = ScrollController();
// //
// //   // SECTION KEYS
// //   final GlobalKey aboutKey = GlobalKey();
// //   final GlobalKey teamKey = GlobalKey();
// //   final GlobalKey servicesKey = GlobalKey();
// //   final GlobalKey reachKey = GlobalKey();
// //
// //   // SELECTED TAB
// //   final RxInt selectedIndex = 0.obs;
// //
// //   // SCROLL TO SECTION
// //   void scrollToSection(GlobalKey key, int index) {
// //     selectedIndex.value = index;
// //
// //     Scrollable.ensureVisible(
// //       key.currentContext!,
// //       duration: const Duration(milliseconds: 500),
// //       curve: Curves.easeInOut,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppTheme.colors.white,
// //
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //
// //             // ================= FIXED TOP NAVIGATION =================
// //
// //             Container(
// //               width: double.infinity,
// //               padding: EdgeInsets.symmetric(
// //                 horizontal: 12.w,
// //                 vertical: 14.h,
// //               ),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     blurRadius: 10,
// //                     color: Colors.black.withOpacity(0.05),
// //                     offset: const Offset(0, 3),
// //                   ),
// //                 ],
// //               ),
// //               child: SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Row(
// //                   children: [
// //                     topButton(
// //                       title: "About Us",
// //                       index: 0,
// //                       onTap: () => scrollToSection(aboutKey, 0),
// //                     ),
// //
// //                     SizedBox(width: 10.w),
// //
// //                     topButton(
// //                       title: "Our Team",
// //                       index: 1,
// //                       onTap: () => scrollToSection(teamKey, 1),
// //                     ),
// //
// //                     SizedBox(width: 10.w),
// //
// //                     topButton(
// //                       title: "Services",
// //                       index: 2,
// //                       onTap: () => scrollToSection(servicesKey, 2),
// //                     ),
// //
// //                     SizedBox(width: 10.w),
// //
// //                     topButton(
// //                       title: "Reach Us",
// //                       index: 3,
// //                       onTap: () => scrollToSection(reachKey, 3),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //
// //             // ================= SCROLLABLE BODY =================
// //
// //             Expanded(
// //               child: NotificationListener<ScrollNotification>(
// //                 onNotification: (scrollNotification) {
// //
// //                   if (aboutKey.currentContext != null &&
// //                       teamKey.currentContext != null &&
// //                       servicesKey.currentContext != null &&
// //                       reachKey.currentContext != null) {
// //
// //                     final aboutPosition =
// //                         (aboutKey.currentContext!.findRenderObject()
// //                         as RenderBox)
// //                             .localToGlobal(Offset.zero)
// //                             .dy;
// //
// //                     final teamPosition =
// //                         (teamKey.currentContext!.findRenderObject()
// //                         as RenderBox)
// //                             .localToGlobal(Offset.zero)
// //                             .dy;
// //
// //                     final servicesPosition =
// //                         (servicesKey.currentContext!.findRenderObject()
// //                         as RenderBox)
// //                             .localToGlobal(Offset.zero)
// //                             .dy;
// //
// //                     final reachPosition =
// //                         (reachKey.currentContext!.findRenderObject()
// //                         as RenderBox)
// //                             .localToGlobal(Offset.zero)
// //                             .dy;
// //
// //                     if (reachPosition <= 250) {
// //                       selectedIndex.value = 3;
// //                     } else if (servicesPosition <= 250 &&
// //                         reachPosition > 250) {
// //                       selectedIndex.value = 2;
// //                     } else if (teamPosition <= 250 &&
// //                         servicesPosition > 250) {
// //                       selectedIndex.value = 1;
// //                     } else {
// //                       selectedIndex.value = 0;
// //                     }
// //                   }
// //
// //                   return true;
// //                 },
// //
// //                 child: SingleChildScrollView(
// //                   controller: scrollController,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //
// //                       SizedBox(height: 20.h),
// //
// //                       // ================= ABOUT US =================
// //
// //                       sectionTitle(
// //                         key: aboutKey,
// //                         title: "About Us",
// //                       ),
// //
// //                       sectionText(
// //                         '''
// // We Are Techinfini!
// //
// // Techinfini is not just a web development, mobile application development or branding and promotional platform, but a thought… a very strong thought that grows stronger with every move we make, every challenge we take and every opportunity we crack… Techinfini is a game of exploration, a journey of innovation and constant quest for improvisation. We take pride and pleasure in helping the world attain enormous business growth with some of the best and advanced internet technologies.
// //
// // With us you can imagine the excitement of having a website for your corporation that allows you to interact with a wide range of population of this world. You will be surprised to hear that more than 3,00,000 people joining internet every day. And every second 4 websites are launched. Now you can imagine if you don’t think of having a website now then you will lag behind of those who accept the new technologies.
// //
// // In a nutshell, Techinfini takes you on the fast track of growth, prosperity and happiness.
// // ''',
// //                       ),
// //
// //                       SizedBox(height: 40.h),
// //
// //                       // ================= OUR TEAM =================
// //
// //                       sectionTitle(
// //                         key: teamKey,
// //                         title: "Our Team",
// //                       ),
// //
// //                       Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 16.w),
// //                         child: Text(
// //                           "Empowering Success: Our Numbers Speak Volumes",
// //                           style: TextStyle(
// //                             fontSize: 24.sp,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //
// //                       SizedBox(height: 12.h),
// //
// //                       Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 16.w),
// //                         child: Text(
// //                           "Through strategy, design, and planning we build brand identities that connect with your thoughts. We then fine-tune a marketing plan that allows us to laser focus and target your audience through the right channels.",
// //                           style: TextStyle(
// //                             fontSize: 15.sp,
// //                             color: Colors.black54,
// //                             height: 1.7,
// //                           ),
// //                         ),
// //                       ),
// //
// //                       SizedBox(height: 24.h),
// //
// //                       Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 16.w),
// //                         child: GridView.count(
// //                           shrinkWrap: true,
// //                           physics: const NeverScrollableScrollPhysics(),
// //                           crossAxisCount: 2,
// //                           crossAxisSpacing: 16.w,
// //                           mainAxisSpacing: 16.h,
// //                           childAspectRatio: 1.3,
// //                           children: [
// //                             statsCard("15", "Years Experience"),
// //                             statsCard("550+", "Projects Completed"),
// //                             statsCard("99.2%", "Client Satisfaction"),
// //                             statsCard("120+", "Team Members"),
// //                             statsCard("24/7", "Support"),
// //                             statsCard("50+", "Global Clients"),
// //                           ],
// //                         ),
// //                       ),
// //
// //                       SizedBox(height: 40.h),
// //
// //                       // // ================= SERVICES =================
// //                       //
// //                       // sectionTitle(
// //                       //   key: servicesKey,
// //                       //   title: "Services",
// //                       // ),
// //                       //
// //                       // Padding(
// //                       //   padding: EdgeInsets.symmetric(horizontal: 16.w),
// //                       //   child: Column(
// //                       //     children: [
// //                       //       serviceCard("Graphics Design"),
// //                       //       serviceCard("Mobile App Design"),
// //                       //       serviceCard("PHP Development"),
// //                       //       serviceCard("React Development"),
// //                       //       serviceCard("Shopify Development"),
// //                       //     ],
// //                       //   ),
// //                       // ),
// // // ================= SERVICES =================
// //
// //                       sectionTitle(
// //                         key: servicesKey,
// //                         title: "Services",
// //                       ),
// //
// //                       Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 16.w),
// //                         child: Column(
// //                           children: [
// //
// //                             serviceCard(
// //                               title: "Graphics Design",
// //                               description:
// //                               "We create modern and creative graphic designs that help businesses build a strong brand identity. From social media creatives to logos, banners, brochures, and marketing materials, our designs are focused on attracting users and improving brand visibility.",
// //                             ),
// //
// //                             serviceCard(
// //                               title: "Mobile App Design",
// //                               description:
// //                               "Our mobile app design services focus on creating clean, modern, and user-friendly UI/UX experiences. We design Android and iOS applications that provide smooth navigation, better engagement, and visually appealing interfaces for users.",
// //                             ),
// //
// //                             serviceCard(
// //                               title: "PHP Development",
// //                               description:
// //                               "We develop powerful and scalable web applications using PHP technologies. Our team builds secure, fast, and dynamic websites with custom backend systems, admin panels, APIs, and database management solutions for businesses.",
// //                             ),
// //
// //                             serviceCard(
// //                               title: "React Development",
// //                               description:
// //                               "Our React development services help businesses create fast and interactive web applications. We build responsive front-end interfaces with reusable components, modern UI structures, and optimized performance for better user experience.",
// //                             ),
// //
// //                             serviceCard(
// //                               title: "Shopify Development",
// //                               description:
// //                               "We provide complete Shopify development solutions for eCommerce businesses. From custom store setup and theme development to payment integration and product management, we help brands build professional online stores that drive sales.",
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       SizedBox(height: 40.h),
// //
// //                       // ================= REACH US =================
// //
// //                       sectionTitle(
// //                         key: reachKey,
// //                         title: "Reach Us",
// //                       ),
// //                       SizedBox(height: 40.h),
// //                       Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 16.w),
// //                         child: Column(
// //                           children: [
// //
// //                             locationCard(
// //                               "🇮🇳 India",
// //                               "402, Airen Heights, Scheme No. 54, Opposite C21 Mall, Indore, Madhya Pradesh 452010",
// //                             ),
// //
// //                             SizedBox(height: 16.h),
// //
// //                             locationCard(
// //                               "🇺🇸 USA",
// //                               "510 NW 84th Ave,\nPlantation, FL 33324, USA",
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //
// //
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //                       SizedBox(height: 40.h),SizedBox(height: 40.h),
// //
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ================= TOP BUTTON =================
// //
// //   Widget topButton({
// //     required String title,
// //     required int index,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Obx(
// //             () => AnimatedContainer(
// //           duration: const Duration(milliseconds: 300),
// //           padding: EdgeInsets.symmetric(
// //             horizontal: 18.w,
// //             vertical: 10.h,
// //           ),
// //           decoration: BoxDecoration(
// //             color: selectedIndex.value == index
// //                 ? Colors.blue
// //                 : Colors.transparent,
// //
// //             borderRadius: BorderRadius.circular(30.r),
// //           ),
// //
// //           child: Text(
// //             title,
// //             style: TextStyle(
// //               fontSize: 14.sp,
// //               fontWeight: FontWeight.w600,
// //               color: selectedIndex.value == index
// //                   ? Colors.white
// //                   : Colors.black,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ================= SECTION TITLE =================
// //
// //   Widget sectionTitle({
// //     required String title,
// //     required GlobalKey key,
// //   }) {
// //     return Container(
// //       key: key,
// //       padding: EdgeInsets.symmetric(horizontal: 16.w),
// //       child: Text(
// //         title,
// //         style: TextStyle(
// //           fontSize: 30.sp,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ================= SECTION TEXT =================
// //
// //   Widget sectionText(String text) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(
// //         horizontal: 16.w,
// //         vertical: 16.h,
// //       ),
// //       child: Text(
// //         text,
// //         style: TextStyle(
// //           fontSize: 15.sp,
// //           color: Colors.black54,
// //           height: 1.8,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ================= STATS CARD =================
// //
// //   Widget statsCard(String value, String title) {
// //     return Container(
// //       padding: EdgeInsets.all(18.w),
// //       decoration: BoxDecoration(
// //         color: Colors.blue.withOpacity(0.08),
// //         borderRadius: BorderRadius.circular(20.r),
// //       ),
// //
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //
// //           Text(
// //             value,
// //             style: TextStyle(
// //               fontSize: 28.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.blue,
// //             ),
// //           ),
// //
// //           SizedBox(height: 8.h),
// //
// //           Text(
// //             title,
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: 14.sp,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ================= SERVICE CARD =================
// //
// //   Widget serviceCard({
// //     required String title,
// //     required String description,
// //   }) {
// //     return Container(
// //       width: double.infinity,
// //       margin: EdgeInsets.only(bottom: 18.h),
// //       padding: EdgeInsets.all(18.w),
// //
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20.r),
// //
// //         boxShadow: [
// //           BoxShadow(
// //             blurRadius: 10,
// //             color: Colors.black.withOpacity(0.05),
// //             offset: const Offset(0, 3),
// //           ),
// //         ],
// //       ),
// //
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //
// //           Text(
// //             title,
// //             style: TextStyle(
// //               fontSize: 18.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.blue,
// //             ),
// //           ),
// //
// //           SizedBox(height: 10.h),
// //
// //           Text(
// //             description,
// //             style: TextStyle(
// //               fontSize: 14.sp,
// //               color: Colors.black54,
// //               height: 1.7,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ================= LOCATION CARD =================
// //
// //   Widget locationCard(String title, String address) {
// //     return Container(
// //       width: double.infinity,
// //       padding: EdgeInsets.all(18.w),
// //
// //       decoration: BoxDecoration(
// //         color: Colors.grey.shade100,
// //         borderRadius: BorderRadius.circular(20.r),
// //       ),
// //
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //
// //           Text(
// //             title,
// //             style: TextStyle(
// //               fontSize: 20.sp,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //
// //           SizedBox(height: 12.h),
// //
// //           Text(
// //             address,
// //             style: TextStyle(
// //               fontSize: 15.sp,
// //               height: 1.7,
// //               color: Colors.black54,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});
//   // final HomeController controller = Get.find<HomeController>();
//   final HomeController controller = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header with time and welcome
//                 _buildHeader(context),
//                 SizedBox(height: 24.h),
//
//               _buildBannerCarousel(),
//
//
//                 SizedBox(height: 16.h),
//
//                 Center(
//                   child: Obx(() {
//                     final challenges = controller.bannerImages;
//                     if (challenges.isEmpty) return SizedBox.shrink();
//                     return AnimatedSmoothIndicator(
//                       activeIndex: controller.currentBannerIndex.value,
//                       count: challenges.length,
//                       effect: ExpandingDotsEffect(
//                         dotWidth: 8.h,
//                         dotHeight: 8.h,
//                         activeDotColor: AppTheme.colors.black,
//                         dotColor: Colors.grey,
//                       ),
//                     );
//                   }
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 // Main content
//                 _buildMainContent(context),
//                 SizedBox(height: 10.h),
// Divider(),
//                 SizedBox(height: 10.h),
//                 // Tickets section
//                 _buildTicketsSection(),
//                 SizedBox(height: 24.h),
//
//                 // Pagination
//                 _buildPagination(),
//                 SizedBox(height: 10.h,),
//                 Divider(),
//                 // SizedBox(height: 10.h,)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         Material(
//           borderRadius: BorderRadius.circular(50.r),
//           color: Colors.transparent,
//           elevation: 0,
//           // color: Colors.transparent,
//           child: InkWell(
//             customBorder: const CircleBorder(), // 👈 ripple is circular
//             onTap: () async {
//               HapticFeedback.selectionClick(); // 👈 small vibration
//               await Future.delayed(
//                   const Duration(milliseconds: 300)); // 👈 smooth delay
//               // Get.toNamed(AppRoutes.profile);
//               // dashboardController.updateSelectedTabIndex(3);
//             },
//             child: Container(
//               // width: 47.r,
//               // height: 47.r,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
//                 shape: BoxShape.circle,
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(10.w),
//                 child: SvgPicture.asset(
//                   AppIcons.ATTENDANCE,
//                   // controller.userAvatar, // your svg path
//                   width: 35.w, // match the diameter
//                   height: 35.h,
//                   color:
//                   AppTheme.colors.black, // Dark theme → your grey
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 4.w,),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//
//             // Welcome message
//             Row(
//               children: [
//                 Text(
//                   "Hello, ",
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w600,
//                     // color: AppTheme.colors.textPrimary,
//                   ),
//                 ),
//                 Text(
//                   "Rahul",
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppTheme.colors.blue
//                     // color: AppTheme.colors.textPrimary,
//                   ),
//                 ),
//               ],
//             ),
//             // SizedBox(height: 8.h),
//             Text(
//               "Let's find what you need today",
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w400,
//                 // color: AppTheme.colors.textSecondary,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBannerCarousel() {
//     final banners = controller.bannerImages;
//
//     if (banners.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return CarouselSlider.builder(
//       itemCount: banners.length,
//       options: CarouselOptions(
//         autoPlay: true,
//         enlargeCenterPage: false,
//         autoPlayInterval: Duration(seconds: 5),
//         viewportFraction: 1,
//         onPageChanged: (index, reason) {
//           controller.currentBannerIndex.value = index;
//
//         },
//       ),
//       itemBuilder: (context, index, realIndex) {
//         final imagePath = banners[index];
//
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
//           child: Container(
//             padding: EdgeInsets.all(3.w),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25.r),
//               border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.r),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.values[1],
//                 width: double.infinity,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//   Widget _buildMainContent(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         // color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//
//       ),
//       child: Column(
//         children: [
//           // Leave balances
//           _buildLeaveBalances(),
//           SizedBox(height: 16.h),
//           // Tickets summary
//           _buildTicketsSummary(),
//         ],
//       ),
//     );
//   }
//   Widget _buildLeaveBalances() {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(18.w),
//             decoration: BoxDecoration(
//               color: AppTheme.colors.white,
//               border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//
//                 Text(
//                   "Total Leave Balance",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     // color: AppTheme.colors.textSecondary,
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Text(
//                   "2",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppTheme.colors.blue
//                     // color: AppTheme.colors.success,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(width: 12.w),
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(18.w),
//             decoration: BoxDecoration(
//               color: AppTheme.colors.white,
//               border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Total Leaves",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     // color: AppTheme.colors.textSecondary,
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Text(
//                   "10.5",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppTheme.colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTicketsSummary() {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(8.w),
//             decoration: BoxDecoration(
//               // color: AppTheme.colors.warningLight,
//               color: AppTheme.colors.white,
//               border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Current Appraisal\n Period Leaves",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     // color: AppTheme.colors.textSecondary,
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Text(
//                   "10.5",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppTheme.colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(width: 12.w),
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(18.w),
//             decoration: BoxDecoration(
//               color: AppTheme.colors.white,
//               border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
//               // color: AppTheme.colors.errorLight,
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Total Tickets",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     // color: AppTheme.colors.textSecondary,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   "19",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppTheme.colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//     Widget _buildTicketsSection() {
//     // Create a ScrollController for the horizontal scrolling
//     final ScrollController _horizontalScrollController = ScrollController();
//     final ValueNotifier<bool> _isScrollingNotifier = ValueNotifier<bool>(false);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(bottom: 16.h,left: 16.w),
//           child: Text(
//             "Tickets",
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.r),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: Colors.black.withOpacity(0.05),
//             //     blurRadius: 4,
//             //     offset: const Offset(0, 2),
//             //   ),
//             // ],
//           ),
//           child: Column(
//             children: [
//               NotificationListener<ScrollNotification>(
//                 onNotification: (notification) {
//                   if (notification is ScrollStartNotification ||
//                       notification is ScrollUpdateNotification) {
//                     _isScrollingNotifier.value = true;
//                   } else if (notification is ScrollEndNotification) {
//                     Future.delayed(Duration(milliseconds: 500), () {
//                       _isScrollingNotifier.value = false;
//                     });
//                   }
//                   return false;
//                 },
//                 child: Obx(() {
//                   return SingleChildScrollView(
//                     controller: _horizontalScrollController,
//                     scrollDirection: Axis.horizontal,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Table Header
//                         Container(
//                           width: _calculateTotalWidth(),
//                                   padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
//                           decoration: BoxDecoration(
//                             color: AppTheme.colors.gray,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(8.r),
//                               topRight: Radius.circular(8.r),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               _buildHeaderCell("Employee", 120.w),
//                               _buildHeaderCell("RO", 80.w),
//                               _buildHeaderCell("Leave Type", 100.w),
//                               _buildHeaderCell("Applied On", 100.w),
//                               _buildHeaderCell("Start Date", 100.w),
//                               _buildHeaderCell("End Date", 100.w),
//                               _buildHeaderCell("Total Days", 100.w),
//                               _buildHeaderCell("Status", 100.w),
//                               _buildHeaderCell("Last Updated By", 130.w),
//                             ],
//                           ),
//                         ),
//
//                         // Table Body
//                         Column(
//                           children: controller.leaveTickets.asMap().entries.map((entry) {
//                             final index = entry.key;
//                             final ticket = entry.value;
//
//                             return Container(
//                               width: _calculateTotalWidth(),
//                               padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   bottom: index == controller.leaveTickets.length - 1
//                                       ? BorderSide.none
//                                       : BorderSide(
//                                     color: AppTheme.colors.gray,
//                                     width: 1,
//                                   ),
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   _buildDataCell(ticket.employee, 120.w),
//                                   _buildDataCell(ticket.ro, 80.w),
//                                   _buildLeaveTypeCell(ticket.leaveType, 100.w),
//                                   _buildDataCell(ticket.appliedOn, 100.w),
//                                   _buildDataCell(ticket.startDate, 100.w),
//                                   _buildDataCell(ticket.endDate, 100.w),
//                                   _buildTotalDaysCell(ticket.totalDays, 100.w),
//                                   _buildStatusCell(ticket.status, 100.w),
//                                   // _buildDataCell(ticket.lastUpdatedBy, 130.w),
//                                   _buildDataCell(ticket.lastUpdatedBy, 130.w, padding: EdgeInsets.only(left: 18.w)),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//
//               // Blue Scroll Indicator at the bottom
//               Container(
//                 height: 6.h,
//                 margin: EdgeInsets.symmetric(vertical: 8.h),
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     final totalWidth = _calculateTotalWidth();
//                     final visibleWidth = MediaQuery.of(context).size.width - 32.w; // Screen width minus padding
//
//                     // Only show scroll indicator if content is wider than screen
//                     if (totalWidth <= visibleWidth) {
//                       return SizedBox.shrink();
//                     }
//
//                     return ValueListenableBuilder<bool>(
//                       valueListenable: _isScrollingNotifier,
//                       builder: (context, isScrolling, child) {
//                         return AnimatedOpacity(
//                           opacity: isScrolling ? 1.0 : 0.7,
//                           duration: Duration(milliseconds: 300),
//                           child: Container(
//                             width: constraints.maxWidth,
//                             child: Stack(
//                               children: [
//                                 // Background track
//                                 Container(
//                                   width: constraints.maxWidth,
//                                   height: 3.h,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(1.5.r),
//                                   ),
//                                 ),
//
//                                 // Blue scroll thumb
//                                 AnimatedBuilder(
//                                   animation: _horizontalScrollController,
//                                   builder: (context, child) {
//                                     final scrollOffset = _horizontalScrollController.hasClients
//                                         ? _horizontalScrollController.offset
//                                         : 0.0;
//                                     final maxScrollExtent = _horizontalScrollController.hasClients
//                                         ? _horizontalScrollController.position.maxScrollExtent
//                                         : 1.0;
//
//                                     final thumbWidth = (visibleWidth / totalWidth) * constraints.maxWidth;
//                                     final thumbPosition = maxScrollExtent > 0
//                                         ? (scrollOffset / maxScrollExtent) * (constraints.maxWidth - thumbWidth)
//                                         : 0.0;
//
//                                     return Positioned(
//                                       left: thumbPosition.clamp(0.0, constraints.maxWidth - thumbWidth),
//                                       child: Container(
//                                         width: thumbWidth,
//                                         height: 4.h,
//                                         decoration: BoxDecoration(
//                                           color: Colors.blue, // Blue color
//                                             borderRadius: BorderRadius.circular(2.r),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.blue.withOpacity(0.3),
//                                               blurRadius: 2,
//                                               offset: Offset(0, 1),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//   Widget  _buildHeaderCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildDataCell(String text, double width) {
//   //   return SizedBox(
//   //     width: width,
//   //     child: Padding(
//   //       padding: EdgeInsets.symmetric(horizontal: 8.w),
//   //       child: Text(
//   //         text,
//   //         style: TextStyle(
//   //           fontSize: 14.sp,
//   //           fontWeight: FontWeight.w400,
//   //         ),
//   //         overflow: TextOverflow.ellipsis,
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildDataCell(String text, double width, {EdgeInsetsGeometry? padding}) {
//     return SizedBox(
//       width: width,
//       child: Padding(
//         padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w400,
//           ),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLeaveTypeCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4.r),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTotalDaysCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusCell(String text, double width) {
//     return SizedBox(
//       width: width,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
//         decoration: BoxDecoration(
//           color: _getStatusColor(text),
//           borderRadius: BorderRadius.circular(4.r),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//             color: AppTheme.colors.white
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   double _calculateTotalWidth() {
//     return 120.w + 80.w + 100.w + 100.w + 100.w + 100.w + 100.w + 100.w + 130.w + (16.w * 2);
//   }
// // Helper methods for styling
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'rejected':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//
//   Widget _buildPagination() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Text: "1 of 13 Pages"
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Text(
//             "1 of 13 Pages",
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               // color: AppTheme.colors.textSecondary,
//             ),
//           ),
//         ),
//
//         // Right side: Page selector and arrows
//         Row(
//           children: [
//             // "Page" text
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//               child: Text(
//                 "Page",
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   // color: AppTheme.colors.textSecondary,
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//
//             // Page number dropdown/input
//             Container(
//               width: 45.w,
//               height: 35.h,
//               padding: EdgeInsets.only(left: 8.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4.r),
//                 border: Border.all(
//                   color: AppTheme.colors.black.withOpacity(0.2),
//                   width: 1.w,
//                 ),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: "1",
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     // size: 20.w,
//                     // color: AppTheme.colors.textSecondary,
//                   ),
//                   isExpanded: true,
//                   items: List.generate(2, (index) => (index + 1).toString())
//                       .map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     // Handle page change
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(width: 16.w),
//
//             // Back arrow
//             GestureDetector(
//               onTap: () {
//                 // Handle previous page
//               },
//               child: Container(
//                 padding: EdgeInsets.all(8.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   // shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppTheme.colors.black.withOpacity(0.2),
//                     width: 1.w,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.arrow_back,
//                   size: 20.w,
//                   // color: AppTheme.colors.textSecondary,
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//
//             // Forward arrow
//             GestureDetector(
//               onTap: () {
//                 // Handle next page
//               },
//               child: Container(
//                 padding: EdgeInsets.all(8.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   // shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppTheme.colors.black.withOpacity(0.2),
//                     width: 1.w,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.arrow_forward,
//                   size: 20.w,
//                   // color: AppTheme.colors.textSecondary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../Common/AppLogger.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.fetchEmployeeProfile();
    });
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.refreshData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with time and welcome
                  _buildHeader(context),
                  // SizedBox(height: 24.h),

                  // _buildBannerCarousel(),
                  // SizedBox(height: 16.h),
                  //
                  // Center(
                  //   child: Obx(() {
                  //     final challenges = controller.bannerImages;
                  //     if (challenges.isEmpty) return const SizedBox.shrink();
                  //     return AnimatedSmoothIndicator(
                  //       activeIndex: controller.currentBannerIndex.value,
                  //       count: challenges.length,
                  //       effect: ExpandingDotsEffect(
                  //         dotWidth: 8.h,
                  //         dotHeight: 8.h,
                  //         activeDotColor: AppTheme.colors.black,
                  //         dotColor: Colors.grey,
                  //       ),
                  //     );
                  //   }),
                  // ),
                  // SizedBox(height: 24.h),
                  //
                  // // Loading indicator for main content
                  Obx(() {
                    if (controller.isLoading.value) {
                      // return Center(
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 40.h),
                      //     child: CircularProgressIndicator(
                      //       color: AppTheme.colors.blue,
                      //     ),
                      //   ),
                      // );
                      return _buildHomeShimmer();
                    }

                    return Column(
                      children: [
                        // Main content
                        _buildMainContent(context),
                        SizedBox(height: 10.h),
                        const Divider(),
                        SizedBox(height: 10.h),

                        // Tickets section
                        _buildTicketsSection(),
                        // SizedBox(height: 24.h),
                        //
                        // // Pagination
                        // _buildPagination(),
                        SizedBox(height: 10.h),
                        const Divider(),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(() => Row(
      children: [
        Material(
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () async {
              HapticFeedback.selectionClick();
              await Future.delayed(const Duration(milliseconds: 300));
              // Navigate to profile
            },
            // child: Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.all(10.w),
            //     child: SvgPicture.asset(
            //       AppIcons.ATTENDANCE,
            //       width: 35.w,
            //       height: 35.h,
            //       color: AppTheme.colors.black,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppTheme.colors.black.withOpacity(0.1),
                ),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: (controller.employeeDetails.value?.profileImage != null &&
                    controller.employeeDetails.value!.profileImage!.isNotEmpty)
                    ? ClipOval(
                  child: Image.network(
                    controller.employeeDetails.value!.profileImage!,
                    width: 35.w,
                    height: 35.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        AppIcons.PROFILE,
                        width: 35.w,
                        height: 35.h,
                        color: AppTheme.colors.black,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
                    : SvgPicture.asset(
                  AppIcons.PROFILE,
                  width: 35.w,
                  height: 35.h,
                  color: AppTheme.colors.black,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Hello, ",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  controller.getEmployeeName(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
                  ),
                ),
              ],
            ),
            Text(
              "Let's find what you need today",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _buildBannerCarousel() {
    final banners = controller.bannerImages;

    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: banners.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,
        autoPlayInterval: const Duration(seconds: 5),
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          controller.currentBannerIndex.value = index;
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final imagePath = banners[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Leave balances
          _buildLeaveBalances(),
          SizedBox(height: 16.h),
          // Tickets summary
          _buildTicketsSummary(),
        ],
      ),
    );
  }

  Widget _buildLeaveBalances() {
    return Obx(() => Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 8.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Leave Balance",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // SizedBox(width: 8.w),
                Text(
                  controller.totalEarnLeave.value.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Leaves",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  controller.totalLeaves.value.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildTicketsSummary() {
    return Obx(() => Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current Appraisal\n Period Leaves",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  controller.totalLeavesAppraisal.value.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: AppTheme.colors.white,
              border: Border.all(color: AppTheme.colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Tickets",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  controller.totalTickets.value.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  // Widget _buildTicketsSection() {
  //   final ScrollController _horizontalScrollController = ScrollController();
  //   final ValueNotifier<bool> _isScrollingNotifier = ValueNotifier<bool>(false);
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(bottom: 16.h, left: 16.w),
  //         child: Text(
  //           "Recent Leaves",
  //           style: TextStyle(
  //             fontSize: 20.sp,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //
  //       Obx(() {
  //         if (controller.isLoading.value) {
  //           return Center(
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(vertical: 40.h),
  //               child: CircularProgressIndicator(
  //                 color: AppTheme.colors.blue,
  //               ),
  //             ),
  //           );
  //         }
  //
  //         if (controller.recentLeaves.isEmpty) {
  //           return Center(
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(vertical: 40.h),
  //               child: Text(
  //                 "No recent leaves found",
  //                 style: TextStyle(
  //                   fontSize: 16.sp,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }
  //
  //         return Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8.r),
  //           ),
  //           child: Column(
  //             children: [
  //               NotificationListener<ScrollNotification>(
  //                 onNotification: (notification) {
  //                   if (notification is ScrollStartNotification ||
  //                       notification is ScrollUpdateNotification) {
  //                     _isScrollingNotifier.value = true;
  //                   } else if (notification is ScrollEndNotification) {
  //                     Future.delayed(const Duration(milliseconds: 500), () {
  //                       _isScrollingNotifier.value = false;
  //                     });
  //                   }
  //                   return false;
  //                 },
  //                 child: SingleChildScrollView(
  //                   controller: _horizontalScrollController,
  //                   scrollDirection: Axis.horizontal,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Table Header
  //                       Container(
  //                         width: _calculateTotalWidth(),
  //                         padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
  //                         decoration: BoxDecoration(
  //                           color: AppTheme.colors.gray,
  //                           borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(8.r),
  //                             topRight: Radius.circular(8.r),
  //                           ),
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             _buildHeaderCell("Employee", 120.w),
  //                             _buildHeaderCell("RO", 80.w),
  //                             _buildHeaderCell("Leave Type", 120.w),
  //                             _buildHeaderCell("Applied On", 100.w),
  //                             _buildHeaderCell("Start Date", 100.w),
  //                             _buildHeaderCell("End Date", 100.w),
  //                             _buildHeaderCell("Total Days", 100.w),
  //                             _buildHeaderCell("Status", 100.w),
  //                             _buildHeaderCell("Last Updated By", 130.w),
  //                           ],
  //                         ),
  //                       ),
  //
  //                       // Table Body
  //                       Column(
  //                         children: controller.recentLeaves.asMap().entries.map((entry) {
  //                           final index = entry.key;
  //                           final leave = entry.value;
  //
  //                           return Container(
  //                             width: _calculateTotalWidth(),
  //                             padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 bottom: index == controller.recentLeaves.length - 1
  //                                     ? BorderSide.none
  //                                     : BorderSide(
  //                                   color: AppTheme.colors.gray,
  //                                   width: 1,
  //                                 ),
  //                               ),
  //                             ),
  //                             child: Row(
  //                               children: [
  //                                 _buildDataCell(leave.employeeName ?? 'N/A', 120.w),
  //                                 _buildDataCell(leave.roName ?? 'N/A', 80.w),
  //                                 _buildLeaveTypeCell(leave.leaveTypeName ?? 'N/A', 120.w,padding: EdgeInsets.only(right: 28.w)),
  //                                 _buildDataCell(controller.formatDate(leave.appliedOn), 100.w,padding: EdgeInsets.only(right: 8.w)),
  //                                 _buildDataCell(controller.formatDate(leave.startDate), 100.w),
  //                                 _buildDataCell(controller.formatDate(leave.endDate), 100.w),
  //                                 _buildTotalDaysCell(leave.totalLeaveDays ?? '0', 100.w),
  //                                 _buildStatusCell(leave.status ?? 'Pending', 100.w),
  //                                 _buildDataCell(leave.lastUpdatedByName ?? 'N/A', 130.w, padding: EdgeInsets.only(left: 18.w)),
  //                               ],
  //                             ),
  //                           );
  //                         }).toList(),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //
  //               // Scroll Indicator
  //               Container(
  //                 height: 6.h,
  //                 margin: EdgeInsets.symmetric(vertical: 8.h),
  //                 child: LayoutBuilder(
  //                   builder: (context, constraints) {
  //                     final totalWidth = _calculateTotalWidth();
  //                     final visibleWidth = MediaQuery.of(context).size.width - 32.w;
  //
  //                     if (totalWidth <= visibleWidth) {
  //                       return const SizedBox.shrink();
  //                     }
  //
  //                     return ValueListenableBuilder<bool>(
  //                       valueListenable: _isScrollingNotifier,
  //                       builder: (context, isScrolling, child) {
  //                         return AnimatedOpacity(
  //                           opacity: isScrolling ? 1.0 : 0.7,
  //                           duration: const Duration(milliseconds: 300),
  //                           child: Container(
  //                             width: constraints.maxWidth,
  //                             child: Stack(
  //                               children: [
  //                                 Container(
  //                                   width: constraints.maxWidth,
  //                                   height: 3.h,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.grey[200],
  //                                     borderRadius: BorderRadius.circular(1.5.r),
  //                                   ),
  //                                 ),
  //                                 AnimatedBuilder(
  //                                   animation: _horizontalScrollController,
  //                                   builder: (context, child) {
  //                                     final scrollOffset = _horizontalScrollController.hasClients
  //                                         ? _horizontalScrollController.offset
  //                                         : 0.0;
  //                                     final maxScrollExtent = _horizontalScrollController.hasClients
  //                                         ? _horizontalScrollController.position.maxScrollExtent
  //                                         : 1.0;
  //
  //                                     final thumbWidth = (visibleWidth / totalWidth) * constraints.maxWidth;
  //                                     final thumbPosition = maxScrollExtent > 0
  //                                         ? (scrollOffset / maxScrollExtent) * (constraints.maxWidth - thumbWidth)
  //                                         : 0.0;
  //
  //                                     return Positioned(
  //                                       left: thumbPosition.clamp(0.0, constraints.maxWidth - thumbWidth),
  //                                       child: Container(
  //                                         width: thumbWidth,
  //                                         height: 4.h,
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.blue,
  //                                           borderRadius: BorderRadius.circular(2.r),
  //                                           boxShadow: [
  //                                             BoxShadow(
  //                                               color: Colors.blue.withOpacity(0.3),
  //                                               blurRadius: 2,
  //                                               offset: const Offset(0, 1),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       }),
  //     ],
  //   );
  // }
  Widget _buildTicketsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.only(
            bottom: 16.h,
            left: 4.w,
          ),
          child: Text(
            "Recent Leaves",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Obx(() {

          if (controller.isLoading.value) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: CircularProgressIndicator(
                  color: AppTheme.colors.blue,
                ),
              ),
            );
          }

          if (controller.recentLeaves.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  "No recent leaves found",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.recentLeaves.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: 12.h),

            itemBuilder: (context, index) {

              final leave = controller.recentLeaves[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),

                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),

                  child: ExpansionTile(

                    tilePadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),

                    childrenPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),

                    expandedCrossAxisAlignment:
                    CrossAxisAlignment.start,

                    /// Avatar
                    leading: CircleAvatar(
                      radius: 18.r,
                      backgroundColor:
                      AppTheme.colors.blue.withOpacity(0.1),

                      child: Text(
                        (leave.employeeName ?? "N")[0],
                        style: TextStyle(
                          color: AppTheme.colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// Employee Name
                    title: Text(
                      leave.employeeName ?? "N/A",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    /// Leave Type
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        leave.leaveTypeName ?? "N/A",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    /// Right Side
                    trailing: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [

                        /// Total Days
                        Text(
                          "${leave.totalLeaveDays ?? '0'} Days",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 6.h),

                        /// Status
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),

                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              leave.status ?? "Pending",
                            ),

                            borderRadius:
                            BorderRadius.circular(20.r),
                          ),

                          child: Text(
                            leave.status ?? "Pending",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Expanded Details
                    children: [

                      _buildDetailRow(
                        "RO",
                        leave.roName ?? "N/A",
                      ),

                      _buildDetailRow(
                        "Applied On",
                        controller.formatDate(
                          leave.appliedOn,
                        ),
                      ),

                      _buildDetailRow(
                        "Start Date",
                        controller.formatDate(
                          leave.startDate,
                        ),
                      ),

                      _buildDetailRow(
                        "End Date",
                        controller.formatDate(
                          leave.endDate,
                        ),
                      ),

                      _buildDetailRow(
                        "Last Updated By",
                        leave.lastUpdatedByName ?? "N/A",
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
  Widget _buildDetailRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approve':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildHomeShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [

          /// Header
          Row(
            children: [
              Container(
                width: 55.w,
                height: 55.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(width: 12.w),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140.w,
                    height: 14.h,
                    color: Colors.white,
                  ),

                  SizedBox(height: 8.h),

                  Container(
                    width: 180.w,
                    height: 10.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 24.h),

          /// Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          /// Recent Leaves
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [

                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            width: 120.w,
                            height: 12.h,
                            color: Colors.white,
                          ),

                          SizedBox(height: 8.h),

                          Container(
                            width: 80.w,
                            height: 10.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 60.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}