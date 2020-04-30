import 'package:flutter/material.dart';
import 'play.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "MORPION",
              style: TextStyle(fontSize: 55.0, color: Colors.red[900]),
            ),
            Image.asset(
              'assets/images/home.png',
              fit: BoxFit.cover,
              height: 200.0,
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Game(title: 'Let\'s play'),
                  ),
                );
              },
              padding: EdgeInsets.all(20),
              icon: Icon(
                Icons.play_circle_filled,
                size: 35.0,
              ),
              label: Text(
                'Jouer',
                style: TextStyle(fontSize: 40.0),
              ),
              textColor: Colors.red[900],
              color: Colors.red[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
