import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:kase_app/screen/SignIn.dart';
import 'package:kase_app/screen/Register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),

    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qrResult ="Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Kase App", style: TextStyle( fontWeight: FontWeight.bold)),
          actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))],

          ),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children:<Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Unknown"),
                accountEmail: Text("Not Found"),
                decoration: BoxDecoration(color: Colors.green),
                )
          ]
        )
      ),
      body: Container(

        child: ListView(
          children: [
            SizedBox(
              height: 150.0,
              width: double.infinity,
              child: Carousel(
                autoplay: false,
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                dotVerticalPadding: 5.0,
                images:[
                  Image.asset('assets/image 1.jpg',
                  fit: BoxFit.cover,),
                  Image.asset('assets/image 2.jpg',
                  fit: BoxFit.cover,),
                  Image.asset('assets/image 3.jpg',
                  fit: BoxFit.cover,),


            ]
            ),
            ),
             IntrinsicHeight(
              child:Row(

                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Expanded(child:Container(
                        padding: EdgeInsets.all(5),
                        child:Column(
                                children:[
                                IconButton(
                                  onPressed: ()async{
                                    String scanning= await BarcodeScanner.scan();
                                    setState(() {
                                      qrResult=scanning;
                                    });
                                  },
                                  icon: const Icon(Icons.qr_code_scanner),
                                  color: Colors.green,iconSize:80,),
                                Text("Trace", style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold ))]),)),

                  VerticalDivider(indent:1,thickness:2,width:2, color:Colors.green),
                   SizedBox(height:150),

                  Expanded(child:Container(
                    padding: EdgeInsets.all(5),child: Column(
                                children:[
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.people), color: Colors.green,iconSize:80,),
                                  Text("Producer", style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold ))],),))
                  ],)
               ,),
             Divider( indent:2,endIndent:2,thickness:2,height:0,color:Colors.green),
             IntrinsicHeight(child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Expanded(child:Container(
                    padding: EdgeInsets.all(5),child:
                            Column(
                              children:[
                                IconButton(onPressed: (){}, icon: const Icon(Icons.storefront), color: Colors.green,iconSize:80,),
                                Text("Mall", style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold ))],),),),

                   VerticalDivider(endIndent:1,thickness:2,width:2, color:Colors.green),
                   SizedBox(height:150),
                   Expanded(child:Container(
                       padding: EdgeInsets.all(5),child:
                            Column(
                              children:[
                                IconButton(onPressed: (){}, icon: const Icon(Icons.call), color: Colors.green,iconSize:80,),
                                Text("Support", style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold ))],))
            )],),),

              Container(
                padding: EdgeInsets.all(10),
                color: Colors.green,
                height:76.5,
                child: InkWell(
                    onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignIn()));},
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                              Align(
                                  alignment:Alignment.centerLeft,
                                  child:Text("Sign In",
                                    style:TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white)),),
                              SizedBox(height:5),
                              Align(
                                    alignment:Alignment.centerLeft,
                                    child:Text("Please use your account to sign in here",
                                        style: TextStyle(fontSize: 15,color:Colors.white)),),
                            ])),),
            Container(
                padding: EdgeInsets.all(10),
                color: Colors.red,
                height:76.5,
                child: InkWell(
                     onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                         builder: (context) => Register()));},
                     child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                         Align(
                              alignment:Alignment.centerLeft,
                              child:Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white))),
                         SizedBox(height:5),
                         Align(
                             alignment:Alignment.centerLeft,
                             child: Text("Create your account to use our services",style: TextStyle(fontSize: 15,color:Colors.white)),),




                    ])))
           ],

        ),





        )
      );
  }
}