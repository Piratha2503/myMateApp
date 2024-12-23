// import 'package:mymateapp/dbConnection/ClientDatabase.dart';
//
// class GenerateClient{
//   static ClientData generateClient(){
//     PersonalDetails personalDetails = PersonalDetails(
//       first_name: "John",
//       last_name: "Doe",
//       full_name: "John Michael Doe",
//       mother_name: "Jane Doe",
//       gender: "Male",
//       marital_status: "Single",
//       height: 180,
//       num_of_siblings: 2,
//       religion: "Christianity",
//       caste: "Catholic",
//       language: "English",
//       bio: "Adventurous and career-oriented individual seeking like-minded partners.",
//     );
//
//     Address address = Address(
//       "123",
//       "Apartment 5B",
//       "Main Street",
//       "New York",
//       "USA",
//     );
//
//     ContactInfo contactInfo = ContactInfo(
//       "1234567890",
//       "john.doe@example.com",
//       "+1",
//       address: address,
//     );
//
//     Images profileImages = Images(
//       "https://example.com/profile_pic.jpg",
//       [
//         "https://example.com/gallery1.jpg",
//         "https://example.com/gallery2.jpg",
//         "https://example.com/gallery3.jpg",
//       ],
//     );
//
//     Career_studies careerStudies = Career_studies(
//       "Software Engineer",
//       "IT Professional",
//       "120,000 USD/year",
//       "M.Sc. in Computer Science",
//     );
//
//     Lifestyle lifestyle = Lifestyle(
//       ["Reading", "Traveling", "Photography"],
//       ["Tech Innovations", "Adventure Sports"],
//       ["Kind, Ambitious, Educated"],
//       ["Non-smoker", "Occasional drinker"],
//     );
//
//     User_type userType = User_type(
//       "Premium",
//       "Active",
//     );
//
//     ChartGeneration rasiChart = ChartGeneration(
//       ["Mars"],
//       ["Venus"],
//       ["Moon"],
//       ["Jupiter"],
//       ["Mercury"],
//       [],
//       [],
//       ["Saturn"],
//       [],
//       [],
//       ["Rahu"],
//       ["Ketu"],
//     );
//
//     ChartGeneration navamsaChart = ChartGeneration(
//       ["Sun"],
//       ["Venus"],
//       ["Mars"],
//       ["Saturn"],
//       ["Mercury"],
//       ["Jupiter"],
//       [],
//       ["Moon"],
//       [],
//       ["Rahu"],
//       ["Ketu"],
//       [],
//     );
//
//     Astrology astrology = Astrology(
//       rasi: "Aries",
//       natchathiram: "Ashwini",
//       dob: "1990-01-01",
//       dot: "08:30 AM",
//       birth_location: "New York, USA",
//       rasi_chart: rasiChart,
//       navamsa_chart: navamsaChart,
//     );
//
//     Matchings matchings = Matchings(
//       ["InterestID1", "InterestID2", "InterestID3"],
//     );
//
//     ClientData clientData = ClientData(
//       matchings: matchings,
//       tokens: "some_unique_token_12345",
//       personalDetails: personalDetails,
//       contactInfo: contactInfo,
//       profileImages: profileImages,
//       career_studies: careerStudies,
//       lifestyle: lifestyle,
//       user_type: userType,
//       astrology: astrology,
//     );
//
//     return clientData;
//   }
// }