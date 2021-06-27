
import 'booking.dart';
import '../../data/models/booking_model.dart';

class BookingListResponse {
  Exception exception;
  List<Booking> bookings;

  void fromModel(List<BookingModel> list) {
    bookings = List<Booking>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      BookingModel model = listIter.current;
      Booking booking = Booking(
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
      bookings.add(booking);
    }
  }
}

