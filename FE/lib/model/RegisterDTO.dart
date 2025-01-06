class RegisterDTO {
  String name;
  String password;
  String retypePassword;
  String roleId;

  RegisterDTO({
    required this.name,
    required this.password,
    required this.retypePassword,
    required this.roleId,
  });

  // Phương thức để chuyển từ Map thành đối tượng Register
  factory RegisterDTO.fromJson(Map<String, dynamic> json) {
    return RegisterDTO(
      name: json['name'],
      password: json['password'],
      retypePassword: json['retype_password'],
      roleId: json['roleId'],
    );
  }

  // Phương thức để chuyển đối tượng Register thành Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'retype_password': retypePassword,
      'roleId': roleId,
    };
  }
}
