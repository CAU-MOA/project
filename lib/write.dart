import 'package:flutter/material.dart';
import 'gesipan_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'title_alert.dart';
import 'content_alert.dart';

String _nickname ='User1';
class WritePage extends StatefulWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  //  final createTime =   DateTime.now(); // 지금 시간
  // final createTime =  DateTime.now().toLocal().toIso8601String();
  final createTime =  DateTime.now().toIso8601String();
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');
  late String uid = _authentication.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    late String uid = _authentication.currentUser!.uid;
    collectionReference.doc(uid).get().then((value){
      setState(() {
       _nickname = value.get('userName');
      });
    });
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,   // pixcel error 방지
        appBar: AppBar(


            //automaticallyImplyLeading: true,
            title: Text('글 작성'),
            actions: <Widget>[

              IconButton(
                icon: const Icon(Icons.save),
                onPressed: (){
                  if (title.text.isNotEmpty&content.text.isNotEmpty) {
                    FirebaseFirestore.instance.collection('post').add({
                      'title': title.text,
                      'content': content.text,
                      'createTime':createTime.toString(),
                      'User1': _nickname,
                    });
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  }
                  else if(content.text.isEmpty){
                    return showAlertDialogContent(context);
                  }
                  else if(title.text.isEmpty){
                    return showAlertDialogTitle(context);
                  }


                },
              ),
            ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                controller: title,
                decoration: const InputDecoration(
                  labelText: '제목',
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextField(
                maxLines: 8,
                // 변경된 사항을 text에다가 저장을 해주고 this.text에 저장
                controller: content,
                //obscureText: true,
                decoration: const InputDecoration(
                  labelText: '내용',
                ),
              ),
            ],
          ),
        )
    );
  }


}








//
//
// final DateTime now = DateTime.now();
//
// class Date extends StatelessWidget {
//   final List<DateTime> dates = [
//     // 30秒前の時刻
//     now.add(Duration(seconds: 30) * -1),
//     // 30分前の時刻
//     now.add(Duration(minutes: 30) * -1),
//     // 5時間前
//     now.add(Duration(hours: 30) * -1),
//     // 30日前
//     now.add(Duration(days: 30) * -1)
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final difference = dates.map((date) => Text(fromAtNow(date))).toList();
//     return Scaffold(
//       body: Center(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center, children: difference),
//       ),
//     );
//   }
// }
//
// String fromAtNow(DateTime date) {
//   final Duration difference = DateTime.now().difference(date);
//   final int sec = difference.inSeconds;
//
//   if (sec >= 60 * 60 * 24) {
//     return '${difference.inDays.toString()}日前';
//   } else if (sec >= 60 * 60) {
//     return '${difference.inHours.toString()}時間前';
//   } else if (sec >= 60) {
//     return '${difference.inMinutes.toString()}分前';
//   } else {
//     return '$sec秒前';
//   }
// }
//









/////////////////////////////////////////////////


// class WritePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     //_context = context;
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text('글 작성'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: () async {
//                 // post document 작성
//                 var _title;
//                 var _text;
//                 //var createTime;
//                 final createTime =
//                     DateTime.now().toLocal().toIso8601String(); // 지금 시간
//                 await FirebaseFirestore.instance.collection('post').add({
//                   // コレクションID指定
//                   // .doc() // ドキュメントID自動生成
//                   //.set({
//                   'title': _title,
//                   'text': _text,
//                   'createTime': createTime,
//                 });
//                 //Navigator.of(context).pop();
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) {
//                   return MyHomePage();
//                 }));
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 2,
//                 onChanged: (String title) {
//                   title = title;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: '제목',
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.all(10)),
//               TextField(
//                 maxLines: 8,
//                 // 변경된 사항을 text에다가 저장을 해주고 this.text에 저장
//                 onChanged: (String text) {
//                   text = text;
//                 },
//                 //obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: '내용',
//                 ),
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }

/*
  Future<void> saveDB() async {

    DBHelper sd = DBHelper();

    var fido = Post(
      id: str2Sha512(DateTime.now().toString()), // String
      title: this.title,   // rhis.title이 title에 들어가고
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());
    Navigator.pop(_context);
  }

  String str2Sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }

 */

//
// class UserPage extends StatefulWidget {
//   //const UserPage({Key? key}) : super(key: key);
//
//   @override
//   State<UserPage> createState() => _UserPageState();
// }
//
// class _UserPageState extends State<UserPage> {
//   final controllerTitle = TextEditingController();
//   final controllerText = TextEditingController();
//   var User;
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: Text('글 작성'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: ////saveDB, // saveDB 동작 (밑에 있음)
//                 ()  {
//               // post document 작성
//                   final createtime =
//                   DateTime.now().toLocal().toIso8601String(); // 지금 시간
//               //var User;
//               final user = User(
//                 title: controllerTitle,
//                 text: controllerText,
//                 createTime:createtime,
//               );
//
//               createUser(user);
//               // 1つ前の画面に戻る
//               Navigator.of(context).pop();
//             },
//             // onPressed: () {
//             //   //Create
//             //   final user = User(
//             //     title:controllerTitle.text,
//             //     text:controllerText.text,
//             //   );
//             //   createUser(user);
//             //   Navigator.pop(context);
//             // },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               keyboardType: TextInputType.multiline,
//               maxLines: 2,
//               // onChanged: (String title) {
//               //   title = title;
//               // },
//               controller: controllerTitle,
//               decoration: const InputDecoration(
//                 labelText: '제목',
//               ),
//             ),
//             const Padding(padding: EdgeInsets.all(10)),
//             TextField(
//               maxLines: 8,
//               // 변경된 사항을 text에다가 저장을 해주고 this.text에 저장
//               //onChanged: (String text) {
//               //text = text;
//               //},
//               controller: controllerText,
//               decoration: const InputDecoration(
//                 labelText: '내용',
//               ),
//             ),
//           ],
//         ),
//       ));
//   Future createUser(user) async{
//     final docUser = FirebaseFirestore.instance.collection('post').doc();
//     user.id = docUser.id;
//
//     final json = user.toJson();
//     await docUser.set(json);
//   }
// }

//
//
//
//
// /////////////////////////////////////////
// class WritePage extends StatelessWidget {
//   // const WritePage({
//   //   Key? key, this.title, this.text, this.createTime})
//   //     : super(key: key);
//   //
//   // final String? title;
//   // final String? text;
//   // final String? createTime;
//   //
//   // late BuildContext _context;
//   //
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     //_context = context;
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text('글 작성'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: ////saveDB, // saveDB 동작 (밑에 있음)
//                   () async {
//                 // post document 작성
//                 var title;
//                 var text;
//                 //var createTime;
//                 final createTime =
//                 DateTime.now().toLocal().toIso8601String(); // 지금 시간
//                 await FirebaseFirestore.instance.collection('post').add({
//                   // コレクションID指定
//                   // .doc() // ドキュメントID自動生成
//                   //.set({
//                   'title': title,
//                   'text': text,
//                   'createTime': createTime,
//                 });
//                 // 1つ前の画面に戻る
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => MyHomePage()));
//                 //Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 2,
//                 onChanged: (String title) {
//                   title = title;
//                 },
//                 decoration: InputDecoration(
//                   //border: OutlineInputBorder(),
//                   labelText: '제목',
//                 ),
//               ),
//               Padding(padding: EdgeInsets.all(10)),
//               TextField(
//                 maxLines: 8,
//                 // 변경된 사항을 text에다가 저장을 해주고 this.text에 저장
//                 onChanged: (String text) {
//                   text = text;
//                 },
//                 //obscureText: true,
//                 decoration: InputDecoration(
//                   //border: OutlineInputBorder(),
//                   labelText: '내용',
//                 ),
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }
// /*
//   Future<void> saveDB() async {
//
//     DBHelper sd = DBHelper();
//
//     var fido = Post(
//       id: str2Sha512(DateTime.now().toString()), // String
//       title: this.title,   // rhis.title이 title에 들어가고
//       text: this.text,
//       createTime: DateTime.now().toString(),
//       editTime: DateTime.now().toString(),
//     );
//
//     await sd.insertMemo(fido);
//
//     print(await sd.memos());
//     Navigator.pop(_context);
//   }
//
//   String str2Sha512(String text) {
//     var bytes = utf8.encode(text); // data being hashed
//     var digest = sha512.convert(bytes);
//     return digest.toString();
//   }
//
//  */
//
