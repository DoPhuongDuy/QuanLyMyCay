class SpiceLevel {
  final int id;
  final String levelName;

  SpiceLevel({
    required this.id,
    required this.levelName,
  });

  // Chuyển đổi từ JSON thành đối tượng SpiceLevel
  factory SpiceLevel.fromJson(Map<String, dynamic> json) {
    return SpiceLevel(
      id: json['id'],
      levelName: json['levelName'],
    );
  }

  // Chuyển đổi từ đối tượng SpiceLevel thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'levelName': levelName,
    };
  }

  @override
  String toString() {
    return 'SpiceLevel(id: $id, levelName: $levelName)';
  }
}
