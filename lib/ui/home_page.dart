import 'package:flutter/material.dart';
import 'package:trainerapp/ui/test_page.dart';

class HomePage extends StatelessWidget {


  HomePage() {
    print('HOME PAGE CONSTRUCTOR');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.blue,
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TestPage()
              )
          );
        }
      ),
    );
  }

}