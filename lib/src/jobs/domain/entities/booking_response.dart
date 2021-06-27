
import 'booking.dart';
import '../../data/models/booking_model.dart';

class BookingResponse {
  Exception exception;
  Booking booking;

  void fromModel(BookingModel model) {
    booking = Booking(
      id : model.id ,
      startTime : DateTime.parse(model.start_time),
      endTime : DateTime.parse(model.end_time),
      details : model.details ,
      status : model.status ,
      traderId : model.trader_id ,
      jobId : model.job_id ,
      createdAt : model.created_at ,
      updatedAt: model.updated_at ,
    );
  }

  static BookingModel fromBooking(Booking booking) {
    return BookingModel (
      id : booking.id ,
      start_time : booking.startTime.toString() ,
      end_time : booking.endTime.toString() ,
      details : booking.details ,
      status : booking.status ,
      trader_id : booking.traderId ,
      job_id : booking.jobId ,
      created_at : booking.createdAt ,
      updated_at: booking.updatedAt ,
    );
  }
}