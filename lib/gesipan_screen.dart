import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/LoginPage.dart';
import 'package:flutter_firebase/edit.dart';
import 'write.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('post')
      .orderBy('createTime')
      .snapshots();

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
  final currentUser = FirebaseAuth.instance.currentUser;
  late final _nickname;

 // get isMe => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('게시판'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage() //글 쓰는 페이지로 이동
                    ));
              },
              icon: const Icon(Icons.logout)),


          // 이 항목에 글쓰기
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WritePage() //글 쓰는 페이지로 이동
                      ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      ////////////////////////
      body: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(4),
              reverse: true,  ////
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    if (snapshot.data!.docs[index]['User1']==_nickname){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditPage(docid: snapshot.data!.docs[index]),
                        ),
                      );
                    } else {}
                     },
                  child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.center,
                      height: 100,
                      width: 200,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  snapshot.data!.docChanges[index].doc['title'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot
                                      .data!.docChanges[index].doc['content'],
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data!.docChanges[index]
                                      .doc['createTime'].toString(),
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(1)),
                          ])),
                );
              },
            );
          }),
    );
  }
}
