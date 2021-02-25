import 'package:equatable/equatable.dart';

List<Employee> employeesFromJson(List employee) =>
    List<Employee>.from(employee.map((x) => Employee.fromJson(x)));

class Employee extends Equatable {
  int id;
  String name;
  String email;
  String phoneNumber;
  String gender;
  String address;
  String photo;
  String position;

  Employee({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.photo,
    this.position,
  });
  @override
  List<Object> get props => [
        id,
        name,
        email,
        phoneNumber,
        gender,
        address,
        photo,
        position,
      ];

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    address = json['address'];
    photo = json['photo'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }

    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['photo'] = this.photo;
    data['position'] = this.position;

    return data;
  }
}
