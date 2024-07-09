class StudentModel {
  int? id;
  late String name;
  late int age;
  late String department;
  late String place;
  late int phoneNumber;
  late String guardianName;
  late String imageUrl;

  StudentModel(
      {this.id,
      required this.name,
      required this.age,
      required this.department,
      required this.place,
      required this.phoneNumber,
      required this.guardianName,
      required this.imageUrl});

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
        id: map['id'],
        name: map['name'],
        age: map['age'],
        department: map['department'],
        place: map['place'],
        phoneNumber: map['phoneNumber'],
        guardianName: map['guardianName'],
        imageUrl: map['imageUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'department': department,
      'place': place,
      'phoneNumber': phoneNumber,
      'guardianName': guardianName,
      'imageUrl': imageUrl,
    };
  }
}
