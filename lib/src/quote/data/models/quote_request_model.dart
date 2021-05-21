class QuoteRequestModel {
  int id;
  String message;
  int traderId;
  int clientId;
  int jobId;
  String createdAt;
  String updatedAt;

  QuoteRequestModel(
      {this.id,
        this.message,
        this.traderId,
        this.clientId,
        this.jobId,
        this.createdAt,
        this.updatedAt});

  QuoteRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    traderId = json['trader_id'];
    clientId = json['client_id'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['trader_id'] = this.traderId;
    data['client_id'] = this.clientId;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
