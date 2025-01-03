import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../MyMateThemes.dart';
import '../../dbConnection/Clients.dart';
import '../BadgeWidget.dart';
import '../SubscribedHomeScreen.dart';
import 'explorePageMain.dart';
import 'package:mymateapp/dbConnection/Firebase.dart';


Firebase firebase = Firebase();

PreferredSizeWidget ExplorePageAppBar() {
  // int badgeValue1 = 2;
  // int badgeValue2 = 10;
  return
    AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[

        SvgPicture.asset('assets/images/filter1.svg'),
        SizedBox(width: 35),

      ],
    );
}

// Define the reusable widget to build grid items
Widget buildGridItem(Profile profile) {
  return Container(
    height: 272,
    width: 152,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(3.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4.0,
          spreadRadius: 2.0,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    margin: const EdgeInsets.all(12.0),
    child: Stack(
      children: [
        // Profile image
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            image: DecorationImage(

              image: AssetImage(profile.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Content container
        Positioned(
          top: 145.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: 129,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(3.0),
                bottomRight: Radius.circular(3.0),
              ),
            ),
            child:
            Center(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      profile.name,
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  // Age and status
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${profile.age}, ',
                          style: const TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,

                            fontSize: 11,
                          ),
                        ),
                        Text(
                          profile.status,
                          style: const TextStyle(
                            color: MyMateThemes.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Occupation
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      profile.occupation,
                      style: const TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  // District
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      profile.district,
                      style: const TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),

                  // Match percentage
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child:
                    Container(
                      width: 108.43,
                      height: 20.85,
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/images/heart .svg'),
                          Text(
                            profile.matchPercentage,
                            style: const TextStyle(
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ),
        ),
        // Optional: Circle icon
        Positioned(
          top: 8.0,
          right: 8.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.circle, size: 20, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

// Reusable grid widgets
Widget ExploreAllGrid(BuildContext context) {
  return Expanded(
    child:
    StreamBuilder<List<ClientProfile>>(
      stream: firebase.getClientsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No profiles found.'));
        }

        // Map ClientProfile to Profile
        final profiles = snapshot.data!
            .map((client) => Profile(
          name: client.name,
          imageUrl: client.imageUrl, // Adjust as needed
          age: client.age,
          status: client.status,
          occupation: client.occupation,
          district: client.district,
          matchPercentage: client.matchPercentage,
        ))
            .toList();

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          childAspectRatio: 160 / 240,
          children: profiles.map((profile) => buildGridItem(profile)).toList(),
        );
      },
    ),
  );
}


Widget ViewMatchesGrid(BuildContext context) {

  return Expanded(
    child: StreamBuilder<List<ClientProfile>>(
      stream: firebase.getClientsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No profiles found.'));
        }

        // Map ClientProfile to Profile
        final profiles = snapshot.data!
            .map((client) => Profile(
          name: client.name,
          imageUrl: client.imageUrl, // Adjust as needed
          age: client.age,
          status: client.status,
          occupation: client.occupation,
          district: client.district,
          matchPercentage: client.matchPercentage,
        ))
            .toList();

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          childAspectRatio: 160 / 240,
          children: profiles.map((profile) => buildGridItem(profile)).toList(),
        );
      },
    ),
  );

}

Widget FilterGrid(BuildContext context) {
  return Expanded(
    child: StreamBuilder<List<ClientProfile>>(
      stream: firebase.getClientsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No profiles found.'));
        }

        // Map ClientProfile to Profile
        final profiles = snapshot.data!
            .map((client) => Profile(
          name: client.name,
          imageUrl: client.imageUrl, // Adjust as needed
          age: client.age,
          status: client.status,
          occupation: client.occupation,
          district: client.district,
          matchPercentage: client.matchPercentage,
        ))
            .toList();

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          childAspectRatio: 160 / 240,
          children: profiles.map((profile) => buildGridItem(profile)).toList(),
        );
      },
    ),
  );
}


final search = TextField(

  autofocus: false,
  style: const TextStyle(fontSize: 14.0, color: MyMateThemes.textColor),
  decoration: InputDecoration(
    filled: true,
    prefixIcon: const Icon(Icons.search),
    fillColor: MyMateThemes.containerColor,
    hintText: 'Search.',
    contentPadding: const EdgeInsets.all(12),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(59),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(59),
      borderSide: const BorderSide(color: Colors.white),
    ),
  ),
);