
class Client {
  String? docId;
  String? maritalStatus;
  String? occupationType;
  int? age;
  String? profileImg;
  String? fullName;
  String? lastName;
  String? city;
  String? matchingPercentage;

  Client({
    this.docId,
    this.maritalStatus,
    this.occupationType,
    this.age,
    this.profileImg,
    this.fullName,
    this.lastName,
    this.city,
    this.matchingPercentage,
  });

  // Factory method to create a ClientData object from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      docId: json['docId'],
      maritalStatus: json['marital_status'],
      occupationType: json['occupation_type'],
      age: json['age'],
      fullName: json['full_name'],
      lastName: json['last_name'],
      city: json['city'],
      matchingPercentage: json['matching_percentage'],
    );
  }
}
