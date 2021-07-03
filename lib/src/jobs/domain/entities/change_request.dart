class ChangeRequest {
  int id;
  DateTime date;
  int duration;
  String status;
  int traderId;
  int jobId;
  String createdAt;
  String updatedAt;

  ChangeRequest(
      {this.id,
      this.date,
      this.duration,
      this.status,
      this.traderId,
      this.jobId,
      this.createdAt,
      this.updatedAt})
      : assert(traderId != null),
        assert(jobId != null);

}
