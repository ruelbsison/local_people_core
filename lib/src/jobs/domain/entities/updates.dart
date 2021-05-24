class Updates {
  int id;
  String details;
  String status;
  int delayedBy;
  int jobId;
  String createdAt;
  String updatedAt;

  Updates(
      {this.id,
      this.details,
      this.status,
      this.delayedBy,
      this.jobId,
      this.createdAt,
      this.updatedAt});

  Updates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    status = json['status'];
    delayedBy = json['delayed_by'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['status'] = this.status;
    data['delayed_by'] = this.delayedBy;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
