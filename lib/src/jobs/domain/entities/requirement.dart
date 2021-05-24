class Requirement {
  int id;
  String title;
  String description;
  int packageId;
  String createdAt;
  String updatedAt;

  Requirement(
      {this.id,
      this.title,
      this.description,
      this.packageId,
      this.createdAt,
      this.updatedAt});

  Requirement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    packageId = json['package_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['package_id'] = this.packageId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
