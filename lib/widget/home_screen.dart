import 'package:flutter/material.dart';
import 'package:sscprevious/question_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor:Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "spottingError",name: "Spotting Error",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          'Spotting Error',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between the containers
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "ModifiedSentenceImpovement",name: "Sentences Improvement",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Sentence Improvement',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "Modifiedmisspeled",name: "Spelling Error",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          'Spelling Error',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between the containers
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "ModifiedFillup",name: "Fill In The Blanks",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Fill In The Blanks',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "ModifiedActiveToPassive",name: "Voice",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          'Voice',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between the containers
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "ModifiedDirectToIndirect",name: "Narration",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Narration',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "spottingError",name: "Spotting Error",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          'Spotting Error',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between the containers
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(type: "ModifiedSentenceImpovement",name: "Sentences Improvement",)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints(minHeight: 100), // Ensure minimum height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Sentence Improvement',
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 2, // Adjust as needed
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
