class ChangeRequest {
  int id;
  DateTime date;
  int duration;
  String status;
  int traderId;
  int jobId;
  String createdAt;
  String updatedAt;
  int clinetId;

  ChangeRequest(
      {this.id,
      this.date,
      this.duration,
      this.status,
      this.traderId,
      this.jobId,
        this.clinetId,
      this.createdAt,
      this.updatedAt})
      : assert(jobId != null),
        assert(clinetId != null);

}
