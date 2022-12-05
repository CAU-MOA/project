import 'package:flutter/material.dart';
void showAlertDialogContent(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('내용을 입력해주십시오'),
          ],
        ),
        //content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
        actions: <Widget>[

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('돌아가기',
                    textAlign: TextAlign.center,),
                  onPressed: () {
                    Navigator.pop(context, "돌아가기");
                  },
                ),
              ]
          ),

        ],
      );
    },
  );
}


