import 'dart:convert';

import 'package:dio/dio.dart';
import 'file:///C:/Users/Deepu/AndroidStudioProjects/first_app/lib/models/todomodelevents.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_profile.dart';




class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {


  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFF7FBFE),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.5,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 3.5,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                    Container(
                      height: 3.5,
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: false,
          title: Text(
            "My Jiivo",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: Color(0xFFFF8701),
                ),
                onPressed: () {}),
          ],
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0,
                color: Color(0xFFFF8701),
              ),
              insets: EdgeInsets.symmetric(horizontal: 40.0),
            ),
            tabs: [
              Tab(
                  child: Text(
                    "Current event",
                    style: TextStyle(
                        color: Color(0xFFBCBCBC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
              Tab(
                  child: Text(
                    "Past event",
                    style: TextStyle(
                        color: Color(0xFFBCBCBC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CurrentEvent(),
            PastEvent(),
          ],
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF8701),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0x5CFF8701),
                )
              ]),
          child: IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 30),
              onPressed: () {}),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.event_note_sharp, size: 30),
                          color: Color(0xFFFF8701),
                          onPressed: () {}),
                      Text(
                        "Event",
                        style: TextStyle(
                            color: Color(0xFFFF8701),
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.people_alt_outlined, size: 30),
                          color: Colors.grey[200],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileClass(),
                              ),
                            );
                          }),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentEvent extends StatefulWidget {
  const CurrentEvent({

    Key key,
  }) : super(key: key);

  @override
  _CurrentEventState createState() => _CurrentEventState();
}

class _CurrentEventState extends State<CurrentEvent> {
  Welcome listTodos = Welcome();
  bool fetching = true;

  void getHttp() async {
    setState(() {
      fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/events?type=current");
      setState(() {
        listTodos = welcomeFromJson(jsonEncode(response.data)) ;
        fetching = false;
      });
    } catch (e) {
      setState(() {
        fetching = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTodos.events.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, ),
      color: Color(0xffF7FBFE),
      padding: EdgeInsets.only(top: 18),
      child:
      ListView.builder(
          itemCount: listTodos.events.length,
          itemBuilder: (context , index){
            Welcome todo = listTodos;
            return Column(
              children: [

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff00000008),
                            offset: Offset(0,3),
                            blurRadius: 6
                        )
                      ]
                  ),

                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFF6EE),
                                  border: Border(
                                    left: BorderSide(color: Color(0xffFF8701)),
                                    right: BorderSide(color: Color(0xffFF8701)),
                                    top: BorderSide(color: Color(0xffFF8701)),
                                    bottom: BorderSide(color: Color(0xffFF8701)),
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(
                                    "${todo.events[index].date}",
                                    style: TextStyle(
                                        color: Color(0xFFFF8701),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ),
                            // Text(
                            //   "\nFeb",
                            //   style: TextStyle(
                            //       color: Color(0xFF2A3E68),
                            //       fontSize: 6,
                            //       fontWeight: FontWeight.bold),
                            // ),

                            SizedBox(width: 11,),
                            Container(
                              child: Text("${todo.events[index].title}"
                                , style: TextStyle(color:Color(0xff2A3E68), fontWeight: FontWeight.bold,fontSize: 13 ),),
                            ),
                          ],
                        ),
                      ),


                      // SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),

                        child: Image.network("${todo.events[index].bannerImage}" ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( "${todo.events[index].description}"  ,
                              style: TextStyle(color: Color(0xff2A3E68) , fontWeight: FontWeight.bold, fontSize: 16),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  "${todo.events[index].from}",
                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),),
                                SizedBox(width: 5,),
                                Text(
                                  "-",

                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),),
                                SizedBox(width: 5,),


                                Text(
                                  "${todo.events[index].to}",
                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.circle,
                                  size: 3,
                                  color: Color(0xFFA1A0A0),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${todo.events[index].location}",
                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),)
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Positioned(
                                left: -40,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/prasad.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -30,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/apparna.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -20,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/sowmya.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -10,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/sunil.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(

                                child: CircleAvatar(
                                  backgroundColor: Color(0xffFF8701),
                                  //backgroundImage: AssetImage("${todo.events[index].usersAttending}"),
                                  child: Center(child: Text("+99" , style: TextStyle(fontSize: 8, color: Colors.white),)),
                                  radius: 12,
                                ),
                              ),

                            ],
                          )
                      ),




                      SizedBox(height: 12,),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ) ;
          }
      ),
    );
  }
}

class PastEvent extends StatefulWidget {
  @override
  _PastEventState createState() => _PastEventState();
}

class _PastEventState extends State<PastEvent> {
  Welcome listTodos = Welcome();
  bool fetching = true;

  void getHttp() async {
    setState(() {
      fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/events?type=past");
      setState(() {
        listTodos = welcomeFromJson(jsonEncode(response.data)) ;
        fetching = false;
      });
    } catch (e) {
      setState(() {
        fetching = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTodos.events.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, ),
      color: Color(0xffF7FBFE),
      padding: EdgeInsets.only(top: 18),
      child:
      ListView.builder(
          itemCount: listTodos.events.length,
          itemBuilder: (context , index){
            Welcome todo = listTodos;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff00000008),
                            offset: Offset(0,3),
                            blurRadius: 6
                        )
                      ]
                  ),

                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFF6EE),
                                      border: Border(
                                        left: BorderSide(color: Color(0xffFF8701)),
                                        right: BorderSide(color: Color(0xffFF8701)),
                                        top: BorderSide(color: Color(0xffFF8701)),
                                        bottom: BorderSide(color: Color(0xffFF8701)),
                                      ),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "${todo.events[index].date}",
                                        style: TextStyle(
                                            color: Color(0xFFFF8701),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 11,),
                                Container(
                                  child: Text("${todo.events[index].title}"
                                    , style: TextStyle(color:Color(0xff2A3E68), fontWeight: FontWeight.bold,fontSize: 13 ),),
                                ),
                              ],
                            ),
                            Icon(Icons.favorite_border,color: Color(0xFFFF8701),),
                          ],
                        ),
                      ),

                      // SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),

                        child: Image.network("${todo.events[index].bannerImage}" ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( "${todo.events[index].description}"  ,
                              style: TextStyle(color: Color(0xff2A3E68) , fontWeight: FontWeight.bold, fontSize: 16),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  "${todo.events[index].from}",
                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),),
                                SizedBox(width: 5,),
                                Text(
                                  "-",

                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),),
                                SizedBox(width: 5,),


                                Text(
                                  "${todo.events[index].to}",
                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.circle,
                                  size: 3,
                                  color: Color(0xFFA1A0A0),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${todo.events[index].location}",
                                  style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),)
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Positioned(
                                left: -40,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/prasad.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -30,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/apparna.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -20,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/sowmya.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -10,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/sunil.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(

                                child: CircleAvatar(
                                  backgroundColor: Color(0xffFF8701),
                                  child: Center(child: Text("99+" , style: TextStyle(fontSize: 8, color: Colors.white),)),
                                  radius: 12,
                                ),
                              ),

                            ],
                          )
                      ),
                      SizedBox(height: 12,),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ) ;
          }
      ),
    );
  }
}




