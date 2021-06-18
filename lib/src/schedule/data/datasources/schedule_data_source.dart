import 'database_provider.dart';
import '../models/schedule_model.dart';

class ScheduleDataSource {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<ScheduleModel>> getSchedules({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null && query != '') {
      if (query.isNotEmpty) {
        result = await db.query(scheduleTABLE,
            columns: columns, where: 'name LIKE ?', whereArgs: ['%$query%']);
      }
    } else {
      result = await db.query(scheduleTABLE, columns: columns);
    }

    List<ScheduleModel> schedules = result.isNotEmpty
        ? result.map((schedules) => ScheduleModel.fromJson(schedules)).toList()
        : [];
    return schedules;
  }

  Future<ScheduleModel> getSchedule({List<String> columns, int id}) async {
    final db = await dbProvider.database;

    var result = await db.query(scheduleTABLE, columns: columns, where: 'id = ?', whereArgs: [id]);

    List<ScheduleModel> schedules = result.isNotEmpty ? result.map((schedule) => ScheduleModel.fromJson(schedule)).toList() : [];
    ScheduleModel schedule = schedules.isNotEmpty ? schedules[0] : null;

    return schedule;
  }

  Future<int> createSchedule(ScheduleModel scheduleModel) async {
    final db = await dbProvider.database;

    var result = await db.insert(scheduleTABLE, scheduleModel.toJson());

    return result;
  }

  Future<int> updateSchedule(ScheduleModel scheduleModel) async {
    final db = await dbProvider.database;

    var result = await db.update(scheduleTABLE, scheduleModel.toJson(),
        where: 'id = ?', whereArgs: [scheduleModel.id]);

    return result;
  }

  Future<int> deleteSchedule(int id) async {
    final db = await dbProvider.database;

    var result = await db.delete(scheduleTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}