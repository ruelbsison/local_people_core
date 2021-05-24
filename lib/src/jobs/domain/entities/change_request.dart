class ChangeRequest {
  int id;
  String date;
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
      : assert(date != null),
        assert(duration != null),
        assert(status != null),
        assert(traderId != null),
        assert(jobId != null);

}
