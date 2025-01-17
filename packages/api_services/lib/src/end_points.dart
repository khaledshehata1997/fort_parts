class EndPoints {
  static String baseUrl = 'https://api.developertest.online/api';

  // Authentication
  static String register() => '$baseUrl/register';
  static String login() => '$baseUrl/login';

  // Doctors
  static String doctors() => '$baseUrl/doctors';

  // Branches
  static String branches() => '$baseUrl/branches';

  // Specializations
  static String specializations() => '$baseUrl/specializations';

  // Appointments
  static String appointments() => '$baseUrl/appointment';
}
