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
  AnimationController animationController0,animationController1,animationController2,animationController3,animationController4;
  Animation<double>animation_red,animation_org,animation_yel,animation_gr,animation_bl;
  bool open_status = false;
  @override
  void initState(){
    super.initState();
    //(1)
    animationController0 = AnimationController(vsync:this, duration:Duration(milliseconds : 1000));
    animationController1 = AnimationController(vsync:this, duration:Duration(milliseconds : 1000));
    animationController2 = AnimationController(vsync:this, duration:Duration(milliseconds : 1000));
    animationController3 = AnimationController(vsync:this, duration:Duration(milliseconds : 1000));
    animationController4 = AnimationController(vsync:this, duration:Duration(milliseconds : 1000));
    animation_red = Tween(begin:1.0, end:0.0).animate(animationController0);
    animation_org = Tween(begin:1.0, end:0.0).animate(animationController1);
    animation_yel = Tween(begin:1.0, end:0.0).animate(animationController2);
    animation_gr = Tween(begin:1.0, end:0.0).animate(animationController3);
    animation_bl = Tween(begin:1.0, end:0.0).animate(animationController4);

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
              //alignment: Alignment.center,
              children: <Widget>[
                AnimatedBuilder(
                    animation:animationController0,
                    builder : (context, child)
                    {
                      return Container(
                        height : 128,
                        width : 128 * animation_red.value,
                        color : Colors.red,
                      );
                    }
                ),
                AnimatedBuilder(
                    animation:animationController1,
                    builder : (context, child)
                    {
                      return Container(
                        height : 64 * animation_org.value,
                        width : 128 ,
                        color : Colors.orange,
                      );
                    }
                ),
                AnimatedBuilder(
                    animation:animationController2,
                    builder : (context, child)
                    {
                      return Container(
                        height : 64,
                        width : 64 * animation_yel.value,
                        color : Colors.yellow,
                      );
                    }
                ),
                AnimatedBuilder(
                    animation:animationController3,
                    builder : (context, child)
                    {
                      return Container(
                        height : 64 * animation_gr.value,
                        width : 32 ,
                        color : Colors.green,
                      );
                    }
                ),
                AnimatedBuilder(
                    animation:animationController4,
                    builder : (context, child)
                    {
                      return Container(
                        height : 32,
                        width : 32 * animation_bl.value,
                        color : Colors.blue,
                      );
                    }
                )
              ],
            ),
            RaisedButton(
              child:Text('Animated show!',style: TextStyle(color:Colors.black, fontSize: 20),),
              onPressed: (){
                animationController4.forward();
                animationController4.addStatusListener(
                        (AnimationStatus status){
                          if(status == AnimationStatus.completed)
                            animationController3.forward();
                        });
                animationController3.addStatusListener(
                        (AnimationStatus status){
                          if(status == AnimationStatus.dismissed)
                            animationController4.reverse();
                          if(status == AnimationStatus.completed)
                            animationController2.forward();
                    });
                animationController2.addStatusListener(
                        (AnimationStatus status){
                          if(status == AnimationStatus.dismissed)
                            animationController3.reverse();
                          if(status == AnimationStatus.completed)
                            animationController1.forward();
                    });
                animationController1.addStatusListener(
                        (AnimationStatus status){
                          if(status == AnimationStatus.dismissed)
                            animationController2.reverse();
                          if(status == AnimationStatus.completed)
                            animationController0.forward();
                    });
                animationController0.addStatusListener(
                        (AnimationStatus status){
                          if(status == AnimationStatus.completed)
                            animationController0.reverse();
                          if(status == AnimationStatus.dismissed)
                            animationController1.reverse();
                    });
                },
            )
        ]
        )
      ),
    );
  }
}
