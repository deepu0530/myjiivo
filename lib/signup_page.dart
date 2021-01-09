import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:first_app/verification.dart';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  bool _loading = false;

  dynamic res;

  Future<void> _performLogin() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String mobile = _mobileController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid Name");
      return;
    }
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid E-mail");
      return;
    }
    if (mobile.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid Number");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid password");
      return;
    }
    mobile = "+91$mobile";
    setState(() {
      _loading = true;
    });
    // Map<String, dynamic> postData = {
    //   "username": username,
    //   "password": password,
    // };
    FormData formData = FormData.fromMap({
      "mobile": mobile,
      "password": password,
      "email": email,
      "name": name,
    });

    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/signup",
        data: formData,
        options: Options(
          validateStatus: (status) => status < 500,
        ));

    setState(() {
      res = response.data;
      _loading = false;
    });
    if (response.data['status']) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Verification(
            // user: response.data['user'] ??
            //     "", // response.data['user'] == null ? "" : response.data['user']
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: response.data['message']);
      print(response.data['message']);
    }
    print(res);
  }

  bool hidepassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Color(0xFF2E3748),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 19,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    cursorColor: Color(0xFFFF8701),
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Name",
                      labelStyle: TextStyle(
                          color: Color(0xFFFF8701),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      // prefixText: "+91",
                      // prefixStyle:
                      // TextStyle(color: Color(0xFF2E3748), fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFE3EAF2),
                          //color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Color(0xFFFF8701),
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                          color: Color(0xFFFF8701),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      // prefixText: "+91",
                      // prefixStyle:
                      // TextStyle(color: Color(0xFF2E3748), fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFE3EAF2),
                          //color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  // Form(
                  //   child: Column(
                  //     children: [
                  //       TextFormField(
                  //         decoration: InputDecoration(
                  //           f
                  //           labelText: "hai",
                  //           hintText: "hello",
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      labelText: "Number",
                      labelStyle: TextStyle(
                          color: Color(0xFFFF8701),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      // prefixIcon:
                      // IconButton(icon: Icon(Icons.keyboard_arrow_down,color: Color(0xFF9FA5BB),), onPressed: (){}),

                      prefixText: "+91",
                      prefixStyle:
                      TextStyle(color: Color(0xFF2E3748), fontSize: 14),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFE3EAF2),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: hidepassword,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFE3EAF2),
                          width: 2,
                        ),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Color(0xFFFF8701),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      suffixIcon: IconButton(
                          color: Color(0xFF9FA5BB),
                          onPressed: () {
                            setState(() {
                              hidepassword = !hidepassword;
                            });
                          },
                          icon: Icon(hidepassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
              if (_loading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                InkWell(
                  // onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFF8701),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              color: Color(0x333B83FC))
                        ]),
                    height: 50,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        _performLogin();
                      },
                      child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
              SizedBox(
                height: 39,
              ),
              Center(
                  child: Text(
                    "-OR-",
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 19,
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xFFE3EAF2)),
                  //image: DecorationImage(image: AssetImage("assets/images/google1.png"))
                ),
                // Image(image: AssetImage("assets/images/google.png"),height: 10,width: 30,),

                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Image(image: AssetImage("assets/images/google.png"),height: 20,width: 20),
                    SizedBox(width: 20,),
                    Text(
                      "Sign Up with Google",
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
