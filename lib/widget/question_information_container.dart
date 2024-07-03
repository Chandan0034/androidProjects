import 'dart:core';
import 'package:flutter/material.dart';
class QuestionInformation extends StatefulWidget {
  String question_header;
  String shortQuestion;
  String option_a;
  String option_b;
  String option_c;
  String option_d;
  final void Function(String) OptionAContainer;
  final Function(String) OptionBContainer;
  final Function(String) OptionCContainer;
  final Function(String) OptionDContainer;
  final colorContainerA;
  final colorContainerB;
  final colorContainerC;
  final colorContainerD;
  String year;
  String explanation;
  bool isLoading;
  String answer;
  int start;
  bool flag;
  QuestionInformation({super.key ,required this.colorContainerB, required this.colorContainerC,required this.colorContainerD,required this.OptionAContainer,
    required this.OptionBContainer,required this.OptionCContainer,required this.OptionDContainer, required this.colorContainerA,required this.flag,required this.start, required this.isLoading,required this.answer,required this.explanation,required this.option_a,required this.option_b,required this.option_c,
  required this.option_d,required this.question_header,required this.shortQuestion,required this.year});

  @override
  State<QuestionInformation> createState() => _QuestionInformationState();
}

class _QuestionInformationState extends State<QuestionInformation> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
                elevation: 5,
                shadowColor: Colors.black,
                color: Colors.white,
                child: widget.isLoading ? Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(.7)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding:EdgeInsets.all(5),
                      child:Center(child: Text(widget.question_header,style: TextStyle(color: Colors.black.withOpacity(.7),fontSize: 14),)),
                    ),
                    SizedBox(height: 5,),
                    Container(alignment: Alignment.topLeft,margin:EdgeInsets.all(5),child: Text("${widget.start}. "+widget.shortQuestion,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            padding: EdgeInsets.all(5),
                            child: Text(widget.year,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(.8)),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                        children: [Expanded(
                            child: GestureDetector(
                              onTap: (){
                                widget.OptionAContainer("a");
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                child: Text("A) "+widget.option_a,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black.withOpacity(.3)),
                                    color: widget.colorContainerA
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
                                widget.OptionBContainer("b");
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                child: Text("B) "+widget.option_b,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black.withOpacity(.3)),
                                    borderRadius: BorderRadius.circular(10),
                                    color:widget.colorContainerB
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
                                widget.OptionCContainer("c");
                              },
                              child: Container(
      
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                child: Text("C) "+widget.option_c,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black.withOpacity(.3)),
                                    borderRadius: BorderRadius.circular(10),
                                    color: widget.colorContainerC
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
                                widget.OptionDContainer("d");
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                child: Text("D) "+widget.option_d,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black.withOpacity(.3)),
                                    borderRadius: BorderRadius.circular(10),
                                    color: widget.colorContainerD
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    widget.flag ? Column(
                      children: [
                        Container(height: 1,color: Colors.black,margin: EdgeInsets.only(left: 2,right: 2),),
                        SizedBox(height: 2,),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Center(child: Text(widget.explanation,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.9)),)),
                        ),
                      ],
                    ):SizedBox(),
                  ],
                ):CircularProgressIndicator()
      
      ),
    );
  }
}
