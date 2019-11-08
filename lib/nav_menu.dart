import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';


import 'pages/GalleryPage.dart';
//import 'pages/HomePage.dart';
import 'main.dart';
import 'utils/class_builder.dart';

void main() {
  ClassBuilder.registerClasses();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('MainPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Beranda', style: TextStyle(color: Colors.white,)),
          icon: Icon(Icons.home, color: Colors.white,size: 30,),
//          page: HomePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Pencarian Sarana',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.search, color: Colors.white,size: 30,),
          page: GalleryPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Galeri',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.image, color: Colors.white,size: 30,),
          page: ClassBuilder.fromString('SettingsPage'),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Informasi',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.info, color: Colors.white,size: 30,),
          page: ClassBuilder.fromString('InformationPage'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/cybertrain.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return LoginSarana();
              },
            ));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(15, 52, 67, 1.0), Color.fromRGBO(15, 52, 67, 1.0)],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
