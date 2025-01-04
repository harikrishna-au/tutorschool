class GlobalData {
  static String jwtToken = '';
  static bool goToDashboard = false;
  static String model = '';
  static Teacher teacher = Teacher();
  static String accessHash = '';
}

class Teacher {
  String zohoId = '';
  String id = '';
  String name = '';
  String phoneContact = '';
  String secondaryContact = '';
  String email = '';
  String createdAt = '';
  String state = '';
  String area = '';
  String pincode = '';
  String location = '';
  String subscriptionValidity = '';
  String passwordLastModified = '';
  String profilePic = '';
  String introduction = '';
  String teachingDesc = '';
  String videoUrl = '';
  String lessonPrice = '';
  String currentStatus = '';
  String teachingMode = '';
  String referral = '';
  bool basicDone = false;
  bool locationDone = false;
  bool laterOnboardingDone = false;

  // Constructor
  Teacher({
    this.zohoId = '',
    this.id = '',
    this.name = '',
    this.phoneContact = '',
    this.secondaryContact = '',
    this.email = '',
    this.createdAt = '',
    this.state = '',
    this.area = '',
    this.pincode = '',
    this.location = '',
    this.subscriptionValidity = '',
    this.passwordLastModified = '',
    this.profilePic = '',
    this.introduction = '',
    this.teachingDesc = '',
    this.videoUrl = '',
    this.lessonPrice = '',
    this.currentStatus = '',
    this.teachingMode = '',
    this.referral = '',
    this.basicDone = false,
    this.locationDone = false,
    this.laterOnboardingDone = false,
  });

  // Method to update the teacher's data
  void updateTeacher(Map<String, dynamic> teacherData) {
    this.zohoId = teacherData['zoho_id'] ?? '';
    this.id = teacherData['id'] ?? '';
    this.name = teacherData['name'] ?? '';
    this.phoneContact = teacherData['p_contact'] ?? '';
    this.secondaryContact = teacherData['s_contact'] ?? '';
    this.email = teacherData['email'] ?? '';
    this.createdAt = teacherData['created_at'] ?? '';
    this.state = teacherData['state'] ?? '';
    this.area = teacherData['area'] ?? '';
    this.pincode = teacherData['pincode'] ?? '';
    this.location = teacherData['location'] ?? '';
    this.subscriptionValidity = teacherData['subscription_validity'] ?? '';
    this.passwordLastModified = teacherData['password_last_modified'] ?? '';
    this.profilePic = teacherData['profile_pic'] ?? '';
    this.introduction = teacherData['introduction'] ?? '';
    this.teachingDesc = teacherData['teaching_desc'] ?? '';
    this.videoUrl = teacherData['video_url'] ?? '';
    this.lessonPrice = teacherData['lesson_price'] ?? '';
    this.currentStatus = teacherData['current_status'] ?? '';
    this.teachingMode = teacherData['teaching_mode'] ?? '';
    this.referral = teacherData['referral'] ?? '';
    this.basicDone = teacherData['basic_done'] ?? false;
    this.locationDone = teacherData['location_done'] ?? false;
    this.laterOnboardingDone = teacherData['later_onboarding_done'] ?? false;
  }
}
