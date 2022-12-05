// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'write.dart';
// import 'gesipan_screen.dart';
//
// class CommentPage extends StatefulWidget {
//   const CommentPage({Key? key}) : super(key: key);
//
//   @override
//   State<CommentPage> createState() => _CommentPageState();
// }
//
// class _CommentPageState extends State<CommentPage> {
//   ////////////////
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//       .collection('post')
//       .orderBy('createTime')
//       .snapshots();
//
//   final _authentication = FirebaseAuth.instance;
//   User? loggedUser;
//   CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('user');
//   late String uid = _authentication.currentUser!.uid;
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//     late String uid = _authentication.currentUser!.uid;
//     collectionReference.doc(uid).get().then((value) {
//       setState(() {
//         _nickname = value.get('userName');
//       });
//     });
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
//   final currentUser = FirebaseAuth.instance.currentUser;
//   late final _nickname;
//
//   ///////////////
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text('게시판'),
//         ),
//         body: StreamBuilder(
//             stream: _usersStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text("something is wrong");
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return Stack(
//                 children: [
//                   GestureDetector(
//                       onTap: () {},
//                       child: SingleChildScrollView(
//                         physics: AlwaysScrollableScrollPhysics(),
//                         padding: EdgeInsets.all(8),
//                         child: Column(children: <Widget>[
//                           ListView.builder(
//                               physics: BouncingScrollPhysics(),
//                               padding: EdgeInsets.all(4),
//                               reverse: true, ////
//                              // itemCount: snapshot.data!.docs.length,
//                               itemBuilder: (_, index) {
//                                 return ListTile(
//                                   leading: CircleAvatar(
//                                     backgroundColor: Color(0xffE6E6E6),
//                                     child: Icon(
//                                       Icons.person,
//                                       color: Color(0xffCCCCCC),
//                                     ),
//                                   ),
//                                   title: Text('익명'),
//                                   subtitle: Text(
//                                     snapshot.data!.docChanges[index]
//                                         .doc['createTime']
//                                         .toString(),
//                                     style: TextStyle(fontSize: 11),
//                                   ),
//                                 );
//                               }),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             width: double.infinity,
//                             child: Text(
//                               snapshot.data!.docChanges[index].doc['title'],
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                               textScaleFactor: 1.4,
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                         ]),
//                       )),
//                 ],
//               );
//             }));
//   }
// }
//
// class NewComment extends StatefulWidget {
//   const NewComment({Key? key}) : super(key: key);
//
//   @override
//   State<NewComment> createState() => _NewCommentState();
// }
//
// class _NewCommentState extends State<NewComment> {
//   final _controller = TextEditingController();
//   String newComment = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//             child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: TextField(
//             controller: _controller,
//             decoration: const InputDecoration(labelText: 'New Message'),
//             onChanged: (value) {
//               setState(() {
//                 newComment = value;
//               });
//             },
//           ),
//         )),
//         IconButton(
//             color: Colors.blue,
//             onPressed: newComment.trim().isEmpty
//                 ? null
//                 : () async {
//                     final currentUser = FirebaseAuth.instance.currentUser;
//                     final currentUserName = await FirebaseFirestore.instance
//                         .collection('user')
//                         .doc(currentUser!.uid)
//                         .get();
//                     FirebaseFirestore.instance.collection('comment').add({
//                       'text': newComment,
//                       'userName': currentUserName.data()!['userName'],
//                       'timestamp': Timestamp.now(),
//                       'uid': currentUser.uid,
//                     });
//                     _controller.clear();
//                   },
//             icon: const Icon(Icons.send)),
//       ],
//     );
//   }
// }
