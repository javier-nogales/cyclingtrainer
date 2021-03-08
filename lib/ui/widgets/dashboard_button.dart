import 'package:flutter/material.dart';

class DashboardButtonTitle extends StatelessWidget {
  final String text;
  
  DashboardButtonTitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        text, 
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

}

class DashboardButtonSeparator extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      color: Colors.cyan,    
    );
  }

}

class DashboardButton extends StatelessWidget {
  final Widget title;
  final Widget separator;
  final Widget board;
  final Function onPressed;

  DashboardButton({
    @required this.title, 
    @required this.separator, 
    @required this.board, 
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: -60,
                  top: -20,
                  child: Icon(Icons.bluetooth, size: 150, color: Colors.white.withOpacity(0.2),),
                ),
                Column(
                  children: <Widget>[
                    title,
                    separator,
                    board,
                  ],
                ),
              ],
            ),
          ),

          // width: double.infinity,
          // //height: 100,
          // margin: EdgeInsets.all(20),
          // decoration: BoxDecoration(
          //   boxShadow: <BoxShadow>[
          //     BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(4, 6), blurRadius: 10)
          //   ],
          //   borderRadius: BorderRadius.circular(15),
          //   gradient: LinearGradient(
          //     colors: <Color>[
          //       Colors.lightBlue,
          //       Colors.blue,
          //     ]
          //   )
          // ),

        ),
      ),
    );
  }
}