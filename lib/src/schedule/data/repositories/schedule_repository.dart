import '../datasources/schedule_data_source.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final scheduleDataSource = ScheduleDataSource();

  Future getSchedules({String query}) => scheduleDataSource.getSchedules(query: query);

  Future getSchedule(int id) => scheduleDataSource.getSchedule(id: id);

  Future createSchedule(ScheduleModel schedule) => scheduleDataSource.createSchedule(schedule);

  Future updateSchedule(ScheduleModel schedule) => scheduleDataSource.updateSchedule(schedule);

  Future deleteSchedule(int id) => scheduleDataSource.deleteSchedule(id);
}