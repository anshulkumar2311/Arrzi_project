import 'package:arzi_pro/main.dart';
import 'package:arzi_pro/screen2.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  Screen3({required this.name,required this.phone,required this.image,required this.age,required this.department});
  String age;
  String phone;
  String name;
  String image;
  String department;
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text("Screen3",style: TextStyle(
          fontSize: 30
        ),),
        backgroundColor: Colors.black54,),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 4,
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 3,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(
                            0, 10
                        ),
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.image),
                    )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.name,style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
              SizedBox(height: 50,),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text("Age:     ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(width: 15,),
                  Text(widget.age,style: TextStyle(fontSize: 30),),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text("Mobile: ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(width: 15,),
                  Text(widget.phone,style: TextStyle(fontSize: 30),),
                ],
              ),
              SizedBox(
                height: 25,
              ),Row(
                children: [
                  SizedBox(width: 30,),
                  Text("Department: ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(width: 15,),
                  Text(widget.department,style: TextStyle(fontSize: 30),),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          children: [
            SizedBox(width: 80,),
            Container(
              width: 100,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black26,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),));
              }, child: Text("Screen1")),
            ),
            SizedBox(width: 30,),
            Container(
              width: 100,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black26,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen2(),));
              }, child: Text("Screen2")),
            ),
          ],
        ),
      ),

    );
  }
}
