import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
class QuestionScreen extends StatefulWidget {
  String type;
  String file;
   QuestionScreen({super.key,required this.type,required this.file});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<List<dynamic>> data = [];
  Color _colorContainerA=Colors.white;
  Color _colorContainerB=Colors.white;
  Color _colorContainerC=Colors.white;
  Color _colorContainerD=Colors.white;
  String question='';
  String option_a='';
  String option_b='';
  String option_c='';
  String option_d='';
  String answer='';
  String year='';
  bool flag=false;
  Random random =Random();
  int index=1;
  int _start=1;
  String _explanation='';
  List<String> option=[];

  @override
  void initState() {
    super.initState();
    loadCSV();
  }
  _changeQuestion(){
    setState(() {
      if(index==data.length-1){
        index=0;
      }
      index=random.nextInt(data.length)+1;
      _start++;
      question=data[index][0];
      option_a=data[index][1];
      option_b=data[index][2];
      option_c=data[index][3];
      option_d=data[index][4];
      answer=data[index][6];
      year=data[index][5];
      _explanation=data[index][7];
      _colorContainerD=Colors.white;
      _colorContainerA=Colors.white;
      _colorContainerB=Colors.white;
      _colorContainerC=Colors.white;
      flag=false;
    });

  }
  Future<void> loadCSV() async {
    try{
      final String rawCSV = await rootBundle.loadString(widget.file);
      List<List<dynamic>> csvTable = CsvToListConverter().convert(rawCSV);
      setState(() {
        data = csvTable;
        // List<dynamic> row=data[1];
        index=random.nextInt(data.length);
        question=data[index][0];
        option_a=data[index][1];
        option_b=data[index][2];
        option_c=data[index][3];
        option_d=data[index][4];
        answer=data[index][6];
        year=data[index][5];
        _explanation=data[index][7];
        print(answer);
      });
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text(widget.type)),
      ),
      body: WillPopScope(
        onWillPop:  () async {
      // Show a dialog when back button is pressed
        bool? exitConfirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit Confirmation'),
            content: Text('Are you sure you want to exit?'),
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
                return SingleChildScrollView(
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Center(child: Container(alignment: Alignment.topCenter,margin:EdgeInsets.all(10),child: Text("${_start}. "+question,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(8),
                                  child: Text(year,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.green.withOpacity(.8)),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              children: [Expanded(
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
                              ]
                            ),
                            Row(
                              children: [
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
                              ],
                            ),
                            Row(
                              children: [
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
                            ),
                            SizedBox(height: 8,),
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
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      _changeQuestion();
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
                );
              }else{
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Questions:',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Center(child: Container(alignment: Alignment.topCenter,margin:EdgeInsets.all(10),child: Text("${_start}. "+question,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.all(8),
                                child: Text(year,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.green.withOpacity(.8)),),
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
                                    _changeQuestion();
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
