import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tes/login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 70,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "A simple android application with\nfirebase authentication",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Hero(
                tag: "button1",
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (b) => LoginPage()));
                      },
                      icon: const Icon(
                        Icons.login,
                        size: 18,
                      ),
                      label: const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Hero(
                tag: "button2",
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20)))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (b) => LoginPage(
                                  isReg: true,
                                )));
                      },
                      icon: const Icon(
                        Icons.app_registration,
                        color: Colors.blue,
                        size: 18,
                      ),
                      label: const Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
