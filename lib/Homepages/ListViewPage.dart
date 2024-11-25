import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateBottomBar.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Clients.dart';
import 'package:mymateapp/dbConnection/Firebase.dart';
import 'SubscribedhomeScreen/SubscribedHomeScreenWidgets.dart';

class ListViewPage extends StatefulWidget{
  final int selectedBottomBarIconIndex;
  const ListViewPage(this.selectedBottomBarIconIndex, {super.key});

  @override
  State<StatefulWidget> createState() => _ListViewPageState(this.selectedBottomBarIconIndex);
}

class _ListViewPageState extends State<StatefulWidget>{
  final int selectedBottomBarIconIndex;
  List<Widget> widgetList = [];
  Firebase firebase = Firebase();

  String searchText = '';

  _ListViewPageState(this.selectedBottomBarIconIndex);

  void filterList(String query, List<ClientProfile> allClients) {
    setState(() {
      searchText = query;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    String searchText = '';
    final TextEditingController _controller =
    TextEditingController(text: 'Initial Text');

    return Scaffold(
      appBar: MainAppBar(),
      body: Column(
        children: [
          SizedBox(width: 350,
            height: 50,
            child: AnimatedSearchBar(
              label: 'Search Something Here',
              controller: _controller,
              labelStyle: TextStyle(fontSize: 16),
              searchStyle: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              searchDecoration: InputDecoration(
                hintText: 'Search',
                alignLabelWithHint: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                debugPrint('value on Change');
              },
              onFieldSubmitted: (value) {
                debugPrint('value on Field Submitted');

              }
          ),),
          SizedBox(height: 20,),
          Expanded(
            child:StreamBuilder<List<ClientProfile>>(
              stream: firebase.getClientsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No clients found.'));
                }

                final clients = snapshot.data!;
                final filteredClients = clients
                    .where((client) => client.name.toLowerCase().contains(searchText.toLowerCase()))
                    .toList();

                return ListView(
                  children: filteredClients.map((client) {
                    return ListViewCards(client);
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: this.selectedBottomBarIconIndex,
        onItemTapped: (int ) { print(int); },),

    );

  }

}

PreferredSizeWidget MainAppBar(){

  return AppBar(
    actions: <Widget>[
      SizedBox(width: 200,child: SearchBar(
        enabled: false,
      ),),
      AppbarIconButton(Icons.search),
      AppbarIconButton(Icons.mail),
      AppbarIconButton(Icons.heart_broken),
      SizedBox(width: 12,)
    ],
  );
}

Widget AppbarIconButton(IconData iconData){
  return IconButton(
      onPressed: (){
        Firebase().addClient();
      },
      icon: Icon(iconData),
    color: MyMateThemes.primaryColor,
    style: ButtonStyle(
      iconSize: MaterialStatePropertyAll(30),
    ),
  );
}

Widget SearchBarContainer(){
  return SearchBar(
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    ),
    leading: Row(
      children: <Widget>[
        SizedBox(width: 15,),
        Icon(Icons.search,size: 40,),
      ],
    ),
    hintText: "Search",
    hintStyle: MaterialStatePropertyAll(TextStyle(
      fontSize: 20,
    ),
    ),
  side: MaterialStatePropertyAll(
      BorderSide(
    style: BorderStyle.none,
  )),
    shadowColor: MaterialStateColor.transparent,
  );
}

Widget ListViewCards(ClientProfile profile){
  return Container(
    height: 125,
    margin: EdgeInsets.symmetric(horizontal: 1.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(width: 3,color: MyMateThemes.secondaryColor),
          left: BorderSide(width: 2,color: MyMateThemes.secondaryColor))

    ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Row(
           children: [
             SizedBox(height:50, width: 20),
             ProfilePictureContainer(profile),
             SizedBox(width: 20),
             ProfileInfoColumn(profile),
           ],
         )

        ]
    ),
  );
}

Widget ProfilePictureContainer(ClientProfile profile){
  return Container(
    height: 80,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: MyMateThemes.secondaryColor, // Set the border color
        width: 3, // Set the border width
      ),
    ),
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(profile.imageUrl),

    ),
  );
}

Widget ProfileInfoColumn(ClientProfile profile){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only( bottom: 4.0 ),
        child: CommonTextStyleForPage( profile.name, MyMateThemes.textColor, FontWeight.w500, 16,),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 4.0), // Add bottom padding for spacing
        child: Row(
          children: [
            CommonTextStyleForPage(' ${profile.age}, ', MyMateThemes.textColor, FontWeight.w400,12, ),
            CommonTextStyleForPage(' ${profile.occupation}',MyMateThemes.textColor,FontWeight.w400,12,),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only( bottom: 4.0), // Add bottom padding for spacing
        child: CommonTextStyleForPage(' ${profile.district}',MyMateThemes.textColor,FontWeight.w400,12,),
      ),
      Container(
        width: 75,
        height: 25,
        decoration: BoxDecoration(
          color: MyMateThemes.secondaryColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
                'assets/images/heart .svg'),
            CommonTextStyleForPage(' ${profile.matchPercentage}',MyMateThemes.primaryColor,FontWeight.w400,14),
          ],
        ),
      ),
    ],
  );
}
