class AppUrl {
  static var baseUrl = 'http://127.0.0.1:8000/api';
  static var login = '$baseUrl/login';
  static var register = '$baseUrl/register';
  static var update = '$baseUrl/user/update';
  static var getRoom = '$baseUrl/rooms';
  static var updateProfile = '$baseUrl/profile';
  static var sendEmailForgetpw = '$baseUrl/password/email';
  static var resetPassword = '$baseUrl/password/reset';
  static var checkcode = '$baseUrl/password/code/check';
  static var getRoomUnder100 = '$baseUrl/find-room/filter';
  static var searchroom = '$baseUrl/find-room/name';
  static var BookingOrder = '$baseUrl/charge';
  static var getBookingOrder = '$baseUrl/booking';
  static var userHelp = '$baseUrl/user_query';
}
