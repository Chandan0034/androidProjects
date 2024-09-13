import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:sscprevious/widget/question_information_container.dart';
class QuestionScreen extends StatefulWidget {
  String type;
  String name;
   QuestionScreen({super.key,required this.type,required this.name});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<List<dynamic>> data = [];
  Color _colorContainerA=Colors.white;
  Color _colorContainerB=Colors.white;
  Color _colorContainerC=Colors.white;
  Color _colorContainerD=Colors.white;
  String shortQuestion='';
  String questionHeader='';
  String option_a='';
  String option_b='';
  String option_c='';
  String option_d='';
  String answer='';
  String year='';
  int _second=0;
  int _minutes=0;
  late Timer _timer;
  bool flag=false;
  Random random =Random();
  int index=1;
  int _start=1;
  bool _isLoading = false;
  String _explanation='';
  List<String> option=[];
  DateTime date=DateTime.timestamp();
  @override
  void initState() {
    super.initState();
    loadCSV();
    // getQuestionFile();
  }
  _changeQuestion(int a){
    setState(() {
      try{
        // if (index>data.length - 1) {
        //   index = 0;
        //   _start=1;
        // }
        // if(_start<1){
        //   _start=data.length-1;
        //   index=data.length-1;
        // }
        index = index+a;
        _start=_start+a;
        if(_start>data.length-1){
          _start=1;
        }
        if(_start<1){
          _start=data.length-1;
        }
        shortQuestion = data[index][8].toString();
        questionHeader=data[index][9].toString();
        option_a = data[index][1].toString();
        option_b = data[index][2].toString();
        option_c = data[index][3].toString();
        option_d = data[index][4].toString();
        answer = data[index][6].toString();
        year = data[index][5].toString();
        _explanation = data[index][7].toString();
        _colorContainerD = Colors.white;
        _colorContainerA = Colors.white;
        _colorContainerB = Colors.white;
        _colorContainerC = Colors.white;
        flag = false;
        // QuestionInformation(flag: flag,start: _start, isLoading: _isLoading, answer: answer, explanation: _explanation, option_a: option_a, option_b: option_b, option_c: option_c, option_d: option_d, question_header: questionHeader, shortQuestion: shortQuestion, year: year);
      }
      catch(e){
        print("Error Comes ${e.toString()}");
      }
    });

  }
  void _startTimer(){
    _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _second++;
        if(_second==60){
          _second=0;
          _minutes++;
        }
      });
    });
  }
  Future<void> getQuestionFile() async{
    try{
      FirebaseStorage storage=FirebaseStorage.instance;
      Reference ref=storage.ref().child("spottingError.csv");
      String downloadUrl=await ref.getDownloadURL();
      print("DownloadLink ${downloadUrl}");
      final response= await http.get(Uri.parse(downloadUrl));
      if(response.statusCode==200){
        List<List<dynamic>> table=CsvToListConverter().convert(response.body);
        print(table.length);
        print("Tbale Data ${table}");
      }else{
        print(response.statusCode);
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> loadCSV() async {
    try{
      FirebaseStorage storage=FirebaseStorage.instance;
      Reference ref=storage.ref().child("${widget.type}.csv");
      String downloadUrl=await ref.getDownloadURL();
      final response= await http.get(Uri.parse(downloadUrl));
      setState(() {
        _isLoading=false;
      });
      if(response.statusCode==200) {
        List<List<dynamic>> table = CsvToListConverter().convert(response.body);
        // print(table.length);
        // print("Tbale Data ${table}");
        // final String rawCSV = await rootBundle.loadString("assets/spottingError.csv");
        // List<List<dynamic>> csvTable = CsvToListConverter().convert(rawCSV);
        // print(csvTable.length);
        setState(() {
          data = table;
          // List<dynamic> row=data[1];
          index = random.nextInt(data.length - 1);
          shortQuestion = data[index][8].toString();
          questionHeader = data[index][9].toString();
          option_a = data[index][1].toString();
          option_b = data[index][2].toString();
          option_c = data[index][3].toString();
          option_d = data[index][4].toString();
          answer = data[index][6].toString();
          year = data[index][5].toString();
          _explanation = data[index][7].toString();
          _isLoading=true;
          _startTimer();
        });
      }
    }catch(e){
      print("Errors Comes ${e.toString()}");
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: Center(child: Text("${_minutes<10?"0${_minutes}":_minutes}:${_second<10?"0${_second}":_second}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)),
        title: Center(child: Text(widget.name)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Container(
          child:
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    _changeQuestion(-1);
                  },
                  child: Container(
                    child: Center(child: Text("Previous",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    _changeQuestion(1);
                  },
                  child: Container(
                    child: Center(child: Text("Next",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: flag ? FloatingActionButton(onPressed: (){},child: Icon(Icons.circle_outlined,size: 40,),):Container(),
      body: WillPopScope(
        onWillPop:  () async {
      // Show a dialog when back button is pressed
        bool? exitConfirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Confirmation'),
            content:const Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                // Pop dialog and return false (do not exit)
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // Pop dialog and return true (exit)
                child: Text('Yes'),
              ),
            ],
          ),
        );
      // Return the exitConfirmed value
        return exitConfirmed ?? false;
      },
        child: LayoutBuilder(
            builder: (context,constraints){
              if(constraints.maxWidth<600){
                return _isLoading ? SingleChildScrollView(
                  child: Column(
                          children: [
                            QuestionInformation(colorContainerA: _colorContainerA,colorContainerB: _colorContainerB
                                ,colorContainerC: _colorContainerC,colorContainerD: _colorContainerD
                                ,OptionAContainer: _OptionAContainer,OptionBContainer: _OptionBContainer,OptionCContainer: _OptionCContainer
                                ,OptionDContainer: _OptionDContainer,flag: flag,start: _start, isLoading: _isLoading, answer: answer, explanation: _explanation, option_a: option_a, option_b: option_b, option_c: option_c, option_d: option_d, question_header: questionHeader, shortQuestion: shortQuestion, year: year),
                          ],
                        ),
                ): Center(child:CircularProgressIndicator());
              }else{
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(.7)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding:EdgeInsets.all(5),
                              child:Center(child: Text(questionHeader,style: TextStyle(color: Colors.black.withOpacity(.8),fontSize: 20),)),
                            ),
                            SizedBox(height: 5),
                            Center(child: Container(alignment: Alignment.topCenter,margin:EdgeInsets.all(10),child: Text("${_start}. "+shortQuestion,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(8),
                                  child: Text(year,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(.8)),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              _OptionAContainer("a");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              padding: EdgeInsets.all(8),
                                              child: Text("A) "+option_a,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.black.withOpacity(.3)),
                                                  color: _colorContainerA
                                              ),
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              _OptionBContainer("b");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              padding: EdgeInsets.all(8),
                                              child: Text("B) "+option_b,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black.withOpacity(.3)),
                                                  borderRadius: BorderRadius.circular(10),
                                                  color:_colorContainerB
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              _OptionCContainer("c");
                                            },
                                            child: Container(

                                              margin: EdgeInsets.all(8),
                                              padding: EdgeInsets.all(8),
                                              child: Text("C) "+option_c,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black.withOpacity(.3)),
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: _colorContainerC
                                              ),
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              _OptionDContainer("d");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              padding: EdgeInsets.all(8),
                                              child: Text("D) "+option_d,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black.withOpacity(.3)),
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: _colorContainerD
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                                ],
                              ),// Set background color
                              // child: Column(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: <Widget>[
                              //     Expanded(
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //         children: <Widget>[
                              //           Expanded(
                              //             child: Container(
                              //               color: Colors.blue,
                              //               child: Center(
                              //                 child: Text('Cell 1', style: TextStyle(color: Colors.white)),
                              //               ),
                              //             ),
                              //           ),
                              //           Expanded(
                              //             child: Container(
                              //               color: Colors.green,
                              //               child: Center(
                              //                 child: Text('Cell 2', style: TextStyle(color: Colors.white)),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //         children: <Widget>[
                              //           Expanded(
                              //             child: Container(
                              //               color: Colors.orange,
                              //               child: Center(
                              //                 child: Text('Cell 3', style: TextStyle(color: Colors.white)),
                              //               ),
                              //             ),
                              //           ),
                              //           Expanded(
                              //             child: Container(
                              //               color: Colors.red,
                              //               child: Center(
                              //                 child: Text('Cell 4', style: TextStyle(color: Colors.white)),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      _changeQuestion(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green
                                      ),
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(10),
                                      child: Center(child: Text("Next",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            flag ? Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              child: Center(child: Text(_explanation,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.9)),)),
                            ):SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
        ),
      )
    );
  }
  _OptionAContainer(String value){
    if(answer!=value){
      setState(() {
      _colorContainerA=Colors.red;
      });
    }
    if(value==answer){
      setState(() {
        _colorContainerA=Colors.green;
      });
    }else if(answer=='b'){
      setState(() {
        _colorContainerB=Colors.green;
      });
    }else if(answer=='c'){
      setState(() {
        _colorContainerC=Colors.green;
      });
    }else{
      setState(() {
        _colorContainerD=Colors.green;
      });
    }
    setState(() {
      flag=true;
    });

  }
  _OptionBContainer(String value){
    if(answer!=value){
      setState(() {
        _colorContainerB=Colors.red;
      });
    }
    if(value==answer){
      setState(() {
        _colorContainerB=Colors.green;
      });
    }else if(answer=='a'){
      setState(() {
        _colorContainerA=Colors.green;
      });
    }else if(answer=='c'){
      setState(() {
        _colorContainerC=Colors.green;
      });
    }else{
      setState(() {
        _colorContainerD=Colors.green;
      });

    }
    setState(() {
      flag=true;
    });

  }
  _OptionCContainer(String value){
    if(answer!=value){
      setState(() {
        _colorContainerC=Colors.red;
      });
    }
    if(value==answer){
      setState(() {
        _colorContainerC=Colors.green;
      });
    }else if(answer=='b'){
      setState(() {
        _colorContainerB=Colors.green;
      });
    }else if(answer=='a'){
      setState(() {
        _colorContainerA=Colors.green;
      });
    }else{
      setState(() {
        _colorContainerD=Colors.green;
      });
    }
    setState(() {
      flag=true;
    });
  }
  _OptionDContainer(String value){
    if(answer!=value){
      setState(() {
        _colorContainerD=Colors.red;
      });
    }
    if(value==answer){
      setState(() {
        _colorContainerD=Colors.green;
      });
    }else if(answer=='b'){
      setState(() {
        _colorContainerB=Colors.green;
      });
    }else if(answer=='c'){
      setState(() {
        _colorContainerC=Colors.green;
      });
    }else{
      setState(() {
        _colorContainerA=Colors.green;
      });
    }
    setState(() {
      flag=true;
    });
  }
}
// Set background color
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: <Widget>[
//     Expanded(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               color: Colors.blue,
//               child: Center(
//                 child: Text('Cell 1', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.green,
//               child: Center(
//                 child: Text('Cell 2', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     Expanded(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               color: Colors.orange,
//               child: Center(
//                 child: Text('Cell 3', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.red,
//               child: Center(
//                 child: Text('Cell 4', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
