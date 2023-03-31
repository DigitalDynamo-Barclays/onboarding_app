class AadhaarData {
  String? uid;
  String? name;
  String? gender;
  String? house;
  String? street;
  String? city;
  String? area;
  String? state;
  String? zip;
  String? dob;

  AadhaarData({
    this.uid,
    this.name,
    this.gender,
    this.house,
    this.state,
    this.street,
    this.city,
    this.area,
    this.zip,
    this.dob,
  });
  AadhaarData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    gender = json['gender'];
    house = json['house'];
    state = json['state'];
    city = json['city'];
    street = json['street'];
    area = json['area'];
    zip = json['zip'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['house'] = this.house;
    data['state'] = this.state;
    data['city'] = this.city;
    data['street'] = this.street;
    data['area'] = this.area;
    data['zip'] = this.zip;
    data['dob'] = this.dob;

    return data;
  }
}
