import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/users/fragments/home_screen.dart';
import 'package:travel_app/users/fragments/note_screen.dart';
import 'package:travel_app/users/fragments/profile_screen.dart';
import 'package:travel_app/users/userPreferences/current_user.dart';

class Dashboard extends StatelessWidget
{
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _FragmentScreens =
  [
    HomeScreen(),
    NoteScreen(),
    ProfileScreen(),
  ];

  List _navigationButtonsProperties =
  [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_max_outlined,
      "label" : "Home",
    },
    {
      "active_icon": Icons.note_alt,
      "non_active_icon": Icons.note_alt_outlined,
      "label" : "Note",
    },
    {
      "active_icon": Icons.note_alt,
      "non_active_icon": Icons.note_alt_outlined,
      "label" : "Note",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outlined,
      "label" : "Profile",
    }
  ];
  RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context)
  {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState)
      {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Obx(
                ()=> _FragmentScreens[_indexNumber.value]
            ),
          ),
          bottomNavigationBar: Obx(
              ()=> BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (value)
                {
                  _indexNumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white24,
                items: List.generate(3, (index)
                {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"],
                  );
                }),
              ),
          ),
        );
      },
    );
  }
}
