class ClientProfile{

  String name;
  int age;
  String status;
  String occupation;
  String district;
  String imageUrl;
  String matchPercentage;

  ClientProfile(
      {
        required this.name,
        required this.age,
        required this.status,
        required this.occupation,
        required this.district,
        required this.imageUrl,
        required this.matchPercentage
      }
      );
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