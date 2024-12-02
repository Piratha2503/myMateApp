class ClientData {
  PersonalDetails personalDetails;
  ContactInfo contactInfo;
  Images profileImages;
  Career_studies career_studies;
  Lifestyle lifestyle;
  User_type user_type;
  Astrology astrology;
  Matchings? matchings;
  String? tokens;

  ClientData({
    this.matchings,
    this.tokens,
    required this.personalDetails,
    required this.contactInfo,
    required this.profileImages,
    required this.career_studies,
    required this.lifestyle,
    required this.user_type,
    required this.astrology,
  });

  Map<String, dynamic> toMap() {
    return {
      'personalDetails': personalDetails.toMap(),
      'contactInfo': contactInfo.toMap(),
      'profileImages': profileImages.toMap(),
      'career_studies': career_studies.toMap(),
      'lifestyle': lifestyle.toMap(),
      'user_type': user_type.toMap(),
      'astrology': astrology.toMap(),
    };
  }
}

class PersonalDetails{
  String? full_name;
  String? mother_name;
  String? first_name;
  String? last_name;
  String? gender;
  String? marital_status;
  int? height;
  int? num_of_siblings;
  String? religion;
  String? caste;
  String? language;
  String? bio;

  PersonalDetails({
    this.first_name,
    this.last_name,
    this.full_name,
    this.mother_name,
    this.gender,
    this.marital_status,
    this.height,
    this.num_of_siblings,
    this.religion,
    this.caste,
    this.language,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'full_name': full_name,
      'mother_name':mother_name,
      'gender':gender,
      'marital_status':marital_status,
      'height':height,
      'num_of_siblings':num_of_siblings,
      'religion':religion,
      'caste':caste,
      'language':language,
      'bio':bio,
    };
  }

}

class ContactInfo{
  String mobile;
  String mobile_country_code;
  String email;
  Address address;

  ContactInfo( this.mobile,this.email,this.mobile_country_code,{required this.address});

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'mobile_country_code': mobile_country_code,
      'email': email,
      'address':address.toMap(),
    };
  }
}

class Address{
  String house_number;
  String home;
  String lane;
  String city;
  String country;

  Address(
  this.house_number,
  this.home,
  this.lane,
  this.city,
  this.country,);

  Map<String, dynamic> toMap() {
    return {
      'house_number': house_number,
      'home': home,
      'lane': lane,
      'city': city,
      'country': country,
    };
  }

}

class Images{
  String? profile_pic_url;
  List<String>? gallery_image_urls;
  Images(this.profile_pic_url,this.gallery_image_urls);

  Map<String, dynamic> toMap() {
    return {
      'profile_pic_url': profile_pic_url,
      'gallery_image_urls': gallery_image_urls,
    };
  }
}

class Career_studies{
  String occupation;
  String occupation_type;
  String annual_salary;
  String higher_studies;

  Career_studies(this.occupation,this.occupation_type,this.annual_salary,this.higher_studies,);

  Map<String, dynamic> toMap() {
    return {
      'occupation': occupation,
      'occupation_type': occupation_type,
      'annual_salary': annual_salary,
      'higher_studies': higher_studies,
    };
  }

}

class Lifestyle{
  List<String>? hobbies;
  List<String>? personal_interest;
  List<String>? expectations;
  List<String>? habbits;
  Lifestyle(this.hobbies,this.personal_interest,this.expectations,this.habbits);

  Map<String, dynamic> toMap() {
    return {
      'hobbies': hobbies,
      'personal_interest': personal_interest,
      'expectations': expectations,
      'habbits':habbits,
    };
  }

}

class User_type{
  String? user_type;
  String? status;
  User_type(this.user_type,this.status);
  Map<String, dynamic> toMap() {
    return {
      'user_type': user_type,
      'status': status,
    };
  }
}

class Astrology{
  String? rasi;
  String? natchathiram;
  String? dob;
  String? dot;
  String? birth_location;
  ChartGeneration? rasi_chart;
  ChartGeneration? navamsa_chart;

  Astrology({
    this.rasi,
    this.natchathiram,
    this.dob,
    this.dot,
    this.birth_location,
    this.rasi_chart,
    this.navamsa_chart,
  });

  Map<String, dynamic> toMap() {
    return {
      'rasi': rasi,
      'natchathiram': natchathiram,
      'dob': dob,
      'dot':dot,
      'birth_location': birth_location,
      'rasi_chart': rasi_chart?.toMap(),
      'navamsa_chart': navamsa_chart?.toMap(),
    };
  }

}

class ChartGeneration{
  List<String>? place1;
  List<String>? place2;
  List<String>? place3;
  List<String>? place4;
  List<String>? place5;
  List<String>? place6;
  List<String>? place7;
  List<String>? place8;
  List<String>? place9;
  List<String>? place10;
  List<String>? place11;
  List<String>? place12;
  ChartGeneration(
          this.place1,
          this.place2,
          this.place3,
          this.place4,
          this.place5,
          this.place6,
          this.place7,
          this.place8,
          this.place9,
          this.place10,
          this.place11,
          this.place12,
          );
  Map<String, dynamic> toMap() {
    return {
      'place1': place1,
      'place2': place2,
      'place3': place3,
      'place4': place4,
      'place5': place5,
      'place6': place6,
      'place7': place7,
      'place8': place8,
      'place9': place9,
      'place10': place10,
      'place11': place11,
      'place12': place12,
    };
  }

}

class Matchings{
  List<String>? interesr_sent;
  Matchings(this.interesr_sent);
  Map<String, dynamic> toMap() {
    return {
      'interesr_sent': interesr_sent,
    };
  }

}
