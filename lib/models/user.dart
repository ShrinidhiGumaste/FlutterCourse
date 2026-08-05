class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int age;
  final String profileImage;
  final String city;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.profileImage,
    required this.city,
  });
  // Factory() Method
  factory User.fromJson(Map<String, dynamic>json){
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      age: json['age'],
      profileImage: json['profile_image'],
      city: json['city'],
    );
  }

}