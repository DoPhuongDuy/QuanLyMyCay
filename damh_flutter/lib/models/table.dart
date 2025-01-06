// class Table {
//   final int id;
//   final String name;
//   final int capacity;
//   bool isOccupied;
//
//   Table({
//     required this.id,
//     required this.name,
//     required this.capacity,
//     this.isOccupied = false,
//   });
//
//   factory Table.fromJson(Map<String, dynamic> json) {
//     return Table(
//       id: json['id'],
//       name: json['name'],
//       capacity: json['capacity'],
//       isOccupied: json['isOccupied'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'capacity': capacity,
//       'isOccupied': isOccupied,
//     };
//   }
// }
