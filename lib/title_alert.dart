import 'package:flutter/material.dart';

void showAlertDialogTitle(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('제목을 입력해주십시오'),
          ],
        ),
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
