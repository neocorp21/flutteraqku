//codigo con reconocimiento de listado
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter aqku copilacion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          margin: EdgeInsets.all(50),
          width: 300,
          height: 90,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.purple, //blue
            borderRadius: BorderRadius.circular(5),
          ),

          /// Comentario: Inicio de lectura de base de datos
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<DocumentSnapshot> docs =
                  (snapshot.data! as QuerySnapshot).docs;

              return Container(
                child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      DocumentSnapshot<Object?> data = docs[i];
                      print('____');
                      print(data);

                      return ListTile(
                          title: Text(data['saldo']),
                          subtitle: Text(data['name']),
                          trailing: Icon(Icons.abc_rounded));
                    }),
              );
            },
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

///CODIGO ANTERIOR
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutteraqku/src/theme/theme.dart';
// import 'package:flutteraqku/src/widget/customRoute.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'src/pages/homePage.dart';
// import 'src/pages/money_transfer_page.dart';
// import 'src/widget/customRoute.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp().then((value) {
//     runApp(MyApp());
//   });
// }

// //  List usuarios [];
// // @override
// // void initState() {
// //   getUsers();
// // }

// // void getUsers() async {
// //   CollectionReference collectionReference =
// //       FirebaseFirestore.instance.collection('users');
// //   QuerySnapshot users = await collectionReference.get();
// //   if (users.docs.length != 0) {
// //     for (var doc in users.docs) {
// //       print(doc.data());
// //       //usuarios.add(doc.data());
// //     }
// //   }
// // }

// class MyApp extends StatelessWidget {
//   // final Stream<QuerySnapshot> users =
//   //     FirebaseFirestore.instance.collection('users').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Wallet App',
//         debugShowCheckedModeBanner: false,
//         theme: AppTheme.lightTheme.copyWith(
//           textTheme: GoogleFonts.mulishTextTheme(
//             Theme.of(context).textTheme,
//           ),
//         ),
//         routes: <String, WidgetBuilder>{
//           '/': (_) => HomePage(),
//           '/transfer': (_) => MoneyTransferPage()
//         },
//         onGenerateRoute: (RouteSettings settings) {
//           final List<String> pathElements = settings.name!.split('/');
//           if (pathElements[0].isEmpty) {
//             return null;
//           }
//           if (pathElements[0] == 'transfer') {
//             return CustomRoute<bool>(
//                 builder: (BuildContext context) => MoneyTransferPage());
//           }
//         });
//   }
// }
