import 'dart:math';
import 'dart:async' as MyAsync;
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


/* 
Stats Table WIDGET 
It contains the following two components
*/

class StatsTable extends StatefulWidget {
    final String jsonString;
    const StatsTable(this.jsonString);
    StatsTableState createState() => StatsTableState (this.jsonString);
}

class StatsTableState extends State<StatsTable> {
    Map<String, dynamic> data = new Map<String, dynamic>();
    List statsTable = [];
    bool loading = true;
    final String jsonString;
    StatsTableState(this.jsonString){
        data = jsonDecode(this.jsonString);
    }
    
    MyAsync.Timer? timer;

    @override
    void initState() {
        super.initState();
        this.getHttp();
        if(data['started']){
          timer = MyAsync.Timer.periodic(
              const Duration(seconds: 10),
              (timer) {
                  // setState(() {
                      
                  // });
                  this.getHttp();
              },
          );
        }else{
          this.getHttp();
        }
    }

    void getHttp() async {
      try {
        var response = await Dio().get('http://18.143.165.129:5000/api/statistics/'+data['fixtureId']);
        var decoded = jsonDecode(response.toString());
        setState(() {
          statsTable = decoded["stats"];
          loading = false;
        });
      } catch (e) {
        print(e);
      }
  }

    @override
    void dispose() {
        super.dispose();
        timer?.cancel();
    }

    @override
    Widget build(BuildContext context) {
      if(loading){
        return Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 100), 
            color: Colors.grey[850], 
            child: Center( 
              child: new CircularProgressIndicator()
            )
          )
        );
      }else{
        if(data['started'] == true){
          return Table(
            children: List<TableRow>.generate(
                statsTable.length,
                (index) {
                    final statsiItem = statsTable[index];
                    return TableRow(
                      children: [
                        TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text(statsiItem["home"].toString(), style: TextStyle(color: Colors.yellow)))),
                        TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Center( child: Text(statsiItem["key"], style: TextStyle(color: Colors.white))))),
                        TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text(statsiItem["away"].toString(), textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
                      ],
                    );
                },
                growable: false,
            ),
        );
            // return Table(
            //     children: [
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text('0', style: TextStyle(color: Colors.yellow)))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Center( child: Text('Shooting', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text('0', textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Text('0', style: TextStyle(color: Colors.yellow)))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Center( child: Text('Attacks', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Text('0', textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: DynamicText(0, 0))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Center( child: Text('Possession %', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: DynamicText(0, 1))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Text('0', style: TextStyle(color: Colors.yellow)))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Center( child: Text('Red Cards', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Text('0', textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text('0', style: TextStyle(color: Colors.yellow)))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Center( child: Text('Yellow Cards', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text('0', textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Text('0', style: TextStyle(color: Colors.yellow)))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Center( child: Text('Corners', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Text('0', textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text('0', style: TextStyle(color: Colors.yellow)))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Center( child: Text('Offsides', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[900], child: Text('0', textAlign: TextAlign.end, style: TextStyle(color: Colors.red)))),
            //             ],
            //         ),
            //         TableRow(
            //             children: [
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: DynamicText(1, 0))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: Center( child: Text('Passes', style: TextStyle(color: Colors.white))))),
            //                 TableCell(child: Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), color: Colors.grey[850], child: DynamicText(1, 1))),
            //             ],
            //         )
            //     ]
            // );
        }else{
            return Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 100), 
                    color: Colors.grey[850], 
                    child: Center( 
                        child: Text('Match To Start Yet', style: TextStyle(color: Colors.grey, fontSize: 24))
                    )
                )
            );
        }
      }
    }
}

/* 
SUMMARY WIDGET 
It contains the following two components
*/

class GameSummary extends StatefulWidget {
    final String jsonString;
    const GameSummary(this.jsonString);
    GameSummaryState createState() => GameSummaryState (this.jsonString);
}

class GameSummaryState extends State<GameSummary> {
    Map<String, dynamic> data = new Map<String, dynamic>();
    final String jsonString;
    String homeGoals = "0";
    String awayGoals = "0";
    int hour = 0;
    int minute = 0;
    int seconds = 0;
    String timeString = "00:00:00";
    GameSummaryState(this.jsonString){
        data = jsonDecode(this.jsonString);
        homeGoals = data['homeGoals'];
        awayGoals = data['awayGoals'];
    }
    
    MyAsync.Timer? timer;

    @override
    void initState() {
        super.initState();
        timer = MyAsync.Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
                setState(() {
                    homeGoals = GamePitch.goalA.toString();
                    awayGoals = GamePitch.goalB.toString();
                    seconds = seconds + 1;
                    if(seconds%60 == 0){
                        seconds = 0;
                        minute = minute + 1;
                        if(minute%60 == 0){
                            minute = 0;
                            hour = hour + 1;
                        }
                    }

                    if(data['started']){
                        String hrs = "0" + hour.toString();
                        String mts = minute < 10 ? "0" + minute.toString() : minute.toString();
                        String sds = seconds < 10 ? "0" + seconds.toString() : seconds.toString();
                        timeString = hrs + ":" + mts + ":" + sds;
                    }
                });
            },
        );
    }

    @override
    void dispose() {
        super.dispose();
        timer?.cancel();
    }

    @override
    Widget build(BuildContext context) {
        if(data['started'] == true){
            return Container(
                margin: const EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40), 
                color: Colors.grey[850], 
                child: Table(
                    children: [
                        TableRow(
                            children: [
                                TableCell(
                                    child: Column(
                                        children: [
                                            Image.network(
                                                data['homeImage'],
                                                width: 80,
                                                height: 80
                                            ),
                                            Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), child: Text(data['homeName'], style: TextStyle(color: Colors.white, fontSize: 16))),
                                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text('Top 1 group A', style: TextStyle(color: Colors.grey)))
                                        ]
                                    )
                                ),
                                TableCell(
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(0, 40, 0, 40), 
                                        child: Column(
                                            children: [
                                                Container(padding: EdgeInsets.fromLTRB(20, 5, 20, 5), color: Colors.grey[850], child: Text(homeGoals+" - "+awayGoals, style: TextStyle(color: Colors.white, fontSize: 20))),
                                                Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), child: Text(timeString, style: TextStyle(color: Colors.grey)))
                                            ]
                                        )
                                    )
                                ),
                                TableCell(
                                    child: Column(
                                        children: [
                                            Image.network(
                                                data['awayImage'],
                                                width: 80,
                                                height: 80,
                                                fit:BoxFit.fill
                                            ),
                                            Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), child: Text(data['awayName'], style: TextStyle(color: Colors.white, fontSize: 16))),
                                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text('Top 2 group B', style: TextStyle(color: Colors.grey)))
                                        ]
                                    )
                                ),
                            ],
                        )
                    ]
                )
            );
        }else{
            return Container(
                margin: const EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40), 
                color: Colors.grey[850], 
                child: Table(
                    children: [
                        TableRow(
                            children: [
                                TableCell(
                                    child: Column(
                                        children: [
                                            Image.network(
                                                data['homeImage'],
                                                width: 80,
                                                height: 80
                                            ),
                                            Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), child: Text(data['homeName'], style: TextStyle(color: Colors.white, fontSize: 16))),
                                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text('Top 1 group A', style: TextStyle(color: Colors.grey)))
                                        ]
                                    )
                                ),
                                TableCell(
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20), 
                                        child: Column(
                                            children: [
                                                Container(padding: EdgeInsets.fromLTRB(20, 5, 20, 5), color: Colors.grey[850], child: Text("VS", style: TextStyle(color: Colors.cyan, fontSize: 18))),
                                                Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), color: Colors.grey[850], child: Text(data['date'], style: TextStyle(color: Colors.grey))),
                                                Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), child: Text(data['time'], style: TextStyle(color: Colors.grey)))
                                            ]
                                        )
                                    )
                                ),
                                TableCell(
                                    child: Column(
                                        children: [
                                            Image.network(
                                                data['awayImage'],
                                                width: 80,
                                                height: 80,
                                                fit:BoxFit.fill
                                            ),
                                            Container(padding: EdgeInsets.fromLTRB(0, 5, 0, 5), child: Text(data['awayName'], style: TextStyle(color: Colors.white, fontSize: 16))),
                                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text('Top 2 group B', style: TextStyle(color: Colors.grey)))
                                        ]
                                    )
                                ),
                            ],
                        )
                    ]
                )
            );
        }
    }
}

/* 
ANIMATION WIDGET 
It contains the following four components
*/

class Animation extends StatefulWidget {
    //final String jsonString;
    const Animation();
    AnimationState createState() => AnimationState ();
}

class AnimationState extends State<Animation> {
   // Map<String, dynamic> data = new Map<String, dynamic>();
    //final String jsonString;
    // AnimationState(){
    //     //data = jsonDecode(this.jsonString);
    // }

    MyAsync.Timer? timer;

    @override
    void initState() {
        super.initState();
        timer = MyAsync.Timer.periodic(
            const Duration(seconds: 100),
            (timer) {
                setState(() {
                });
            },
        );
    }

    @override
    void dispose() {
        super.dispose();
        timer?.cancel();
    }

    @override
    Widget build(BuildContext context) {
        if(true == true){
            return SizedBox(
                height: 275,
                child: GameWidget(game: GamePitch())
            );
        }else{
            return Text("");
        }
    }
}

// Actuall Animation Resides in the following to components
// The GamePitch manages the positions of all the sprites
class GamePitch extends FlameGame {
    late GameObject background;
    late GameObject football;
    List<GameObject> teamA = [];
    List<GameObject> teamB = [];
    static int possessionA = 1;
    static int possessionB = 1;
    static int passA = 0;
    static int passB = 0;
    static int goalA = 0;
    static int goalB = 0;
    int count = 0;
    int checkCount = 0;
    bool teamFlag = true;
    bool check = true;
    @override
    Future<void> onLoad() async {
        await super.onLoad();
        final playerSprite = await loadSprite("football.png");
        final backgroundSprite = await loadSprite("field.jpeg");
        final blueSprite = await loadSprite("dot_blue.png");
        final redSprite = await loadSprite("dot_red.png");
        addStringToSF();
        background = GameObject(new Vector2(0, 0), 0)
            ..sprite = backgroundSprite
            ..x = size.x/2
            ..y = size.y/2
            ..width = size.x
            ..height = size.y
            ..anchor = Anchor.center;
        
        football = GameObject(new Vector2(size.x / 2, size.y / 2), 1.5)
            ..sprite = playerSprite
            ..x = size.x / 2
            ..y = size.y / 2
            ..width = 10
            ..height = 10
            ..anchor = Anchor.center;
        // football.showLogs(true);

        
        add(background);
        add(football);
        var rng = Random();
        for(var team = 0; team < 2; team++){
            for( var i = 0 ; i < 12; i++ ) {
                var position = new Vector2(30+rng.nextInt((size.x-30).round()).toDouble(), 15+rng.nextInt((size.y-15).round()).toDouble());
                var player = GameObject(position, 0.1)
                    ..sprite = team == 0 ? blueSprite : redSprite
                    ..x = position.x
                    ..y = position.y
                    ..width = 10
                    ..height = 10
                    ..anchor = Anchor.center;
                
                if(team == 0){
                    teamA.add(player);
                }else{
                    teamB.add(player);
                }
                add(player);
            }
        }

    }

    void update(double dt) {
        if (parent == null) {
            updateTree(dt);
        }

        if(football.speed == new Vector2(0, 0)){
            var rng = Random();
            var position;
            if(teamFlag){
                // position = teamA[rng.nextInt(teamA.length)].position;
                position = getOneOfNearestPlayers(football.position, teamA);
                GamePitch.passA++;
                football.moveTo(position);
            }else{
                // position = teamB[rng.nextInt(teamB.length)].position;
                position = getOneOfNearestPlayers(football.position, teamB);
                GamePitch.passB++;
                football.moveTo(position);
            }
            // print("============");
            // print(position);
            // print(teamFlag);
            // print("============");
            if(rng.nextInt(10)<=2){
                teamFlag = !teamFlag;
            }
        }

        if(count%10 == 0){
            // var possessionA = ((Animation.possessionA*100)/(Animation.possessionA+Animation.possessionB)).round().toString();
            // var possessionB = ((Animation.possessionB*100)/(Animation.possessionA+Animation.possessionB)).round().toString();
            // print(possessionA);
            // print(possessionB);
            if(teamFlag){
                GamePitch.possessionA++;
            }else{
                GamePitch.possessionB++;
            }
        }


        if(!check){
            checkCount++;
            if(checkCount > 60){
                check = true;
                checkCount = 0;
            }
        }
        if(check && (football.position.x < 30 || football.position.x > size.x - 30 || football.position.y < 15 || football.position.y > size.y - 15)){
            football.speed = new Vector2(0, 0);
            check = false;
        }




        if(count%300 == 0){
            count = 0;
            for(var team = 0; team < 2; team++){
                for( var i = 0 ; i < 12; i++ ) { 
                    if(team == 0){
                        Vector2 currentPosition = new Vector2(getX(teamA[i].position), getY(teamA[i].position));
                        teamA[i].moveTo(currentPosition);
                    }else{
                        Vector2 currentPosition = new Vector2(getX(teamB[i].position), getY(teamB[i].position));
                        teamB[i].moveTo(currentPosition);
                    }
                }
            }
        }
        count++;
    }

    Vector2 getOneOfNearestPlayers(Vector2 position, List<GameObject> team){
        for(var i=0; i<team.length; i++){
            for(var j=0; j<team.length-1; j++){
                var d1 = position.distanceTo(team[j].position);
                var d2 = position.distanceTo(team[j+1].position);
                if(d1 > d2){
                    GameObject player = team[j];
                    team[j] = team[j+1];
                    team[j+1] = player;
                }
            }
        }
        var rng = Random();
        return team[rng.nextInt(4)].position;
    }

    double getX(Vector2 position){
        var rng = Random();
        var radius = 50;
        var margin = 30;
        var x = position.x+(-1*radius + rng.nextInt(2*radius)).toDouble();
        if(x>margin && x<size.x-margin){
            return x;
        }
        return getX(position);
    }

    double getY(Vector2 position){
        var rng = Random();
        var radius = 50;
        var margin = 15;
        var y = position.y+(-1*radius + rng.nextInt(2*radius)).toDouble();
        if(y>margin && y<size.y-margin){
            return y;
        }
        return getY(position);
    }

    void addStringToSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var savedValue = prefs.getString("stringValue");
        print("Saved Value");
        print(savedValue);
        prefs.setString('stringValue', "abc");
    }
}

// The GameObject is responsible for players and ball movement.
class GameObject extends SpriteComponent {
    var nextPosition;
    double ds = 0.1;
    Vector2 speed = new Vector2(0, 0);
    bool logs = false;
    int count = 0;
    GameObject(Vector2 currentPosition, double _ds){
        nextPosition = currentPosition;
        ds = _ds;
    }

    void showLogs(bool val){
        logs = val;
    }

    void move(Vector2 delta){
        position.add(delta);
    }

    void moveTo(Vector2 delta){
        nextPosition = delta;
        var magnitude = position.distanceTo(delta);
        speed = new Vector2((delta.x-position.x)*ds/magnitude, (delta.y-position.y)*ds/magnitude);
    }

    void update(double dt){
        count++;
        if(speed != new Vector2(0, 0)){
            position.add(speed);
            var distance = position.distanceTo(nextPosition);
            if(logs && count%10 == 0){
                print(distance);
                print(nextPosition);
                print(position);
            }
            if(distance < ds*5){
                if(logs)
                    print("Reached Destination");
                speed = new Vector2(0, 0);
            }
        }else{
            speed = new Vector2(0, 0);
        }
        if(count%10 == 0){
            count = 0;
        }
    }
}



/*
PREDICTION WIDGET
*/

class Prediction extends StatefulWidget {
    final String jsonString;
    const Prediction(this.jsonString);
    PredictionState createState() => PredictionState (this.jsonString);
}

class PredictionState extends State<Prediction> {

    Map<String, dynamic> data = new Map<String, dynamic>();
    final String jsonString;
    int homeGoalsPrediction = -1;
    String homeGoalsPredictionString = "--";
    int awayGoalsPrediction = -1;
    String awayGoalsPredictionString = "--";
    
    String homeTag = "homeGoalsPrediction";
    String awayTag = "awayGoalsPrediction";
    String sHomeTag = "homeGoalsSelection";
    String sAwayTag = "awayGoalsSelection";

    PredictionState(this.jsonString){
        data = jsonDecode(this.jsonString);
        homeTag = "homeGoalsPrediction"+data['id'].toString();
        awayTag = "awayGoalsPrediction"+data['id'].toString();
        sHomeTag = "homeGoalsSelection"+data['id'].toString();
        sAwayTag = "awayGoalsSelection"+data['id'].toString();
    }
    
    MyAsync.Timer? timer;

    @override
    void initState() {
        super.initState();
        timer = MyAsync.Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
                loadPrediction();
            },
        );
    }

    Future<void> loadPrediction() async {
        final prefs = await SharedPreferences.getInstance();
        setState(() {
            int homeGoalsPrediction = prefs.getInt(homeTag) ?? -1;
            int awayGoalsPrediction = prefs.getInt(awayTag) ?? -1;
            if(homeGoalsPrediction >= 0){
                homeGoalsPredictionString = homeGoalsPrediction.toString();
            }
            if(awayGoalsPrediction >= 0){
                awayGoalsPredictionString = awayGoalsPrediction.toString();
            }
        });
    }

    @override
    void dispose() {
        super.dispose();
        timer?.cancel();
    }


    void _settingModalBottomSheet(context){
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc){
                return Container(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 40), 
                    color: Colors.grey[850],
                    child: new Wrap(
                        children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                                child: Center( 
                                    child: Text('Predict Match Results', style: TextStyle(color: Colors.white, fontSize: 20))
                                )
                            ),
                            Table(
                                children: [
                                    TableRow(
                                        children: [
                                            TableCell(
                                                child: Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 5), child: Text(data['homeName'], style: TextStyle(color: Colors.white, fontSize: 20)))
                                            ),
                                            TableCell(
                                                child: Container(
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                            HorizontalSelect("home", jsonString)
                                                        ]
                                                    )
                                                )
                                            ),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                            TableCell(
                                                child: Container(padding: EdgeInsets.fromLTRB(0, 20, 0, 5), child: Text(data['awayName'], style: TextStyle(color: Colors.white, fontSize: 20)))
                                            ),
                                            TableCell(
                                                child: Container(
                                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0), 
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                            HorizontalSelect("away", jsonString)
                                                        ]
                                                    )
                                                )
                                            ),
                                        ]
                                    )
                                ]
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 70, left: 0, right: 0),
                                child: Container(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                            final prefs = await SharedPreferences.getInstance();
                                            int homeGoals = prefs.getInt(sHomeTag) ?? -1;
                                            int awayGoals = prefs.getInt(sAwayTag) ?? -1;
                                            if(homeGoals >= 0){
                                                prefs.setInt(homeTag, homeGoals);
                                            }
                                            if(awayGoals >= 0){
                                                prefs.setInt(awayTag, awayGoals);
                                            }

                                            prefs.remove(sHomeTag);
                                            prefs.remove(sAwayTag);
                                            Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(0.0),
                                        ),
                                        child: Container(
                                            decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                gradient: new LinearGradient(
                                                    colors: [
                                                        Color.fromARGB(255, 246, 117, 153),
                                                        Color.fromARGB(255, 96, 38, 159)
                                                    ],
                                                )
                                            ),
                                            width:  double.infinity,
                                            height: 50,
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                                "Submit",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                textAlign: TextAlign.center,
                                            ),
                                        ),
                                    ),
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 20, left: 0, right: 0),
                                child: GradientBorderButton("Expert Advice", jsonString)
                            )
                        ],
                    ),
                );
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return Table(
            children: [
                TableRow(
                    children: [
                        TableCell(
                            child: Container(
                                margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20), 
                                color: Colors.grey[850], 
                                child: Table(
                                    children: [
                                        TableRow(
                                            children: [
                                                TableCell(
                                                    child: Container( margin: const EdgeInsets.only(top: 10), color: Colors.grey[850], child: Text('Your Prediction', style: TextStyle(color: Colors.white, fontSize: 20)))
                                                ),
                                                TableCell(
                                                    child: Table(
                                                        children: [
                                                            TableRow(
                                                                children: [
                                                                    Text('${Club.shortNames[data["homeName"]]} - ${homeGoalsPredictionString}', textAlign: TextAlign.end, style: TextStyle(color: Colors.cyan, fontSize: 20))
                                                                ]
                                                            ),
                                                            TableRow(
                                                                children: [
                                                                    Text('${Club.shortNames[data["awayName"]]} - ${awayGoalsPredictionString}', textAlign: TextAlign.end, style: TextStyle(color: Colors.yellow, fontSize: 20))
                                                                ]
                                                            )
                                                        ]
                                                    )
                                                )
                                            ]
                                        )
                                    ]
                                )
                            )
                        )
                    ]
                ),
                TableRow(
                    children: [
                        TableCell(
                            child: Container(
                                margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
                                child: Container(
                                    child: ElevatedButton(
                                        onPressed: () {
                                            _settingModalBottomSheet(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(0.0),
                                        ),
                                        child: Container(
                                            decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                gradient: new LinearGradient(
                                                    colors: [
                                                        Color.fromARGB(255, 246, 117, 153),
                                                        Color.fromARGB(255, 96, 38, 159)
                                                    ],
                                                )
                                            ),
                                            width:  double.infinity,
                                            height: 50,
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                                "Predict",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                textAlign: TextAlign.center,
                                            ),
                                        ),
                                    ),
                                    // child: RaisedButton(
                                    //     onPressed: () {
                                    //         _settingModalBottomSheet(context);
                                    //     },
                                    //     textColor: Colors.white,
                                    //     padding: const EdgeInsets.all(0.0),
                                    //     child: Container(
                                    //         width: 400,
                                    //         decoration: new BoxDecoration(
                                    //             gradient: new LinearGradient(
                                    //                 colors: [
                                    //                     Color.fromARGB(255, 246, 117, 153),
                                    //                     Color.fromARGB(255, 96, 38, 159)
                                    //                 ],
                                    //             )
                                    //         ),
                                    //         padding: const EdgeInsets.all(10.0),
                                    //         child: Text(
                                    //             "Predict",
                                    //             style: TextStyle(color: Colors.white, fontSize: 20),
                                    //             textAlign: TextAlign.center,
                                    //         ),
                                    //     ),
                                    // ),
                                )
                            )
                        )
                    ]
                )
            ]
        );
    }
}

class HorizontalSelect extends StatefulWidget {
    final String jsonString;
    final String team;
    const HorizontalSelect(this.team, this.jsonString);
    HorizontalSelectState createState() => HorizontalSelectState (this.team, this.jsonString);
}

class HorizontalSelectState extends State<HorizontalSelect> {
    Map<String, dynamic> data = new Map<String, dynamic>();
    final String jsonString;
    final String team;
    int prediction = -1;
    
    String homeTag = "homeGoalsPrediction";
    String awayTag = "awayGoalsPrediction";
    String sHomeTag = "homeGoalsSelection";
    String sAwayTag = "awayGoalsSelection";

    HorizontalSelectState(this.team, this.jsonString){
        data = jsonDecode(this.jsonString);
        homeTag = "homeGoalsPrediction"+data['id'].toString();
        awayTag = "awayGoalsPrediction"+data['id'].toString();
        sHomeTag = "homeGoalsSelection"+data['id'].toString();
        sAwayTag = "awayGoalsSelection"+data['id'].toString();
    }
    
    MyAsync.Timer? timer;

    @override
    void initState() {
        super.initState();
        loadPrediction();
    }

    Future<void> loadPrediction() async {
        final prefs = await SharedPreferences.getInstance();
        setState(() {
            int goals = -1;
            if(team == "home"){
                goals = prefs.getInt(homeTag) ?? -1;
            }else{
                goals = prefs.getInt(awayTag) ?? -1;
            }
            prediction = goals;
        });
    }

    Future<void>  setPrediction(int _goals) async{
        final prefs = await SharedPreferences.getInstance();
        setState(() {
            prediction = _goals;
            if(team == "home"){
                prefs.setInt(sHomeTag, _goals);
            }else{
                prefs.setInt(sAwayTag, _goals);
            }
        });
    }

    @override
    void dispose() {
        super.dispose();
        timer?.cancel();
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            gradient: LinearGradient(
                                colors: [
                                    Colors.yellow,
                                    Colors.red,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                            ),
                        ),
                        height: 50.0,
                        width: 140,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                color: Colors.grey[850],
                            ),
                            margin: const EdgeInsets.all(2),
                            height: 46.0,
                            child: ListView.builder(
                                itemCount: 11,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                    if(index == prediction){
                                        return GestureDetector(
                                            child: Container(
                                                padding: const EdgeInsets.fromLTRB(10, 9, 10, 9), 
                                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text("${index}", style: TextStyle(color: Colors.red, fontSize: 26, fontWeight: FontWeight.bold))
                                            ),
                                            onTap: () {
                                                setPrediction(index);
                                            }
                                        );
                                    }else{
                                        return GestureDetector(
                                            child: Container(
                                                padding: const EdgeInsets.fromLTRB(10, 11, 10, 11), 
                                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text("${index}", style: TextStyle(color: Colors.white, fontSize: 20))
                                            ),
                                            onTap: () {
                                                setPrediction(index);
                                            }
                                        );
                                    }
                                }
                            ),
                        ),
                    )
                ]
            )
        );
    }
}

class GradientBorderButton extends StatelessWidget {
    final String text;
    final String jsonString;
    const GradientBorderButton(this.text, this.jsonString);

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseExpert(jsonString)),
                );
            },
            child: Container(
                child: Column(
                    children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                gradient: LinearGradient(
                                    colors: [
                                        Colors.yellow,
                                        Colors.red,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                ),
                            ),
                            height: 50.0,
                            width:  double.infinity,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    color: Colors.grey[850],
                                ),
                                margin: const EdgeInsets.all(2),
                                height: 46.0,
                                child: Column(
                                    children: [
                                        Container(padding: EdgeInsets.fromLTRB(0, 11, 0, 11),  child: Text("${text}", style: TextStyle(color: Colors.white, fontSize: 20)))
                                    ]
                                ),
                            ),
                        )
                    ]
                )
            )
        );
    }
}

class ChooseExpert extends StatelessWidget {
    Map<String, dynamic> data = new Map<String, dynamic>();
    final String jsonString;
    String homeTag = "homeGoalsPrediction";
    String awayTag = "awayGoalsPrediction";
    ChooseExpert(this.jsonString){
        data = jsonDecode(this.jsonString);
        homeTag = "homeGoalsPrediction"+data['id'].toString();
        awayTag = "awayGoalsPrediction"+data['id'].toString();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Choose an Expert'),
                backgroundColor: Colors.grey[900],
            ),
            body: Table(
                children: [
                    TableRow(
                        children: [
                            TableCell(
                                child: Card(
                                    color: Colors.grey[850],
                                    child: ListTile(
                                        leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage("https://www.w3schools.com/w3images/avatar2.png")
                                        ),
                                        title: Text("Martin Braithwaite", style: TextStyle(color: Colors.white)),
                                        subtitle: Text("20 Predictions", style: TextStyle(color: Colors.grey)),
                                        trailing: Column(
                                            children: [
                                                Text("99.9%", style: TextStyle(color: Colors.green, fontSize: 20)),
                                                Text("Success", style: TextStyle(color: Colors.white)),
                                            ]
                                        )
                                    )
                                )
                            )
                        ]
                    ),
                    TableRow(
                        children: [
                            TableCell(
                                child: Card(
                                    color: Colors.grey[850],
                                    child: ListTile(
                                        leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage("https://www.w3schools.com/w3images/avatar1.png")
                                        ),
                                        title: Text("Martin Braithwaite", style: TextStyle(color: Colors.white)),
                                        subtitle: Text("20 Predictions", style: TextStyle(color: Colors.grey)),
                                        trailing: Column(
                                            children: [
                                                Text("99.9%", style: TextStyle(color: Colors.green, fontSize: 20)),
                                                Text("Success", style: TextStyle(color: Colors.white)),
                                            ]
                                        )
                                    )
                                )
                            )
                        ]
                    ),
                    TableRow(
                        children: [
                            TableCell(
                                child: const Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                    color: Colors.grey,
                                ),
                            )
                        ]
                    ),
                    TableRow(
                        children: [
                            TableCell(
                                child: GestureDetector(
                                    onTap: () async {
                                        final prefs = await SharedPreferences.getInstance();
                                        prefs.setInt(homeTag, int.parse(data['homeGoals']));
                                        prefs.setInt(awayTag, int.parse(data['awayGoals']));
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                    },
                                    child: Card(
                                        color: Colors.grey[850],
                                        child: ListTile(
                                            leading: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage('images/robo.gif'),
                                            ),
                                            title: Text("AI Bot Predictions", style: TextStyle(color: Colors.white)),
                                            subtitle: Text("${data['homeName']} ${data['homeGoals']} vs ${data['awayGoals']} ${data['awayName']}", style: TextStyle(color: Colors.yellow)),
                                            trailing: Column(
                                                children: [
                                                    Text("99%", style: TextStyle(color: Colors.green, fontSize: 20)),
                                                    Text("Success", style: TextStyle(color: Colors.white)),
                                                ]
                                            )
                                        )
                                    )
                                )
                            )
                        ]
                    )
                ]
            )
        );
    }
}


/*
HELPER WIDGET
*/

class DynamicText extends StatefulWidget {
    final int type, team;
    const DynamicText(this.type, this.team);
    _DynamicText createState() => _DynamicText (this.type, this.team);
}
class _DynamicText extends State<DynamicText> {
    final int type, team;
    _DynamicText(this.type, this.team){}
    String possessionA = "50";
    String possessionB = "50";
    String passA = "0";
    String passB = "0";
    MyAsync.Timer? timer;

    @override
    void initState() {
        super.initState();
        timer = MyAsync.Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
                setState(() {
                    possessionA = ((GamePitch.possessionA*100)/(GamePitch.possessionA+GamePitch.possessionB)).round().toString();
                    possessionB = ((GamePitch.possessionB*100)/(GamePitch.possessionA+GamePitch.possessionB)).round().toString();
                    passA = GamePitch.passA.toString();
                    passB = GamePitch.passB.toString();
                });
            },
        );
    }

    @override
    void dispose() {
        super.dispose();
        timer?.cancel();
    }

    @override
    Widget build(BuildContext context) {
        if(this.type == 0 && this.team == 0){
            return Text(possessionA, style: TextStyle(color: Colors.yellow));
        }else if(this.type == 0 && this.team == 1){
            return Text(possessionB, textAlign: TextAlign.end, style: TextStyle(color: Colors.red));
        }else if(this.type == 1 && this.team == 0){
            return Text(passA, style: TextStyle(color: Colors.yellow));
        }else if(this.type == 1 && this.team == 1){
            return Text(passB, textAlign: TextAlign.end, style: TextStyle(color: Colors.red));
        }else{
            return Text("");
        }
    }
}

class Club{
    static const shortNames = {
        "Man United": "MUN",
        "Man City": "MCI",
        "Manchester Utd": "MNU",
        "Nottm Forest":"FOR",
        "West Ham":"WHU",
        "Tottenham":"TOT",
        "Newcastle":"NEW",
        "Arsenal":"ARS","Aston Villa":"AST","Chelsea":"CHE","Burnley":"BUR","Everton":"EVE","Manchester City":"MNC","Liverpool":"LIV","Manchester United":"MNU","Hull City":"HUL","Leicester City":"LEI","Crystal Palace":"PAL","Newcastle United":"NEW","Tottenham Hotspur":"TOT","Queens Park Rangers":"QPR","Sunderland":"SUN","Southampton":"SOT","Swansea City":"SWA","Watford":"WAT","West Ham United":"WHU","Stoke City":"STO","Norwich":"NOR","West Bromwich Albion":"WBA","Bournemouth":"BOU","Ipswich":"IPS","Fulham":"FUL","Wolves":"WOL","Leeds United":"LEE","Derby County":"DER","Huddersfield":"HUD","Reading":"REA","Birmingham":"BIR","Brighton":"BHA","Middlesbrough":"MID","Brentford":"BRE","Wigan":"WIG","Nottingham Forest":"FOR","Sheffield Wednesday":"SHW","Cardiff City":"CAR","Millwall":"MIL","Blackburn Rovers":"BLA","Bolton Wanderers":"BOL","Preston":"PRE","Real Madrid":"RMD","Juventus":"JUV","Barcelona":"BAR","Roma":"ROM","Sheffield United":"SHU","Charlton":"CHA","Oldham":"OLD","Plymouth":"PLY","Blackpool":"BLA","Swindon":"SWI","Napoli":"NAP","Exeter":"EXE","Inter Milan":"INT","Luton":"LUT","Doncaster":"DON","MK Dons":"MKD","Lazio":"LAZ","Oxford United":"OXF","Milan":"MIL","Rotherham United":"ROT","Coventry City":"COV","Fleetwood":"FLE","Sevilla":"SEV","Valencia":"VAL","Wimbledon":"WIM","York":"YOR","Wycombe":"WYC","Bayern Munich":"MUN","Yeovil Town":"YEO","Gillingham":"GIL","Leyton Orient":"LEY","Peterborough":"PET","Shrewsbury":"SHR","Accrington":"ACC","Atletico Madrid":"AMD","Scunthorpe":"SCU","Atalanta":"ATA","Bristol City":"BRI","Barnsley":"BAR","Cambridge United":"CAM","Torino":"TOR","Lyon":"LYN","Udinese":"UDN","Portsmouth":"POR","Genoa":"GEN","Sampdoria":"SAM","Lille":"LIL","Rochdale":"ROC","Crewe":"CRE","Colchester United":"COL","Notts County":"NOT","Espanyol":"ESP","Stevenage":"STE","Tranmere Rovers":"TRA","Bradford City":"BRA","Walsall":"WAL","Borussia Dortmund":"DOR","Port Vale":"PVL","Deportivo":"DEP","Marseille":"MAR","Monaco":"MON","Malaga":"MAL","Hoffenheim":"HOF","Nice":"NIC","Toulouse":"TOU","Crawley Town":"CRA","Chesterfield":"CHE","Newport":"NEW","Getafe":"GET","Palermo":"PAL","Empoli":"EMP","Cagliari":"CAG","Wolfsburg":"WOL","Granada":"GRA","Villarreal":"VIL","Carlisle United":"CAR","Parma":"PAR","Levante":"LEV","Dagenham and Redbridge":"DAG","Morecambe":"MOR","Koln":"KOL","Sassuolo":"SAS","Rennes":"REN","Bayer Leverkusen":"BAY","Northampton":"NOR","Zurich":"ZUR","Cheltenham":"CHL","Fiorentina":"FIR","Paris Saint German":"PSG","Nantes":"NAN","Hannover":"HAN","Burton Albion":"BUR","Real Sociedad":"RSD","Chievo":"CHV","Southend United":"SOU","Augsburg":"AUG","Schalke":"SCK","Stuttgart":"STU","Bury":"BUR","Mansfield Town":"MAN","Mainz":"MAI","Lorient":"LOR","Eintracht Frankfurt":"EIN","Galatasaray":"GAL","Basel":"BAS","Hartlepool":"HAR","Caen":"CAE","Freiburg":"FRE","Eibar":"EBA","Hamburger":"HAM","Montpellier":"MOT","Hellas Verona":"VER","Werder Bremen":"BRE","Hertha":"HER","Almeria":"ALM","Celta Vigo":"CLV","Metz":"MET","Young Boys":"YBY","Lens":"LEN","Borussia Monchengladbach":"MON","Bordeaux":"BOR","Athletic Bilbao":"ABB","Besiktas":"BES","Zenit St-Petersburg":"ZEN","Paderborn":"PAD","Cesena":"CES","Toronto":"TOR","LA Galaxy":"LGX","CSKA Moscow":"CKM","Elche":"ELE","Saint Etienne":"ASS","Bastia":"BAS","Fenerbahce":"FEN","Cordoba":"COD","Spartak Moscow":"SPA","Rayo Vallecano":"RVA","Trabzonspor":"TRA","Guingamp":"GUN","Dynamo Moscow":"DNM","Lokomotiv Moscow":"LKM","Evian":"EVA","DC United":"DCU","Krasnodar":"KRA","New York Red Bulls":"NRB","Orlando City":"ORL","Thun":"THU","Bursaspor":"BUR","Rubin Kazan":"KAZ","Chicago Fire":"CHF","Real Salt Lake":"RSL","Ufa":"UFA","Vaduz":"VAD","New England":"NWE","Vancouver Whitecaps":"VCW","Ajaccio":"AJA","Dallas":"FCD","Grasshoppers":"GRA","Portland Timbers":"PTT","Seattle Sounders":"SSO","Ural":"URA","America":"AME","Houston Dynamo":"HSD","Stade Reims":"SDR","Colorado Rapids":"CRP","Sporting Kansas City":"SKC","Gallen":"GAL","Montreal Impact":"MTI","Arsenal Tula":"ARS","Earthquakes":"SJE","Lucerne":"LUC","Columbus Crew":"CCR","Aarau":"AAR","Rostov":"ROS","Philadelphia Union":"PUN","Kuban Krasnodar":"KKA","Gaziantepspor":"GAZ","Amkar Perm":"AKP","Istanbul Buyuksehir":"ISB","Terek Grozny":"TRG","Mordovia":"MOR","Torpedo Moscow":"TMW","Sion Sitten":"SST"};
}
