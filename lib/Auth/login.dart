
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooton/sizeconfig.dart';

class signin extends StatefulWidget {

  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {

  String? email = "";
  String? pasword = "";

  bool obscure_text = true;
  bool _autovalidate = true;

  final _formKey = GlobalKey<FormState>();

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: pasword!,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password is too week";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exist for that email";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }


  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            content: Container(
              child: Text(
                error,
                style: TextStyle(color: Colors.black,fontSize: SizeConfig.height!*2.5),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  void _submitform() async {
    String? feedback = await _loginAccount();
    if (feedback != null) {
      _alertDialogBox(feedback);
    } else {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff04171B),
        appBar: AppBar(
          backgroundColor: Color(0xff04171B),
        ),
        body: Container(
          height: SizeConfig.height! * 70,
          child: Column(
            children: [
              Expanded(
                child:Container(
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.jpg"),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
              Expanded(
                child:Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 5),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome To,",style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 32,
                      ),),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Login With",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16,
                      ),),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child:Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                              padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                              height: SizeConfig.height! * 4,
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.5,color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                                ),
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty && value == "") {
                                      return "Email should not be left empty";
                                    }
                                    return null;
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration:
                                  InputDecoration(
                                      hintText: "Email",
                                      errorMaxLines: 1,
                                      prefixIcon: Icon(Icons.mail,size: SizeConfig.height! * 3,),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: SizeConfig.height! * 2.3,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  style: GoogleFonts.poppins(
                                      fontSize: SizeConfig.height! * 2,
                                      color: Colors.black),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: SizeConfig.height! * 2,),
                        Expanded(
                          child: Container(
                            height: SizeConfig.height! * 4,
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.white),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    pasword = val;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Password should not be left empty";
                                  }
                                  return null;
                                },
                                obscureText: obscure_text,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: SizeConfig.height! * 2.3,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                    errorMaxLines: 1,
                                    prefixIcon: Icon(Icons.lock,size: SizeConfig.height! * 3,),
                                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscure_text = !obscure_text;
                                        });
                                      },
                                      icon: Icon(obscure_text
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      color: Colors.blue,
                                    ),
                                    border: InputBorder.none),
                                style: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: SizeConfig.height! * 1,)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                //flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      //_submitform();
                      if (!_formKey.currentState!.validate()) {
                        setState(() {
                          _autovalidate = true;
                        });
                        _alertDialogBox("No field should be left Empty");
                      } else {
                        setState(() {
                          _autovalidate = false;
                        });
                        _submitform();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: SizeConfig.height! * 6,
                      width: SizeConfig.width! * 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: Text("Sign In",style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
