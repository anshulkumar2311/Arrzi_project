import 'package:arzi_pro/Screen3.dart';
import 'package:arzi_pro/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late String urlimg;
  late int id = 1001;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("arrzi").snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
       ]
        ),
        appBar: AppBar(
          title: Text("Screen2",style: TextStyle(
            fontSize: 30
          ),),
          backgroundColor: Colors.black54,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: (context,index){
                Map<String,dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                urlimg = document["image"] == null ? "Error" :  document["image"];

                return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: MediaQuery.of(context).size.height*0.15,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            print("Hello");
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Screen3(image: document['image'],age: document['age'],department: document['department'],name: document['name'],phone: document['phone'],),));
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 4,
                                    color: Theme
                                        .of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
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
                                    image: urlimg==null ?const NetworkImage("https://st.depositphotos.com/1741875/1237/i/600/depositphotos_12376816-stock-photo-stack-of-old-books.jpg") : NetworkImage(urlimg),
                                  )
                              ),
                            ),
                            SizedBox(
                              width: 35.0,
                            ),
                            Text(
                              document["name"] == null ? "Error" :  document["name"] ,
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),

                            SizedBox(
                              height: 12,
                            ),
                            // Text(
                            //   "Book_Space_Id- ${index+10001}",
                            //   style: GoogleFonts.roboto(
                            //     color: Colors.red,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 24,
                            //   ),
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              );
            }
        ),
      ),
    );
  }
}
