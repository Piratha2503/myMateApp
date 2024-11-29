
import 'package:flutter/material.dart';

class Test3 extends StatefulWidget{
  const Test3({super.key
  });

  @override
  State<Test3> createState()=> _Test3State();
}

class _Test3State extends State<Test3>{

  @override
  Widget build(BuildContext BuildContext){
    return Scaffold(
      appBar: AppBar(),
        body: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 75,
              foregroundDecoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: 2)
                )
              ),
            ),
            SizedBox(
              height: 50,
              width: 75,
            ),
            Container(
              height: 50,
              width: 75,
              foregroundDecoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 2)
                  )
              ),
            ),
          ],
        ),
    );
  }

}

