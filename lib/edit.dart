import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'gesipan_screen.dart';
import 'title_alert.dart';
import 'content_alert.dart';

class EditPage extends StatefulWidget {
  DocumentSnapshot docid;
  EditPage({required this.docid});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState(){
    title = TextEditingController(text: widget.docid.get('title'));
    content = TextEditingController(text: widget.docid.get('content'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('글 수정'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                showAlertDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: (){
                if(content.text.isEmpty){
                  return showAlertDialogContent(context);
                }
                else if(title.text.isEmpty){
                  return showAlertDialogTitle(context);
                }
                else {
                  widget.docid.reference.update({
                    'title': title.text,  //.text 필요
                    'content': content.text,
                  }).whenComplete(() {
                    //Navigator.of(context).pop();
                     Navigator.pushReplacement(
                         context, MaterialPageRoute(builder: (context) => HomePage()));

                  });
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
              maxLines: null,
              controller: content,
              decoration: const InputDecoration(
                labelText: '내용',
              ),
            ),
          ],
        ),
      )
    );
  }



  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
          actions: <Widget>[
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                widget.docid.reference.delete().whenComplete(() {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                });
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }
}

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String newMessage = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'New Message'),
                onChanged: (value) {
                  setState(() {
                    newMessage = value;
                  });
                },
              ),
            )),
        IconButton(
            color: Colors.blue,
            onPressed: newMessage.trim().isEmpty
                ? null
                : () async {
              final currentUser = FirebaseAuth.instance.currentUser;
              final currentUserName = await FirebaseFirestore.instance
                  .collection('user')
                  .doc(currentUser!.uid)
                  .get();
              FirebaseFirestore.instance.collection('post').add({
                'comment': newMessage,
                'comentUser': currentUserName.data()!['userName'],
                'timestamp': Timestamp.now(),
                //'uid': currentUser.uid,
              });
              _controller.clear();
            },
            icon: const Icon(Icons.send)),
      ],
    );
  }
}
