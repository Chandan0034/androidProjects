import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sscprevious/question_screen.dart';
import 'package:sscprevious/widget/home_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSV Reader App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<List<dynamic>> data = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const  Text('CSV Reader'),
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionScreen(type: "spottingError")));
//           },
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.green.withOpacity(.7)
//             ),
//             child: const Text("Spotting Error"),
//           ),
//         ),
//       ),
//     );
//   }
// }
