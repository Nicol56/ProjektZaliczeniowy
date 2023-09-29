import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/users/authentication/signup_screen.dart';
import 'package:travel_app/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/users/fragments/dashboard.dart';
import 'package:travel_app/users/model/user.dart';
import 'package:travel_app/users/userPreferences/user_preferences.dart';


class LoginScreen extends StatefulWidget
{


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async
  {
    try
    {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": emailController.text.trim(),
        },
      );
      if(res.statusCode == 200)
      {
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true)
        {
          Fluttertoast.showToast(msg: "You are logged in");
          User userInfo = User.fromJson(resBodyOfLogin["userData"]);
          await RememberUserPrefs.storeUserInfo(userInfo);

          Future.delayed(Duration(microseconds: 1500), ()
          {
            Get.to(Dashboard());
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Email or password incorrect, please try again");
        }
      }
    }
      catch(errorMsg)
    {
      print("Error :: " + errorMsg.toString());
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

                     //login screen header
                     SizedBox(
                       width: MediaQuery.of(context).size.width,
                       height: 285,
                       child: Image.asset(
                         "images/app_photo.jpeg",
                       ),
                     ),

                     //login screen sign-in forms
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
                               color: Colors.black26,
                               offset: Offset(0, -3),
                             )
                           ]
                         ),
                         child: Padding(
                           padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                           child: Column(
                             children: [
                               //email-pass-log button
                               Form(
                                 key: formKey,
                                 child: Column(
                                   children: [
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

                                     // buton
                                     Material(
                                       color: Colors.blueAccent,
                                       borderRadius: BorderRadius.circular(30),
                                       child: InkWell(
                                         onTap: ()
                                         {
                                           if(formKey.currentState!.validate())
                                           {
                                             loginUserNow();
                                           }
                                         },
                                         borderRadius: BorderRadius.circular(30),
                                         child: const Padding(
                                           padding: EdgeInsets.symmetric(
                                             vertical: 10,
                                             horizontal: 28,
                                           ),
                                           child: Text(
                                             "Login",
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
                               SizedBox(height: 16,),
                               //account create button
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   const Text(
                                     "Don't you have an account?",
                                     style: TextStyle(
                                       color: Colors.white60,
                                     ),
                                   ),
                                   TextButton(
                                     onPressed: ()
                                     {
                                       Get.to(SignUpScreen());
                                     },
                                     child: const Text(
                                       "Create",
                                       style: TextStyle(
                                         color: Colors.pinkAccent,
                                         fontSize: 16,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               const Text(
                                 "Or",
                                 style: TextStyle(
                                   color: Colors.blueGrey,
                                   fontSize: 16,
                                 ),
                               ),
                               //are you admin btn
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   const Text(
                                       "Are you an Admin?",
                                     style: TextStyle(
                                       color: Colors.white60,
                                     ),
                                   ),
                                   TextButton(
                                     onPressed: ()
                                     {

                                     },
                                     child: const Text(
                                       "Click here",
                                       style: TextStyle(
                                         color: Colors.pinkAccent,
                                         fontSize: 16,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         )
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
