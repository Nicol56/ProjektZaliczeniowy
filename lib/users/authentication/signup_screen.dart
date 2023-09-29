import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_app/api_connection/api_connection.dart';
import 'package:travel_app/users/authentication/login_screen.dart';
import 'package:travel_app/users/model/user.dart';
import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget
{


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async
  {
    try
    {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_mail': emailController.text.trim(),
        },
      );

      if(res.statusCode == 200) // con with api - suc
      {
        var resBodyOfValidateEmail = jsonDecode(res.body);
        if (resBodyOfValidateEmail['emailFound'] == true)
        {
          Fluttertoast.showToast(msg: "Existing email. Try another email address.");
        }
        else
        {
        //register and new record user to db
          registerAndSaveUserRecord();
        }
      }
    }
    catch(e)
    {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveUserRecord() async
  {
    User userModel = User(
      1,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try
    {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );
      if(res.statusCode == 200)
      {
        var resBodyOfSignUp = jsonDecode(res.body);
        if(resBodyOfSignUp['success'] == true)
        {
          Fluttertoast.showToast(msg: "Account created successfully");
        }
        else
        {
          Fluttertoast.showToast(msg: "Could not create the account, please try again");
        }
      }
    }
    catch(e)
    {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg:e.toString());
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
          builder: (context, cons)
          {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: cons.maxHeight,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    //create ac screen header
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 285,
                      child: Image.asset(
                        "images/app_photo.jpeg",
                      ),
                    ),

                    //create ac screen sign-up form
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black,
                                  offset: Offset(0, -3),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                            child: Column(
                              children: [
                                //name email-pass-log button || create btn
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [

                                      // your name
                                      TextFormField(
                                        controller: nameController,
                                        validator: (val) => val == "" ? "Please write your name" : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.blue,
                                          ),
                                          hintText: "your name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),

                                      ),

                                      const SizedBox(height: 18,),

                                      //email
                                      TextFormField(
                                        controller: emailController,
                                        validator: (val) => val == "" ? "Please write an email address" : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            color: Colors.blue,
                                          ),
                                          hintText: "email address",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),

                                      ),

                                      const SizedBox(height: 18,),

                                      //password
                                      Obx(
                                            ()=> TextFormField(
                                          controller: passwordController,
                                          obscureText: isObsecure.value,
                                          validator: (val) => val == "" ? "Please write password" : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Colors.blue,
                                            ),
                                            suffixIcon: Obx(
                                                  ()=> GestureDetector(
                                                onTap: ()
                                                {
                                                  isObsecure.value = !isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                                  color: Colors.blue,
                                                ),

                                              ),
                                            ),
                                            hintText: "password",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(60),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(60),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(60),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(60),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 6,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),

                                        ),


                                      ),

                                      const SizedBox(height: 18,),

                                      // button
                                      Material(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          onTap: ()
                                          {
                                            if(formKey.currentState!.validate())
                                              {
                                                //validate email
                                                validateUserEmail();
                                              }
                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 28,
                                            ),
                                            child: Text(
                                              "Create account",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                //already registered button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "Already have an account?",
                                      style: TextStyle(
                                        color: Colors.white60,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: ()
                                      {
                                        Get.to(LoginScreen());
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
