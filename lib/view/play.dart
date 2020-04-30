import 'dart:ffi';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);

  final String title;
  final direction = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool tour = true; // Premier joueur est O
  List<String> afficherGrille = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  int scoreO = 0;
  int scoreX = 0;
  int casesRemplies = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[Text('Joueur X'), Text('Joueur O')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[Text('$scoreX'), Text('$scoreO')],
          ),
          Container(
            padding: EdgeInsets.all(30),
            color: Colors.grey[200],
            height: 500,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (BuildContext c, int i) {
                return GestureDetector(
                  onTap: () => _remplirCase(i),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red[400], width: 2)),
                    alignment: Alignment.center,
                    child: Text(
                      afficherGrille[i],
                      style: TextStyle(color: Colors.red, fontSize: 50),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _remplirCase(int i) {
    setState(() {
      if (afficherGrille[i].isEmpty) afficherGrille[i] = tour ? 'O' : 'X';
      tour = !tour;
      casesRemplies += 1;
      _verifierGagnant();
    });
  }

  void _verifierGagnant() {
    bool check = true;
    for (var liste in widget.direction) {
      if (_verifierDirection(liste)) {
        _finJeu(liste);
        check = false; // In case of the game end up with 9 filled boxes
      }
    }

    if (casesRemplies == 9 && check) _finJeu();
  }

  bool _verifierDirection(var l) {
    return (afficherGrille[l[0]] == afficherGrille[l[1]] &&
        afficherGrille[l[1]] == afficherGrille[l[2]] &&
        afficherGrille[l[0]].isNotEmpty);
  }

  void _finJeu([var l = '']) {
    if (l == '') {
      _matchNul();
    } else {
      var nomGagnant = afficherGrille[l[0]];
      for (var a in l) {
        afficherGrille[a] = '*${afficherGrille[a]}*';
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: Text('Le gagnant est : $nomGagnant'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Rejouer'),
                  onPressed: () {
                    if (nomGagnant == 'O') scoreO += 1;
                    if (nomGagnant == 'X') scoreX += 1;
                    _remiseZero();
                    Navigator.of(bc).pop();
                  },
                )
              ],
            );
          });
    }
  }

  void _remiseZero() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        afficherGrille[i] = '';
      }
    });

    casesRemplies = 0;
  }

  void _matchNul() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: Text('Match nul'),
            actions: <Widget>[
              FlatButton(
                child: Text('Rejouer'),
                onPressed: () {
                  _remiseZero();
                  Navigator.of(bc).pop();
                },
              )
            ],
          );
        });
  }
}
