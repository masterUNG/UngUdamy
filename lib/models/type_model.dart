class TypeModel {
  String name;
  String type;
  String pathImage;
  String education;
  String address;
  String phone;
  String website;

  TypeModel(
      {this.name,
      this.type,
      this.pathImage,
      this.education,
      this.address,
      this.phone,
      this.website});

  TypeModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    type = json['Type'];
    pathImage = json['PathImage'];
    education = json['Education'];
    address = json['Address'];
    phone = json['Phone'];
    website = json['Website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Type'] = this.type;
    data['PathImage'] = this.pathImage;
    data['Education'] = this.education;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['Website'] = this.website;
    return data;
  }
}
