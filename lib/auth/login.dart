import 'package:cash_connect/auth/reset_password.dart';
import 'package:cash_connect/auth/sign_up.dart';
import 'package:flutter/material.dart';

import '../models/auth/login_req_model.dart';
import '../screens/main_page.dart';
import '../services/api_services/api_services.dart';
import '../utilities/custom_flat_button.dart';
import '../utilities/services.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _phoneNumberTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  String? phoneNumber;
  String? password;
  Icon? icon;
  bool _visible = false;
  // bool _loading = false;
  bool isApiCall = false;

  @override
  Widget build(BuildContext context) {
    // final _authData = Provider.of<AuthProvider>(context);
    Services services = Services();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    services.logo(45, null),
                    services.sizedBox(h: 60),
                    Container(
                      child: TextFormField(
                          controller: _phoneNumberTextController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }

                            setState(() {
                              phoneNumber = _phoneNumberTextController.text;
                            });
                            return null;
                          },
                          decoration: const InputDecoration(
                            // enabledBorder: OutlineInputBorder(),
                            // contentPadding: EdgeInsets.zero,
                            hintText: 'Phone Number',
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.blueGrey,
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 2),
                            ),
                            focusColor: Colors.blueGrey,
                          )),
                    ),
                    services.sizedBox(h: 20),
                    Container(
                      child: TextFormField(
                        controller: _passwordTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length <= 6) {
                            return 'Password must be more than six characters';
                          }
                          setState(() {
                            password = _passwordTextController.text;
                          });
                          return null;
                        },
                        obscureText: _visible == true ? false : true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: _visible
                                ? const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.blueGrey,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.blueGrey,
                                  ),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            },
                          ),
                          // enabledBorder: OutlineInputBorder(),
                          // contentPadding: EdgeInsets.zero,
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.vpn_key_outlined,
                            color: Colors.blueGrey,
                          ),
                          labelStyle: const TextStyle(color: Colors.black),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              )),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 2),
                          ),
                          focusColor: Colors.blueGrey,
                        ),
                      ),
                    ),
                    services.sizedBox(h: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ResetPassword.id);
                          },
                          child: const Text('Forgot Password? ',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    services.sizedBox(h: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 35),
                      child: isApiCall
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blueGrey),
                              // backgroundColor: Colors.transparent,
                            )
                          : CustomFlatButton(
                              label: "Login",
                              labelStyle: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              onPressed: () {
                                if (validateAndSave()) {
                                  setState(() {
                                    isApiCall = true;
                                  });

                                  LoginReqModel model = LoginReqModel(
                                    phoneNumber:
                                        _phoneNumberTextController.text,
                                    password: _passwordTextController.text,
                                  );

                                  APIService.login(model).then((res) {
                                    setState(() {
                                      isApiCall = false;
                                    });
                                    if (res) {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          MainScreen.id, (route) => false);
                                    } else {
                                      services.scaffold(
                                          message: 'Invalid login credentials',
                                          context: context);
                                    }
                                  });
                                }
                              },
                              borderRadius: 30,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: RichText(
                            text: const TextSpan(text: '', children: [
                              TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                text: 'Create an account',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ]),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Signup.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
