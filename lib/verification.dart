import 'package:first_app/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class Verification extends StatefulWidget {
  Verification({this.user});

  final String user;

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _otpController = TextEditingController();
  // final _passwordController = TextEditingController();

  bool _loading = false;

  dynamic res;

  Future<void> _performLogin() async {
    String otp = _otpController.text.trim();
    //String password = _passwordController.text.trim();

    if (otp.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid otp");
      return;
    }
    // if (password.isEmpty) {
    //   Fluttertoast.showToast(msg: "Invalid password");
    //   return;
    // }

    setState(() {
      _loading = true;
    });
    // Map<String, dynamic> postData = {
    //   "username": username,
    //   "password": password,
    // };
    FormData formData = FormData.fromMap({
      "otp": otp,
      //"password": password,
    });

    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/otp/validate",
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


          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: response.data['message']);
      print(response.data['message']);
    }
    print(res);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                    "Verification",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3748)),
                  )),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                    "6 - Digit PIN has been sent to your phone, enter it below to continue.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9FA5BB)),
                  )),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                cursorHeight: 20,
                controller: _otpController,
                cursorColor: Color(0xFFFF8701),
                decoration: InputDecoration(
                  hintText: 'Enter Otp',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Color(0xFFE3EAF2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF8701)),
                  ),
                ),
                //color: Color(0xFFFF8701),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Otp(  ),
              //     Otp(),
              //     Otp(),
              //     Otp(),
              //     Otp(),
              //
              //   ],
              // ),
              SizedBox(
                height: 50,
              ),
              if (_loading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else

                Container(
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
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => CurrentEvents(
                      //     ),
                      //   ),
                      // );
                    },
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),







            ],
          ),
        ));
  }
}

// class Otp extends StatefulWidget {
//   const Otp({
//   this.otpController,
//     Key key,
//   }) : super(key: key);
//   final TextEditingController otpController;
//   @override
//   _OtpState createState() => _OtpState();
// }
//
// class _OtpState extends State<Otp> {
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         TextField(),
//     //   Container(
//     //   height: 50,
//     //   width: 50,
//     //   child: TextFormField(
//     //     controller: widget.otpController,
//     //     textAlign: TextAlign.center,
//     //     keyboardType: TextInputType.number,
//     //     cursorColor: Color(0xFFFF8701),
//     //     decoration: InputDecoration(
//     //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     //       focusedBorder: OutlineInputBorder(
//     //         borderRadius: BorderRadius.circular(10.0),
//     //         borderSide: BorderSide(
//     //           color: Color(0xFFFF8701),
//     //           width: 2,
//     //         ),
//     //       ),
//     //       enabledBorder: OutlineInputBorder(
//     //         borderRadius: BorderRadius.circular(10.0),
//     //         borderSide: BorderSide(
//     //           color: Color(0xFFE3EAF2),
//     //           //color: Color(0xFFFF8701),
//     //           width: 2,
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }
