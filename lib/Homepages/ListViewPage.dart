import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ListViewPage extends StatefulWidget{

  const ListViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<StatefulWidget>{


  List<Widget> widgetList = [

    ListViewCards("assets/images/brides/sareepic1.jpg"),
    ListViewCards("assets/images/brides/sareepic2.jpg"),
    ListViewCards("assets/images/brides/sareepic3.jpg"),
    ListViewCards("assets/images/brides/sareepic4.jpg"),
    ListViewCards("assets/images/brides/sareepic4.png"),

  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("APPBAR"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,

          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return widgetList[index];
                      },
                childCount: widgetList.length
                      ),

          )
        ],
      ),

    );

  }

}

Widget GridViewContainer(String imageLink){
  return Card(
    margin: EdgeInsets.all(2),
    shape: Border(

    ),
    child: Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: MyMateThemes.secondaryColor,
          radius: 45,

          child: CircleAvatar(
            backgroundImage: AssetImage(imageLink),
            radius: 38,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
            "Name",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        Center(
          child: Padding(padding: EdgeInsets.only(
            left: 30,
            right: 10,
          ),
            child: Text(
              "No-90, Karuveppulam road, Kokkuvil east, Jaffna",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget SearchBarContainer(){
  return SearchBar(
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    )),
  );
}

Widget ListViewCards(String imageLink){
  return Card(
    elevation: 50,
    margin: EdgeInsets.symmetric(horizontal: 20),
    shadowColor: Colors.white12,
    color: Colors.white,

    child: SizedBox(
      height: 250,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.yellow[800],
              radius: 60,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    imageLink),
                //NetworkImage
                radius: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Scroll to start',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Animated list demo',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

/*
GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0, // Spacing between columns
          mainAxisSpacing: 20.0, // Spacing between rows
          childAspectRatio: 0.65,
        ),
        children: widgetList,
      ),
AnimatedListView(
              extendedSpaceBetween: 30,
              spaceBetween:10,
              children: widgetList

          ),
*/