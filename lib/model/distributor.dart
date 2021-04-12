class Distributor {
  int id;
  String name;
  String email;
  String contact;
  String location;
  String latitude;
  String longitude;

  Distributor(
      {this.id,
      this.name,
      this.email,
      this.contact,
      this.location,
      this.latitude,
      this.longitude});

  Distributor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
