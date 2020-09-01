import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  //TODO: Import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");


  //TODO: get an array
  List<String> itemArray;
  int luckyNumber;
  int counter = 0;

  //TODO: initialize array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }
  generateRandomNumber(){
    int random = Random().nextInt(25);
    setState(() {
     luckyNumber = random; 
    });
  }

  void incrementCounter(){
    setState(() {
     counter++; 
    });
  }

  //TODO: Define a get image method
  AssetImage getImage(int index){
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
      
    }
    return circle;
  }

  //TODO: Play game method
  playGame(int index){
    if (luckyNumber == index) {
      setState(() {
       itemArray[index] = "lucky"; 
      });
      
    } else {
      setState(() {
       itemArray[index] = "unlucky";         
      });
    }
    if (counter == 4){
      setState(() {
       showAll(); 
      });
    }
  }

  //TODO: Show all
  showAll(){
    setState(() {
     itemArray = List<String>.filled(25, "unlucky");
     itemArray[luckyNumber] = "lucky";
    });
  }

  //TODO: reset all method
  resetGame(){
    setState(() {
     itemArray = List<String>.filled(25, "empty"); 
     counter = 0;
    });
    generateRandomNumber();
    
  }
  
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("About"),
          content: new Text("Learn Code Online Tutorial App by Rabin Dhakal"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){
                    this.playGame(i);
                    incrementCounter();
                    Tooltip(message: "Increment",);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            
            margin: EdgeInsets.all(10.0),
            
            child: RaisedButton(
              onPressed: (){
                this.showAll();
              },
              color: Colors.pink,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Text('Show All',
               style: TextStyle(
                 fontSize: 20.0 
                 ) , 
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: (){
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(10.0),
              textColor: Colors.white,
              child: Text('Reset',style: TextStyle(
                 fontSize: 20.0 
                 ) , 
                 ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: MaterialButton(
              onPressed: (){
                this._showDialog();
              },
              color: Colors.black,
              child: Text("About",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),

        ],
      ),
    );
  }
}