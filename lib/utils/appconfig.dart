    // config.dart

    const String baseUrl = 'https://api.tutorschool.in/auth/teacher';
    const String onBoardingUrl = 'https://api.tutorschool.in/onboarding/teacher';

    class ApiEndpoints {
      static const String start = '$baseUrl/start';
      static const String verify = '$baseUrl/verify';
      static const String login  ='$baseUrl/login';
      static const String create ='$baseUrl/create';
      static const String location = '$onBoardingUrl/location';
      static const String basic = '$onBoardingUrl/basic';
    }
