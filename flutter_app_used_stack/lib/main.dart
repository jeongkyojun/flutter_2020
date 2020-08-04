import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  AnimationController animationController,textanimationController;
  Animation<double>animation;
  Animation<Offset>textanimation;
  bool open_status = false;
  @override
  void initState(){
    super.initState();
    //(1)
    animationController = AnimationController(vsync:this, duration:Duration(milliseconds : 1000));
    textanimationController = AnimationController(vsync:this, duration:Duration(milliseconds : 500));
    animation = Tween(begin:0.0, end:1.0).animate(animationController);
    //(2)
    textanimation = Tween(begin:Offset(0,0),end:Offset(-100,100)).animate(textanimationController);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child:Column(
          children: <Widget>[
          Stack(
          children: <Widget>[
            AnimatedBuilder(
                animation:animationController,
                builder : (context, child)
                {
                  return Container(
                    height : 300 * animation.value,
                    width : 200 * animation.value,
                    color : Colors.blueAccent,
                  );
                }
            ),
            AnimatedBuilder(
                animation:animationController,
                builder : (context, child)
                {
                  return Container(
                      height:100*animation.value,
                      width:100*animation.value,
                      color:Colors.red,
                      child:Transform.translate(offset:textanimation.value,
                        //child:Text('hello world!\n my name is kyojun\n how are you?',style:TextStyle(color:Colors.black,fontSize: 20)),
                      )
                  );
                }
              ),
            ],
          ),
            RaisedButton(
              onPressed:(){
                if(open_status)
                {
                  animationController.reverse();
                  open_status = false;
                }
                else{
                  animationController.forward();
                  open_status = true;
                }
                textanimationController.forward();
              },
            )
        ]
        )
      ),
    );
  }
}
