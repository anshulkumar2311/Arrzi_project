import 'package:arzi_pro/Screen3.dart';
import 'package:arzi_pro/screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference arrzi = FirebaseFirestore.instance.collection('arrzi');
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _age = TextEditingController();

  final items = ['HR','Finance','Marketing','HouseKeeping'];
  String? value;
  final picker = ImagePicker();
  File? _image;
  String? downloadUrl;
  void Empty(){
    setState(() {
      _name.text = "";
      _phone.text = "";
      _age.text = "";
    });
  }
  Future imagePicker() async{
    try{
      final pick =await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(pick!=null){
          _image = File(pick.path);
        }
        else{
          final snackbar = SnackBar(content: Text("No Image Selected"));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      });
    }
    catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future uploadImage(File _image) async{
    String? url;
    String imgid = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref =FirebaseStorage.instance.ref().child('images').child('users$imgid');
    await ref.putFile(_image!);
    url =await ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("arrzi")
        .add({
      'name': _name.text,
      'phone': _phone.text,
      'age': _age.text,
      'department':value,
      'image': url,
    });
    print("User Added");
    Empty();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Arrzi", style: TextStyle(
            fontSize: 30
          ),),
          backgroundColor: Colors.black54,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        textItem("Enter Name", _name),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        textItem("Enter Age", _age),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        textItem("Enter Phone", _phone),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black,width: 1)
                          ),

                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(items: items.map(buildMenuItem).toList(),hint: Text("Enter Department",style:  TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey,
                            ),),
                                isExpanded: true,icon: Icon(Icons.arrow_drop_down,color: Colors.black,),value: value ,onChanged:(value) => setState(() =>
                                this.value = value
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _image == null ?  Center(
                                        child: Text("No image is Selected"),
                                      ) : Image.file(_image!),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          imagePicker().whenComplete((){
                                            // uploadImage(_image!);
                                          });
                                        },
                                        child: Text("Select Image")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                uploadImage(_image!);
                              },
                              child: Text(
                                "Submit",
                                style: GoogleFonts.radioCanada(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: ElevatedButton(style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                              ),onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen2(),));
                              } ,child: Text("Screen2")),
                            ),
                            SizedBox(width: 20,),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget textItem(String labletxt, TextEditingController controller) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 55,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white
          ),
          decoration: InputDecoration(
            labelText: labletxt,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.blueGrey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.yellow,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.black,
                )),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item,child: Text(
    item,style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20
  ),
  ),);
}
