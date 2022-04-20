

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:network_request_openbudget/network_new.dart';
import 'package:network_request_openbudget/user2_detail.dart';
import 'package:network_request_openbudget/user_detail.dart';
import 'package:numberpicker/numberpicker.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final phoneController=TextEditingController();
  final smsController=TextEditingController();


  String data0='...';
  int _currentValue=10;
  List<String?> resultList=[];

  static const maxSecondss=180;
  int secondss=maxSecondss;
  Timer? _timer;

  void _api1CreatePost()async{
    var user=User(phoneController.text.toString());
    print(phoneController.text.toString());
    await Network1.method1(Network1.apiPost, Network1.paramsCreate(user)).then((response) =>{
      debugPrint(response.toString()),
      setState(() {
        data0=response.toString();
      })
    });
  }

  _api2CreatePost()async{
    String phone=phoneController.text.toString().replaceAll(RegExp(r'[^0-9]'),'');
    String sms=smsController.text.toString().trim();
    Map<String, dynamic> map=jsonDecode(Network1.token);
    var token=map['token'];

    var user2=User2(phone: phone,OTP: sms,token: token);

    for(int i=0; i<_currentValue; i++) {
      Network2.method2(Network2.apiSMS,Network2.paramsCreateSMS(user2)).then((value) => {
        setState(() {
          resultList.add(value);
          print(value);
        }),
      });
    }
    print('map:$map');
    print(phone);
    print(sms);
    print(token);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            title: Text('$secondss',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
              ),),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(onPressed: (){
                  stopTimerr(resett: false);
                }, child: const Text('Pause Timer',style: TextStyle(color: Colors.black),)),
              )
            ],
          ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //telefon nomer kiritish
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black
                                ),
                                top: BorderSide(
                                    color: Colors.black
                                ),
                                left: BorderSide(
                                    color: Colors.black
                                ),
                                right: BorderSide(
                                    color: Colors.black
                                )

                            )
                        ),
                        child: TextField(
                          controller: phoneController,
                            inputFormatters: [
                              MaskTextInputFormatter(mask: "+998 (##) ###-##-##"),
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: "+998 (__) -___-__-__",
                              border: InputBorder.none,
                            )),
                      ),
                      const SizedBox(height: 20),
                      Text(data0,style: const TextStyle(color: Colors.red),),
                      const SizedBox(height: 20),

                      //button 1
                      TextButton(
                          onPressed: (){
                            _api1CreatePost();
                            sstartTimer();
                          },
                          child:const Text('Telefon Nomerni Tasdiqlang',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      style:TextButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        primary: Colors.black,
                        padding: const EdgeInsets.all(20)
                      ),
                      ),
                      const SizedBox(height: 20),

                      //number picker
                      const Text('Harakatlar Soni:',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      NumberPicker(
                        value: _currentValue,
                        minValue: 10,
                        maxValue: 100,
                        onChanged: (value) => setState(() => _currentValue = value),
                      ),
                      Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          color: Colors.orange,
                          child: Text('$_currentValue',style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),)
                      ),
                      //telefon
                      const SizedBox(height: 20),
                      //sms
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black
                                ),
                                top: BorderSide(
                                    color: Colors.black
                                ),
                                left: BorderSide(
                                    color: Colors.black
                                ),
                                right: BorderSide(
                                    color: Colors.black
                                )

                            )
                        ),
                        child: TextField(
                            controller: smsController,
                            inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(6),
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: "SMS Kod Kiriting",
                              border: InputBorder.none,
                            )),
                      ),
                      const SizedBox(height: 20),

                      //button 2
                      TextButton(
                        onPressed: (){
                          _api2CreatePost();
                          },
                        child:const Text('Sms kodni tasdiqlang',style: TextStyle(fontSize: 16),),
                        style:TextButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            primary: Colors.black,
                            padding: const EdgeInsets.all(20)
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 10),
                    itemCount: resultList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, ctx){
                      return Container(
                        alignment: Alignment.center,
                        color: resultList[ctx]=='Ovoz Berildi'?Colors.blue:Colors.red,
                        padding:const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(resultList[ctx]??'no data',style: const TextStyle(fontSize: 16,color: Colors.white),),
                      );
                      }),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  void sstartTimer({bool resett=true}) {
    if(resett){
      resetTimerr();
    }
    _timer=Timer.periodic(const Duration(seconds: 1), (_) {
      if(secondss>0){
        setState(() {
          secondss--;
        });
      }else{
        setState(() {
          _timer?.cancel();
        });
      }
    });
  }

  stopTimerr({bool resett= true}){
    if(resett){
      resetTimerr();
    }
    _timer?.cancel();
  }
  void resetTimerr()=> setState(() {
    secondss=maxSecondss;
  });

}
