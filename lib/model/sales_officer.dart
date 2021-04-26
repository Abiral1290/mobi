import 'distributor.dart';

class SalesOfficer {
  int id;
  String name;
  String email;
  int emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String role;
  int adminId;
  int marketingDirectorId;
  int marketingManagerId;
  int salesSupervisorId;
  String apiToken;
  String phone;
  List<Distributor> distributors;

  SalesOfficer(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.adminId,
      this.marketingDirectorId,
      this.marketingManagerId,
      this.salesSupervisorId,
      this.apiToken,
      this.phone,
      this.distributors});

  SalesOfficer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // role = json['role'];
    adminId = json['admin_id'];
    marketingDirectorId = json['marketing_director_id'];
    marketingManagerId = json['marketing_manager_id'];
    salesSupervisorId = json['sales_supervisor_id'];
    apiToken = json['api_token'];
    phone = json['phone'];
    if (json['distributors'] != null) {
      distributors = [];
      json['distributors'].forEach((v) {
        distributors.add(Distributor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['admin_id'] = this.adminId;
    data['marketing_director_id'] = this.marketingDirectorId;
    data['marketing_manager_id'] = this.marketingManagerId;
    data['sales_supervisor_id'] = this.salesSupervisorId;
    data['api_token'] = this.apiToken;
    data['phone'] = this.phone;
    return data;
  }
}
