class Login {
  final String name;
  final String password;

  Login({
    required this.name,
    required this.password,
  });

  // Phương thức chuyển LoginDTO thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
    };
  }

  // Phương thức từ JSON chuyển thành LoginDTO
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      name: json['name'],
      password: json['password'],
    );
  }
}
