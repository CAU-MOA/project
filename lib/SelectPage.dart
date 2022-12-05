//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final _authentication = FirebaseAuth.instance;
//   User? loggedUser;
//   String deleteId = '';
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }
//
//   void getCurrentUser() {
//     try {
//       final user = _authentication.currentUser;
//       if (user != null) {
//         loggedUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('게시판'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => WritePage() //글 쓰는 페이지로 이동
//                   ));
//             },
//             icon: const Icon(Icons.edit),
//           ),
//           IconButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               icon: const Icon(Icons.logout)),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('post')
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 final docs = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     return PostElement(
//                       //isMe: docs[index]['uid'] == _authentication.currentUser!.uid,
//                       title: docs[index]['title'],
//                       text: docs[index]['text'],
//                       createTime: docs[index]['createTime'],
//                       //editTime : docs[index]['editTime'],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PostElement extends StatelessWidget {
//   const PostElement(
//       {Key? key,
//         //this.isMe,
//         this.userName,
//         this.id,
//         this.title,
//         this.createTime,
//         this.text,
//         this.editTime})
//       : super(key: key);
//   //final bool? isMe;
//   final String? userName;
//   final String? id;
//   final String? title;
//   final String? text;
//   final String? createTime; // 생성시간
//   final String? editTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//
//       //onTap: () {
//       //Navigator.push(
//       //  parentContext,
//       //CupertinoPageRoute(
//       // post의 ID를 전달
//       //  builder: (context) => ViewPage(id: memo.id)));
//       //},
//       //onLongPress: () {
//       // 길게 누르면 삭제
//       //deleteId = memo.id;
//       //showAlertDialog(parentContext);
//       //},
//         child: Container(
//             margin: EdgeInsets.all(5),
//             padding: EdgeInsets.all(10),
//             alignment: Alignment.center,
//             height: 100,
//             color: Color.fromRGBO(240, 240, 240, 1),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Column(
//
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Expanded(
//                         // FutureBuilder
//                         // 非同期処理の結果を元にWidgetを作れる
//                           child: FutureBuilder<QuerySnapshot>(
//                             // 投稿メッセージ一覧を取得（非同期処理）
//                             // 投稿日時でソート
//                               future: FirebaseFirestore.instance
//                                   .collection('post')
//                                   .orderBy('createTime')
//                                   .get(),
//                               builder: (context, snapshot) {
//                                 // データが取得できた場合
//                                 if (snapshot.hasData) {
//                                   // n★3 `List<DocumentSnapshot>`をsnapshotから取り出す。
//
//                                   final List<DocumentSnapshot> documents =
//                                       snapshot.data!.docs;
//                                   // 取得した投稿メッセージ一覧を元にリスト表示
//                                   return ListView(children: [
//                                     Text(
//                                       title!,
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Padding(padding: EdgeInsets.all(10)),
//                                     Expanded(
//                                       child: SingleChildScrollView(
//                                         child: Text(text!),
//                                       ),
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                       children: <Widget>[
//                                         Row(children: [
//                                           Text(
//                                             '게시물 작성 시간:',
//                                             style: TextStyle(fontSize: 11),
//                                             textAlign: TextAlign.end,
//                                           ),
//                                           Text(
//                                             createTime!,
//                                             style: TextStyle(fontSize: 11),
//                                             textAlign: TextAlign.end,
//                                           ),
//                                         ]),
//                                       ],
//                                     )
//                                   ]);
//                                 }
//                               })),
//                     ]),
//               ],
//             )));
//   }
// }
//
// class WritePage extends StatefulWidget {
//   const WritePage({Key? key}) : super(key: key);
//
//   @override
//   State<WritePage> createState() => _WritePageState();
// }
//
// class _WritePageState extends State<WritePage> {
//   final _controller = TextEditingController();
//   String title = '';
//   String text = '';
//
//   @override
//   Widget build(BuildContext context) {
//     // _context = context;
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text('글 작성'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: //(){} ,// saveDB 동작 (밑에 있음)
//                   () async {
//                 //final date =
//                 //DateTime.now().toLocal().toIso8601String(); // 現在の日時
//                 // final email = widget.user.email; // AddPostPage のデータを参照
//                 // 게시물용 document 작성
//                 await FirebaseFirestore.instance
//                     .collection('post') // 컬렉션ID 지정
//                     .doc() // documentID 자동생성
//                     .set({
//                   'title': title,
//                   'text': text,
//                   'createTime': DateTime.now().toString(),
//                 });
//                 // 이전 화면으로 돌아가기
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 2,
//                 onChanged: (value) {
//                   title = value;
//                 },
//                 //style: TextStyle(
//                 //  fontSize: 30, fontWeight: FontWeight.w500),
//                 //obscureText: true,
//                 decoration: InputDecoration(
//                   //border: OutlineInputBorder(),
//                   labelText: '제목',
//                 ),
//               ),
//               Padding(padding: EdgeInsets.all(10)),
//               TextField(
//                 maxLines: 8,
//                 // 변경된 사항을 text에다가 저장을 해주고 this.text에 저장
//                 onChanged: (value) {
//                   text = value;
//                 },
//                 //obscureText: true,
//                 decoration: InputDecoration(
//                   //border: OutlineInputBorder(),
//                   labelText: '내용',
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
//
//
// ///////////////
// // featurebuilder
// Widget gesipanBuilder(BuildContext parentContext) {
//   return FutureBuilder<List<Post>>(
//     builder: (context, snap) {
//       if (snap.data == null) {
//         // || snap.data.isEmpty
//         return Container(
//           alignment: Alignment.center,
//           child: Text(
//             '지금 바로 새로운 글을 작성해보세요!\n',
//             style: TextStyle(fontSize: 15, color: Colors.blue),
//             textAlign: TextAlign.center,
//           ),
//         );
//       }
//
//       //안에 데이터가 있으면 이것을 실행
//       return Expanded(
//         child: ListView.builder(
//           //shrinkWrap: true,
//           physics:  BouncingScrollPhysics(), // bouncing 추가
//           //padding: EdgeInsets.all(20),
//           //primary: false,
//           itemCount: snap.data?.length,
//           itemBuilder: (context, index) {
//             //Post memo = snap.data![index];
//             return InkWell(
//               onTap: () {
//                 //Navigator.push(
//                 // parentContext,
//                 // CupertinoPageRoute(
//                 // post의 ID를 전달
//                 //  builder: (context) => ViewPage(id: memo.id)));
//               },
//               onLongPress: () {
//                 // 길게 누르면 삭제
//                 deleteId = memo.id;
//                 // showAlertDialog(parentContext);
//               },
//               child: Container(
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   alignment: Alignment.center,
//                   height: 100,
//                   color: Color.fromRGBO(240, 240, 240, 1),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Text(
//                             memo.title,
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             memo.text,
//                             style: TextStyle(fontSize: 15),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Text(
//                             "최종 수정 시간: " + memo.editTime.split('.')[0],
//                             style: TextStyle(fontSize: 11),
//                             textAlign: TextAlign.end,
//                           ),
//                         ],
//                       )
//                     ],
//                   )),
//             );
//           },
//         ),
//       );
//     },
//     //future: loadPage(),
//   );
// }
// }
//
