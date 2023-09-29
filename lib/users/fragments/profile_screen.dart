import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/users/authentication/login_screen.dart';
import 'package:travel_app/users/userPreferences/current_user.dart';
import 'package:travel_app/users/userPreferences/user_preferences.dart';

class ProfileScreen extends StatelessWidget
{
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async
  {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Logout user",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        content: const Text(
          "Are you sure you want to logout?"
        ),
        actions: [
          TextButton(
              onPressed: ()
              {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
          ),
          TextButton(
            onPressed: ()
            {
              Get.back(result: "You are logged out");
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );

    if(resultResponse == "LoggedOut")
      {
        RememberUserPrefs.removeUserInfo()
            .then((value)
        {
          Get.off(LoginScreen());
        });
      }
  }

  Widget userInfoItemProfile(IconData iconData, String userData)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black12,
          ),
          const SizedBox(width: 18,),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          userInfoItemProfile(Icons.person, _currentUser.user.user_name),
          const SizedBox(width: 18,),
          userInfoItemProfile(Icons.email, "useremail@gmail.com"),
          const SizedBox(width: 18,),
          Center(
            child: Material(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: ()
                {
                  signOutUser();
                },
                borderRadius: BorderRadius.circular(28),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 10,
                  ),
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
     padding: const EdgeInsets.all(30),
     children: [

       Center(
         child: Image.asset(
           "images/reginstration_photo.jpeg",
           width: 200,

         ),
       ),
       SizedBox(height: 30,),

     ],
    );
  }
}