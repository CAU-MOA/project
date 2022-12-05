import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Register.Page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showSpinner = false;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        final currentUser =
                        await _authentication.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (currentUser.user != null) {
                          _formKey.currentState!.reset();
                          if (!mounted) return;
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Enter')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('If you did not register, '),
                    TextButton(
                      child: const Text('Register your email.'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}


/////////////////////////////////////
/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Register.Page.dart';
import 'ChatPage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showSpinner = false;
  final _authentication = FirebaseAuth.instance; // firebase와 연동
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password ='';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner, // 스피너는 엔터를 누룬 직후부터 로그인이 될 때까지 표시
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onChanged:(value){
                  email= value;
                  //print(email);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,  // password를 숨겨준다.
                decoration: const InputDecoration(
                    labelText: 'Password',
                ),
                onChanged:(value){
                  password= value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      final currentUser =
                          await _authentication.signInWithEmailAndPassword(
                              email:email,password:password);
                      if (currentUser.user != null){
                        _formKey.currentState!.reset();
                        if (!mounted) return;
                        //Navigator.push(
                          //  context,
                            //MaterialPageRoute(
                              //  builder: (context) => const ChatPage()));
                        setState(() {
                          showSpinner = false;  // 스피너 끝
                        });
                      }
                    } catch(e) {
                      print(e);
                    }
                  },
                  child: const Text('Enter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('If you not register,'),
                  TextButton(
                      child: const Text('Register your email.'),
                      onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                      },
                  )
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}


 */