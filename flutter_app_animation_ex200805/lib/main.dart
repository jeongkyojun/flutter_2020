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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController0,animationController1;
  Animation<double>animation1,animation2;
  bool open_status = false;
  @override
  void initState(){
    super.initState();
    //(1)
    animationController0 = AnimationController(vsync:this, duration:Duration(milliseconds : 100));
    animationController1 = AnimationController(vsync:this, duration:Duration(milliseconds : 500));
    animation1 = Tween(begin:1.0, end:0.0).animate(animationController0);
    animation2 = Tween(begin:1.0, end:0.0).animate(animationController1);

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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
                animation:animationController0,
                builder : (context, child)
                {
                  return Container(
                    height : 32,
                    width : 128 * animation1.value,
                    color : Colors.red,
                  );
                }
            ),
            AnimatedBuilder(
                animation:animationController1,
                builder : (context, child)
                {
                  return Container(
                    height : 32 ,
                    width : 128 * animation2.value ,
                    color : Colors.orange,
                  );
                }
            ),
            RaisedButton(
              child:Text('show'),
              onPressed: (){
                animationController0.forward();
                animationController1.forward();
                animationController0.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)
                        animationController0.reverse();
                      if(status == AnimationStatus.dismissed)
                        animationController0.forward();
                    });
                animationController1.addStatusListener(
                        (AnimationStatus status){
                      if(status == AnimationStatus.completed)
                        animationController1.reverse();
                      if(status == AnimationStatus.dismissed)
                        animationController1.forward();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
