// features/profile/domain/models/edit_profile_model.dart

class EditProfileModel {
  // Basic Info
  String profileImagePath;
  String firstName;
  String lastName;

  // Personal Details
  String employeeTIS;
  String teamName;
  String fatherName;
  String motherName;
  String phone;
  String personalEmail;
  String officialDOB;
  String bloodGroup;
  String height;
  String weight;
  String aadharNumber;
  String alternateContact;
  String emergencyContact;
  String emergencyContactPerson;
  String gender;
  String maritalStatus;
  String panNumber;
  String passportNumber;
  String electionCardNumber;
  String drivingLicenseNumber;
  String permanentAddress;
  String temporaryAddress;

  // Company Details
  String hrName;
  String supportOfficer;
  String designation;
  String dateOfJoining;
  String previousAppraisalDue;
  String nextAppraisalDue;
  String allowedLeaves;

  // Bank Details
  String accountHolderName;
  String accountNumber;
  String bankName;
  String bankIdentifierCode;
  String branchLocation;
  String taxPayerId;

  // Social Profiles
  String techinfiniSkypeId;
  String facebookUrl;
  String twitterUrl;
  String googlePlusUrl;
  String linkedInUrl;

  EditProfileModel({
    this.profileImagePath = '',
    this.firstName = 'Mohit',
    this.lastName = 'Parmar',

    // Personal Details
    this.employeeTIS = 'TIS435',
    this.teamName = 'Titans',
    this.fatherName = 'Devi Prasad Parmar',
    this.motherName = 'Vimla Parmar',
    this.phone = '+91 9876543210',
    this.personalEmail = 'mohit.personal@example.com',
    this.officialDOB = '1995-01-15',
    this.bloodGroup = 'B+',
    this.height = '175 cm',
    this.weight = '70 kg',
    this.aadharNumber = '740710908677',
    this.alternateContact = '+91 9876543211',
    this.emergencyContact = '+91 9876543212',
    this.emergencyContactPerson = 'Rahul Verma',
    this.gender = 'Male',
    this.maritalStatus = 'Unmarried',
    this.panNumber = 'GNZPP1296M',
    this.passportNumber = 'Z1234567',
    this.electionCardNumber = 'ABC1234567',
    this.drivingLicenseNumber = 'DL1234567890123',
    this.permanentAddress = '67, Arvind Vihar, near ram mandir,\nbaghmugaliya, Huzur, Bhopal M.P 462043',
    this.temporaryAddress = 'Same as permanent',

    // Company Details
    this.hrName = 'Shruti Shukla',
    this.supportOfficer = 'Tikendra Maitry',
    this.designation = 'Software Engineer',
    this.dateOfJoining = 'Jan 7, 2025',
    this.previousAppraisalDue = 'Not Applicable',
    this.nextAppraisalDue = 'Jan 1, 2026',
    this.allowedLeaves = '20',

    // Bank Details
    this.accountHolderName = 'Mohit Parmar',
    this.accountNumber = '41131608811',
    this.bankName = 'State Bank of India',
    this.bankIdentifierCode = 'SBIN0012275',
    this.branchLocation = 'Plot No.82-83, Shri Radha Krishna Shopping Complex, Bhopal',
    this.taxPayerId = 'N/A',

    // Social Profiles
    this.techinfiniSkypeId = 'mohit.parmar',
    this.facebookUrl = 'https://facebook.com/mohit.parmar',
    this.twitterUrl = 'https://twitter.com/mohit_parmar',
    this.googlePlusUrl = '',
    this.linkedInUrl = 'https://linkedin.com/in/mohit-parmar',
  });

  EditProfileModel copyWith({
    String? profileImagePath,
    String? firstName,
    String? lastName,

    // Personal Details
    String? employeeTIS,
    String? teamName,
    String? fatherName,
    String? motherName,
    String? phone,
    String? personalEmail,
    String? officialDOB,
    String? bloodGroup,
    String? height,
    String? weight,
    String? aadharNumber,
    String? alternateContact,
    String? emergencyContact,
    String? emergencyContactPerson,
    String? gender,
    String? maritalStatus,
    String? panNumber,
    String? passportNumber,
    String? electionCardNumber,
    String? drivingLicenseNumber,
    String? permanentAddress,
    String? temporaryAddress,

    // Company Details
    String? hrName,
    String? supportOfficer,
    String? designation,
    String? dateOfJoining,
    String? previousAppraisalDue,
    String? nextAppraisalDue,
    String? allowedLeaves,

    // Bank Details
    String? accountHolderName,
    String? accountNumber,
    String? bankName,
    String? bankIdentifierCode,
    String? branchLocation,
    String? taxPayerId,

    // Social Profiles
    String? techinfiniSkypeId,
    String? facebookUrl,
    String? twitterUrl,
    String? googlePlusUrl,
    String? linkedInUrl,
  }) {
    return EditProfileModel(
      profileImagePath: profileImagePath ?? this.profileImagePath,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,

      // Personal Details
      employeeTIS: employeeTIS ?? this.employeeTIS,
      teamName: teamName ?? this.teamName,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      phone: phone ?? this.phone,
      personalEmail: personalEmail ?? this.personalEmail,
      officialDOB: officialDOB ?? this.officialDOB,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      aadharNumber: aadharNumber ?? this.aadharNumber,
      alternateContact: alternateContact ?? this.alternateContact,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyContactPerson: emergencyContactPerson ?? this.emergencyContactPerson,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      panNumber: panNumber ?? this.panNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      electionCardNumber: electionCardNumber ?? this.electionCardNumber,
      drivingLicenseNumber: drivingLicenseNumber ?? this.drivingLicenseNumber,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      temporaryAddress: temporaryAddress ?? this.temporaryAddress,

      // Company Details
      hrName: hrName ?? this.hrName,
      supportOfficer: supportOfficer ?? this.supportOfficer,
      designation: designation ?? this.designation,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      previousAppraisalDue: previousAppraisalDue ?? this.previousAppraisalDue,
      nextAppraisalDue: nextAppraisalDue ?? this.nextAppraisalDue,
      allowedLeaves: allowedLeaves ?? this.allowedLeaves,

      // Bank Details
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      bankIdentifierCode: bankIdentifierCode ?? this.bankIdentifierCode,
      branchLocation: branchLocation ?? this.branchLocation,
      taxPayerId: taxPayerId ?? this.taxPayerId,

      // Social Profiles
      techinfiniSkypeId: techinfiniSkypeId ?? this.techinfiniSkypeId,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      googlePlusUrl: googlePlusUrl ?? this.googlePlusUrl,
      linkedInUrl: linkedInUrl ?? this.linkedInUrl,
    );
  }

  // Method to check if any editable field has changed
  bool hasChanges(EditProfileModel original) {
    return profileImagePath != original.profileImagePath ||
        motherName != original.motherName ||
        phone != original.phone ||
        height != original.height ||
        weight != original.weight ||
        alternateContact != original.alternateContact ||
        emergencyContact != original.emergencyContact ||
        emergencyContactPerson != original.emergencyContactPerson ||
        maritalStatus != original.maritalStatus ||
        passportNumber != original.passportNumber ||
        temporaryAddress != original.temporaryAddress ||
        techinfiniSkypeId != original.techinfiniSkypeId ||
        facebookUrl != original.facebookUrl ||
        twitterUrl != original.twitterUrl ||
        googlePlusUrl != original.googlePlusUrl ||
        linkedInUrl != original.linkedInUrl;
  }
}