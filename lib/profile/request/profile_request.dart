class ProfileRequest {
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String> interests;

  ProfileRequest(
      {required this.name,
      required this.birthday,
      required this.height,
      required this.weight,
      required this.interests});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
  }

  factory ProfileRequest.fromJson(Map<String, dynamic> json) {
    return ProfileRequest(
        name: json['name'],
        birthday: json['birthday'],
        height: json['height'],
        weight: json['weight'],
        interests: json['interests']);
  }
}
