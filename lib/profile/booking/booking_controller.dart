import '../../login/services/session.dart';
import 'booked_model.dart';
import 'booked_service.dart';

class BookingController {

  List<BookingModel> bookings = [];

  Future<List<BookingModel>> getBookings() async {
    try {
      String? token = await Session.getToken();

      print("CONTROLLER TOKEN: $token");

      if (token == null) return [];

      final data = await BookingService.fetchBookings(token);

      bookings = data.map((e) => BookingModel.fromJson(e)).toList();

      print("BOOKINGS LENGTH: ${bookings.length}");

      return bookings;

    } catch (e) {
      print("ERROR IN CONTROLLER: $e");
      return [];
    }
  }
}