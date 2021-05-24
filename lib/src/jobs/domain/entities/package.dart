class Package {
  int id;
  String name;
  String description;
  int traderId;
  String createdAt;
  String updatedAt;

  Package(
      {this.id,
      this.name,
      this.description,
      this.traderId,
      this.createdAt,
      this.updatedAt});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    traderId = json['trader_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['trader_id'] = this.traderId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
