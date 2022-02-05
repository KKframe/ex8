import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart'; //เอาไว้ import StatelessWidget

void main() {
  runApp(const MyApp());
}

//class MyApp เป็น ส่วนของ flutter
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the number',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(), //พารามิเตอร์ home สำคัญสุด
    );
  }
}

//stateful Widget = หน้า UI ที่react ตามผู้ใช้งาน
//stateless Widget หน้า UI ที่ไม่ได้ react ตามผู้ใช้งาน(หน้า ui นิ่งๆ)
//Icon(Icons.persons) --> เอาไอคอนรูปคน
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const buttonSize = 30.0;
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  /*final TextEditingController _controller =
  TextEditingController(); */
  String input ='';
  var txt = 'ทายเลข 1 ถึง 100';
  var game = Game();

  var isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ใช้เค้าโครงแอพ 1 หน้า
      //appBar : แถบบาร์ข้างบน
      appBar: AppBar(
        title: const Text(
          'GUESS THE NUMBER',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          //เทียบกับ <div> ใน html
          decoration: BoxDecoration(
              color: Colors.amberAccent.shade100,
              borderRadius: BorderRadius.circular(10.0),
              //border: Border.all(width: 5.0, color: Colors.blue),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2.0, 5.0), //ทิศทางของเงา,
                    blurRadius: 5.0,
                    spreadRadius: 2.0)
              ]),
          //alignment: Alignment.topCenter,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //จัดวางในแนวตั้ง เพราะอยู่ใน column
              //crossAxisAlignment: CrossAxisAlignment.center, //จัดวางในแนวขวาง
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/guess_logo.png', width: 100),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'GUESS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.amber.shade800,
                            ),
                          ),
                          Text(
                            'THE NUMBER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.amber.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                /*SizedBox(
                  height: 20,
                ),*/

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(input,style: TextStyle(fontSize: 35),),
                      Text(txt,style: TextStyle(fontSize: 20),),
                    ],
                  )
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildButton(1),
                          _buildButton(2),
                          _buildButton(3),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildButton(4),
                          _buildButton(5),
                          _buildButton(6),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildButton(7),
                          _buildButton(8),
                          _buildButton(9),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: OutlinedButton(onPressed: () {
                                setState(() {
                                  input ='';
                                });
                            },
                              child: Icon(Icons.clear_outlined,color: Colors.black),
                            ),
                          ),
                          _buildButton(0),
                          _buildButton(-1),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {

                      if(isCorrect){
                        game = Game();
                        isCorrect = false;
                      }
                      //โค้ดที่จะทำงานเมื่อกดปุ่ม

                      var guess = int.tryParse(input);
                      if (guess != null) {
                        var result = game.doGuess(guess);
                        setState(() {
                          input ='';
                          if (result == 1) {
                            txt = '$guess : มากเกินไป';
                          }else if(result == -1) {
                            txt = '$guess : น้อยเกินไป';
                          }else if (result == 0) {
                            txt = '$guess : ถูกต้อง 🎉 ( ทาย ' +
                                (game.guessCount).toString()+' ครั้ง )';
                            isCorrect = true;
                          }
                        });


                      }else{
                        showDialog(context: context,  barrierDismissible: false,builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('ERROR'),
                            content:Text('กรุณากรอกตัวเลข'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                      }

                    },
                    child: Text(
                      'GUESS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildButton(int num) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: OutlinedButton(onPressed: () {
        if (num == -1) {
          //print('Backspace');
          setState(() {
            //'12345' เราจะตัดเลข5ทิ้ง
            var len = input.length;
            input = input.substring(
                0, len - 1); // 0 คือเราจะเริ่มตำแหน่งไหน ถึงตำปหน่งอะไรที่เราจะสับ
          });
        }else {
          //print('$num');
          setState(() {
            input = '$input$num';
          });
        }
      },
        child: (num == -1 )?Icon(Icons.backspace_outlined,color: Colors.black,):Text('$num',style: TextStyle(fontSize: 10,color: Colors.black),),
      ),
    );
  }
}



/*trick
กด Ctrl+space bar ==> all method in that class
Alt+Enter ==> to wrap
ถ้า... ?[ ....ใส่พวกปุ่มหรือการทำงาน....]

*/
//(num==-2)?Icon(Icons.clear_outlined,)
