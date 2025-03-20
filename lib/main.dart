import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tabola-logo.png',
              fit: BoxFit.contain,
              height: 85,
            ),
            Container(padding: const EdgeInsets.all(8.0), child: Text('Login'))
          ],
        ),
        toolbarHeight: 250,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 15),
                child: Material(
                  elevation: 20.0,
                  shadowColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blue.shade300,
                            ))),
                  ),
                ),
              ),
              Material(
                elevation: 20.0,
                shadowColor: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                          )),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        ), // icon is 48px widget.
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.blue.shade300,
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 130),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}