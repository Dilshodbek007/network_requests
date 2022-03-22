

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:network_request_openbudget/network_request.dart';
import 'package:network_request_openbudget/user2_detail.dart';
import 'package:network_request_openbudget/user_detail.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final phoneController=TextEditingController();
  final smsController=TextEditingController();
  final phoneSMSController=TextEditingController();
  String? phoneNumber;
  String token = '12';

  void _apiPhoneNum(User user) {
    NetworkRequests.postRequest(
      NetworkRequests.apiPost,
      NetworkRequests.paramsCreate(user),
    ).then((value) => {
        if (value != null)
          {
            print('token0:$value'),
            setState(() {
              token = value['token'];
            })
          }
        else
          {print('no response000')},
      },
    );
  }


  void sendSMS(){
    var user2=User2(phoneSMSController.text, smsController.text,token);
    _apiSMS(user2);
    print(phoneSMSController.text);
    print(smsController.text);
    print(token);
  }

  void _apiSMS(User2 user2){
    // for(int i=0; i<10; i++){
    NetworkRequest2.POST(NetworkRequest2.apiSMS, NetworkRequest2.paramsCreateSMS(user2)).then((value) => {
      print('value----------- $value'),
      if(value!=null){
        setState(() {
          token=value[token];
        }),
        print('token1:$value'),
        print(token),
      }else{
        print('no response111')
      },
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //telefon nomer kiritish
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
                controller: phoneController,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: "+998 (##) ###-##-##")
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "+998 (__) -___-__-__",
                    border: InputBorder.none,
                  )),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: (){
                  phoneNumber=phoneController.text.toString().trim();
                  var user=User(phoneNumber!);
                  _apiPhoneNum(user);
                  print(phoneNumber);
                },
                child:const Text('SMS.ni olish uchun bosing',style: TextStyle(fontSize: 16),),
            style:TextButton.styleFrom(
              backgroundColor: Colors.yellow,
              primary: Colors.black,
              padding: const EdgeInsets.all(20)
            ),
            ),
            const SizedBox(height: 20),

            //telefon
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
                  controller: phoneSMSController,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: "998#########"),
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "telefon nomer kirit",
                    border: InputBorder.none,
                  )),
            ),
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
            TextButton(
              onPressed: (){
                sendSMS();
              },
              child:const Text('Sms kodni tasdiqlang',style: TextStyle(fontSize: 16),),
              style:TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.black,
                  padding: const EdgeInsets.all(20)
              ),
            )
          ],
        ),
      )
    );
  }
}
