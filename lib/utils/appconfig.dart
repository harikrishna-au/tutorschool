class AppConfig {
  static const String _localEnvHttpBaseUrl = "http://localhost:5000";
  static const String _prodEnvHttpBaseUrl = "https://api.tutorschool.in";

  static String _environmentName = "";

  static String get environmentName => _environmentName;

  static void initialize({String environment = 'prod'}) {
    _environmentName = environment;
  }

  static String get _httpBaseUrl => _environmentName == "dev"
      ? _localEnvHttpBaseUrl
      : _prodEnvHttpBaseUrl;

  static String get teacherVerifyUrl => "$_httpBaseUrl/auth/teacher/verify";


  static String get teacherGoogleAuthUrl => "$_httpBaseUrl/auth/teacher/google";

  static String get teacherLoginUrl => "$_httpBaseUrl/auth/teacher/login";


  static String get teacherProfilePicUploadUrl =>
      "$_httpBaseUrl/upload/teacher/profile_pic";


  static String get teacherOnboardingProfilePicUrl =>
      "$_httpBaseUrl/onboarding/teacher/profile_pic";


  static String get certificationAddUrl => "$_httpBaseUrl/certification/add";


  static String get subjectsUrl => "$_httpBaseUrl/subject";


  static String get subjectCreateUrl => "$_httpBaseUrl/subject/create";


  static String get teacherOnboardingCertificationUrl =>
      "$_httpBaseUrl/onboarding/teacher/certification";


  static String get teacherVideoUploadUrl =>
      "$_httpBaseUrl/upload/teacher/video";


  static String get teacherOnboardingVideoUrl =>
      "$_httpBaseUrl/onboarding/teacher/video";


  static String get teacherOnboardingEducationUrl =>
      "$_httpBaseUrl/onboarding/teacher/education";


  static String get teacherOnboardingDescriptionUrl =>
      "$_httpBaseUrl/onboarding/teacher/description";


  static String get teacherOnboardingLocationUrl =>
      "$_httpBaseUrl/onboarding/teacher/location";


  static String get teacherOnboardingAvailabilityUrl =>
      "$_httpBaseUrl/onboarding/teacher/availablity";


  static String get teacherOnboardingPricingUrl =>
      "$_httpBaseUrl/onboarding/teacher/pricing";
}
