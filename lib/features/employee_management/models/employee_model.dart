class Employee {
  int id;
  String tfsName;
  String fullName;
  String email;
  String phone;
  //String avatar;
  //DateTime birthDate;
  //DateTime startDate;
  String nickName;
  String role;
  bool isLeader;
  bool isLunch;
  // int wfhQuota;
  // int absenceQuota;
  bool isActive;

  Employee({
    required this.id,
    required this.tfsName,
    required this.fullName,
    required this.email,
    required this.phone,
    // required this.avatar,
    // required this.birthDate,
    // required this.startDate,
    required this.nickName,
    required this.role,
    required this.isLeader,
    required this.isLunch,
    // required this.wfhQuota,
    // required this.absenceQuota,
    required this.isActive,
  });

  // Tạo phương thức fromJson để parse dữ liệu JSON thành model
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      tfsName: json['tfsName'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      // avatar: json['avatar'],
      // birthDate: DateTime.parse(json['birthDate']),
      // startDate: DateTime.parse(json['startDate']),
      nickName: json['nickName'] ?? "",
      role: json['role'] ?? "1",
      isLeader: json['isLeader'] ?? false,
      isLunch: json['isLunch'] ?? false,
      // wfhQuota: json['wfhQuota'],
      // absenceQuota: json['absenceQuota'],
      isActive: json['isActive'] ?? true,
    );
  }

  // Tạo phương thức toJson để chuyển đổi model thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tfsName': tfsName,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'avatar': "",
      'birthDate': "1987-10-09T00:00:00+07:00",
      'startDate': "2007-10-07T00:00:00+07:00",
      'nickName': nickName,
      'role': role,
      'isLeader': isLeader,
      'isLunch': isLunch,
      'wfhQuota': 30,
      'absenceQuota': 17,
      'isActive': isActive,
    };
  }
}
