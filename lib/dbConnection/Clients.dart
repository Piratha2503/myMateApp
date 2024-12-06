class ClientProfile{
  String docId;
  String name;
  String full_name;
  int age;
  String gender;
  String status;
  String occupation;
  String district;
  String imageUrl;
  String matchPercentage;

  ClientProfile(
      {
        required this.docId,
        required this.full_name,
        required this.name,
        required this.gender,
        required this.age,
        required this.status,
        required this.occupation,
        required this.district,
        required this.imageUrl,
        required this.matchPercentage
      });
}

class TestClient{
late final String name;
late final int age;
late final String status;
late final String occupation;
late final String district;
late final String imageUrl;
late final String matchPercentage;
}