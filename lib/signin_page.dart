import 'package:first_app/events.dart';
import 'package:first_app/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  dynamic res;

  Future<void> _performLogin() async {
    String mobile = _mobileController.text.trim();
    String password = _passwordController.text.trim();

    if (mobile.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid number");
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
    });

    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/login",
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
          builder: (context) => Events(

            // response.data['user'] == null ? "" : response.data['user']
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
      body:

      SingleChildScrollView(
        child:
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                    color: Color(0xFF2E3748),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 19,
              ),
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _mobileController,
                      cursorColor: Color(0xFFFF8701),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Number",
                        labelStyle: TextStyle(
                            color: Color(0xFFFF8701),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
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
                      controller: _passwordController,
                      obscureText: hidepassword,
                      cursorColor: Color(0xFFFF8701),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            "Forget Password?",
                            style:
                            TextStyle(color: Color(0xFF9FA5BB), fontSize: 12),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (_loading)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      InkWell(
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
                            onTap: (){
                              _performLogin();
                            },
                            child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ),
                    //if (res != null) Text("${res['user']}"),

                    SizedBox(
                      height: 19,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUp(
                              // user: response.data['user'] ??
                              //   "",
                              // response.data['user'] == null ? "" : response.data['user']
                            ),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: ' Don’t have an account? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9FA5BB),
                                  fontSize: 15)),
                          TextSpan(
                              text: ' Sign up ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF8701),
                                  fontSize: 15)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Text(
                    "-Or sign in withFringerprint-",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1E2C40),
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 30,),
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/fingerprint.png"),
                    //   fit: BoxFit.fill,
                    // ),
                      shape: BoxShape.circle,
                      color: Color(0xFFFF8701),
                      boxShadow: [BoxShadow(
                        offset: Offset(0,3),
                        blurRadius: 6,
                        color: Color(0x5CFF8701),
                      )]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Image(image: AssetImage("assets/images/fingerprint.png"),color: Colors.white,),
                  ),
                ),
              )
            ],
          ),
        ),


      ),
    );
  }
}



