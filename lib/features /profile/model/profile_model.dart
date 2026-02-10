// features/profile/domain/models/profile_model.dart

class ProfileModel {
  final String employeeName;
  final String designation;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;

  // Personal Details
  final String employeeTIS;
  final String teamName;
  final String fatherName;
  final String motherName;
  final String address;
  final String officialDOB;
  final String bloodGroup;
  final String gender;
  final String maritalStatus;
  final String aadharNumber;
  final String panNumber;

  // Company Details
  final String hrName;
  final String supportOfficer;
  final String dateOfJoining;
  final String nextAppraisalDate;

  // Bank Details
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String bankIdentifierCode;
  final String branchLocation;
  final String taxPayerId;

  // Stats
  final int totalLeaveBalance;
  final double totalLeaves;
  final double currentAppraisalPeriodLeaves;
  final int totalTickets;

  ProfileModel({
    this.employeeName = 'Mohit Parmar',
    this.designation = 'Software Engineer',
    this.email = 'mohit.parmar@example.com',
    this.phoneNumber = '+91 9876543210',
    this.profileImageUrl = 'assets/images/profile_placeholder.png',

    // Personal Details
    this.employeeTIS = 'TIS435',
    this.teamName = 'Titans',
    this.fatherName = 'Devi Prasad Parmar',
    this.motherName = 'Vimia Parmar',
    this.address = '67, Arvind Vihar, near ram mandir, baghmugaliya, Huzur, Bhopal M.P 462043',
    this.officialDOB = '1995-01-15',
    this.bloodGroup = 'O+',
    this.gender = 'Male',
    this.maritalStatus = 'Unmarried',
    this.aadharNumber = 'XXXX XXXX 1234',
    this.panNumber = 'GNZPP1266M',

    // Company Details
    this.hrName = 'Shruti Shukla',
    this.supportOfficer = 'Tikendra Maitry',
    this.dateOfJoining = 'Jan 7, 2025',
    this.nextAppraisalDate = 'Jan 1, 2026',

    // Bank Details
    this.accountHolderName = 'Mohit Parmar',
    this.accountNumber = '41131608811',
    this.bankName = 'State Bank Of India',
    this.bankIdentifierCode = 'SBIN0012275',
    this.branchLocation = 'Plot No.82-83, Shri Radha Krishna Shopping Complex, Bhopal',
    this.taxPayerId = 'N/A',

    // Stats
    this.totalLeaveBalance = 2,
    this.totalLeaves = 10.5,
    this.currentAppraisalPeriodLeaves = 10.5,
    this.totalTickets = 19,
  });
}