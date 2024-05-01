import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.redAccent,
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.green,
                    )
                ),
              ],
            )

          ],
        ),
      )
    );
  }
}
