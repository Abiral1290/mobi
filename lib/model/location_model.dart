class LocationModel {
  String id;
  double latitude;
  double longitude;
  String time;

  LocationModel({
    this.id,
    this.latitude,
    this.longitude,
    this.time,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['time'] = this.time;
    return data;
  }
}
