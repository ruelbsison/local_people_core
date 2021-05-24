
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
          date : model.date ,
          details : model.details ,
          status : model.status ,
          traderId : model.traderId ,
          jobId : model.jobId ,
          createdAt : model.createdAt ,
          updatedAt: model.updatedAt ,
      );
      bookings.add(booking);
    }
  }
}

