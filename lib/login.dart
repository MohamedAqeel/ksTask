// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tes/home.dart';
import 'package:tes/utils.dart';

class LoginPage extends StatefulWidget {
  bool isReg = false;
  LoginPage({this.isReg = false, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  handleAuth() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    UserCredential? cred;

    if (widget.isReg) {
      cred = await register();
    } else {
      cred = await login();
    }

    if (cred != null) {
      log(cred.user!.email!);
      email.clear();
      password.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (b) => const HomePage()));
    }
  }

  login() async {
    try {
      showLoader();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      popLoader();
      showToast("Login successfull");
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast('Wrong password provided for that user.');
      }
    } catch (e) {
      showToast("Error in authentication");
      log(e.toString());
    }
    popLoader();
  }

  register() async {
    try {
      showLoader();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      popLoader();
      showToast("Registration successfull");
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      }
    } catch (e) {
      showToast("Error in authentication");
      log(e.toString());
    }
    popLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isReg ? "Register" : "Login",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (!value!.contains("@") || !value.contains(".")) {
                      return "Enter a valid email address";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your email address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a password";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                const SizedBox(
                  height: 25,
                ),
                Hero(
                  tag: widget.isReg ? "button2" : "button1",
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        onPressed: handleAuth,
                        icon: Icon(
                          widget.isReg ? Icons.app_registration : Icons.login,
                          size: 18,
                        ),
                        label: Text(
                          widget.isReg ? "REGISTER" : "LOGIN",
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
