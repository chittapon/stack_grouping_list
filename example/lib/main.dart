import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stack_grouping_list/source/stack_grouping_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack grouping list example',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: CupertinoNavigationBar(
          middle: Text('Stack grouping list example'),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              _firstSection(),
              _secondSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstSection() {
    return StackGroupingContainer(
      itemBuilder: (BuildContext context, int index, bool isExpanded){
        List<BoxShadow> boxShadow = [BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.04), offset: Offset(0, 3),)];
        // Prevent shadow too dark
        if (!isExpanded){
          if (index > 3 ){
            boxShadow = null;
          }
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: boxShadow,
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(width: 10,),
                  Text('MESSENGER'),
                  Spacer(),
                  Text('1m ago'),
                ],
              ),
              SizedBox(height: 4,),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Wick',
                      ),
                      SizedBox(height: 4,),
                      Text('Everything\'s got a price.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 3,
      headerBuilder: (BuildContext context, bool isExpanded, VoidCallback onDismiss){
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('Messenger',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: Row(
                    children: [
                      Text('Show less',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_up),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      groupingItemCount: 3,
      itemHeight: 90,
      headerHeight: 46,
      expandItemPadding: 15,
      onSelectItem: (index){
        print("select item $index");
      },
    );
  }

  Widget _secondSection() {
    return StackGroupingContainer(
      itemBuilder: (BuildContext context, int index, bool isExpanded){
        List<BoxShadow> boxShadow = [BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.04), offset: Offset(0, 3),)];
        // Prevent shadow too dark
        if (!isExpanded){
          if (index > 3 ){
            boxShadow = null;
          }
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: boxShadow,
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(width: 10,),
                  Text('FACEBOOK'),
                  Spacer(),
                  Text('1m ago'),
                ],
              ),
              SizedBox(height: 4,),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Wick mentioned you in a post.',),
                      SizedBox(height: 4,),
                      Text('I’m Thinking I’m Back.',),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 5,
      headerBuilder: (BuildContext context, bool isExpanded, VoidCallback onDismiss){
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('Facebook',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: Row(
                    children: [
                      Text('Show less',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_up),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      groupingItemCount: 3,
      itemHeight: 90,
      headerHeight: 46,
      expandItemPadding: 15,
      onSelectItem: (index){
        print("select item $index");
      },
    );
  }

}
