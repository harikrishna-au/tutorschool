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

        void updateTeacher(Map<String, dynamic> teacherData) {
          this.zohoId = (teacherData['zoho_id'] ?? '') as String;
          this.id = (teacherData['id'] ?? '') as String;
          this.name = (teacherData['name'] ?? '') as String;
          this.phoneContact = (teacherData['p_contact'] ?? '') as String;
          this.secondaryContact = (teacherData['s_contact'] ?? '') as String;
          this.email = (teacherData['email'] ?? '') as String;
          this.createdAt = (teacherData['created_at'] ?? '') as String;
          this.state = (teacherData['state'] ?? '') as String;
          this.area = (teacherData['area'] ?? '') as String;
          this.pincode = (teacherData['pincode'] ?? '') as String;
          this.location = (teacherData['location'] ?? '') as String;
          this.subscriptionValidity = (teacherData['subscription_validity'] ?? '') as String;
          this.passwordLastModified = (teacherData['password_last_modified'] ?? '') as String;
          this.profilePic = (teacherData['profile_pic'] ?? '') as String;
          this.introduction = (teacherData['introduction'] ?? '') as String;
          this.teachingDesc = (teacherData['teaching_desc'] ?? '') as String;
          this.videoUrl = (teacherData['video_url'] ?? '') as String;
          this.lessonPrice = (teacherData['lesson_price'] ?? '') as String;
          this.currentStatus = (teacherData['current_status'] ?? '') as String;
          this.teachingMode = (teacherData['teaching_mode'] ?? '') as String;
          this.referral = (teacherData['referral'] ?? '') as String;
          this.basicDone = (teacherData['basic_done'] ?? false) as bool;
          this.locationDone = (teacherData['location_done'] ?? false) as bool;
          this.laterOnboardingDone = (teacherData['later_onboarding_done'] ?? false) as bool;
        }

    }
