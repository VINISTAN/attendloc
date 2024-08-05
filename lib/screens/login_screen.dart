import 'package:flutter/material.dart';
import 'package:myapp/screens/location_getter.dart';
import 'package:myapp/widgets/login_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController email_controller = TextEditingController();
  final TextEditingController passwrd_controller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: myheight / 3,
              width: mywidth,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/welcome.png'))),
            ),
            Container(
              height: myheight,
              width: mywidth,
              decoration:  BoxDecoration(
                  color: Colors.orange[300],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40)
                )
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        LoginTextfieldMaterial(
                          obscureText: false,
                          hintText: 'exp@abc.com',
                          labelText: "Email",
                          icon: Icons.mail,
                          controller: email_controller,
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return "Please enter your mail id";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: myheight / 30,
                        ),
                        LoginTextfieldMaterial(
                          obscureText: true,
                          hintText: 'EmpId',
                          labelText: "EmpId",
                          icon: Icons.password,
                          controller: passwrd_controller,
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return "Please enter your Password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: myheight / 30,
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.white),
                            width: mywidth,
                            height: myheight / 15,
                            child: TextButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    print(email_controller.text);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationGetter()));
                                }},
                                child: const Text(
                                  "Sign-in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black87),
                                ))),
                        // SizedBox(
                        //   height: myheight / 25,
                        // ),
                        // Container(
                        //     decoration: const BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(30)),
                        //         color: Colors.white),
                        //     width: mywidth,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [
                        //         Container(
                        //             height: myheight / 15,
                        //             child: ClipRRect(
                        //                 child: Image.asset(
                        //                     'assets/GoogleLogo.png'))),
                        //         const Text(
                        //           "Sign-in with Google",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 20,
                        //               color: Colors.black87),
                        //         ),
                        //       ],
                        //     ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
