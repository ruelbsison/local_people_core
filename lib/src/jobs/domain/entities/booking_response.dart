
import 'booking.dart';
import '../../data/models/booking_model.dart';

class BookingResponse {
  Exception exception;
  Booking booking;

  void fromModel(BookingModel model) {
    booking = Booking(
      id : model.id ,
      date : model.date ,
      details : model.details ,
      status : model.status ,
      traderId : model.traderId ,
      jobId : model.jobId ,
      createdAt : model.createdAt ,
      updatedAt: model.updatedAt ,
    );
  }

  static BookingModel fromBooking(Booking booking) {
    return BookingModel (
      id : booking.id ,
      date : booking.date ,
      details : booking.details ,
      status : booking.status ,
      traderId : booking.traderId ,
      jobId : booking.jobId ,
      createdAt : booking.createdAt ,
      updatedAt: booking.updatedAt ,
    );
  }
}