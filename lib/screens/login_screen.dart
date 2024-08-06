import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/screens/location_getter.dart';
import 'package:myapp/widgets/login_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController empid_controller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late Box employeeBox;

  // Emp Id Validator
  String? _validateEmployeeId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Employee ID is required';
    }
    if (value.length != 5) {
      return 'Employee ID must be exactly 5 digits long';
    }
    if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return 'Employee ID must be a number';
    }
    return null;
  }

  //Save EmpId to Local Hive DB
  void _saveEmpId(String id) {
    employeeBox.put('EmployeeId', id);
    print('inside save function : $id');
  }

  void initState() {
    super.initState();
    openHive();
    employeeBox = Hive.box('employeeBox');
    empid_controller.text = employeeBox.get('EmployeeId', defaultValue: '');
  }
  void openHive()async{
    await Hive.openBox('employeeBox');
  }

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
              decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        LoginTextfieldMaterial(
                            obscureText: false,
                            hintText: '5 Digit Emp Id',
                            labelText: "Emp id",
                            icon: Icons.key,
                            keyboardtype: TextInputType.number,
                            controller: empid_controller,
                            validator: _validateEmployeeId),
                        SizedBox(
                          height: myheight / 30,
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
                                    print(empid_controller.text);
                                    _saveEmpId(empid_controller.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocationGetter()));
                                  }
                                },
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
