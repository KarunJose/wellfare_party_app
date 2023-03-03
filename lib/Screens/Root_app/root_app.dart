// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/AddLoginUsersScreen/add_login_users.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/add_office_bearer.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/officeBearer/officebearer_list.dart';
import 'package:wellfare_party_app/Screens/Attendence/AttendenceReport/attendence_report.dart';
import 'package:wellfare_party_app/Screens/Attendence/attendence.dart';
import 'package:wellfare_party_app/Screens/LoginUsers/login_users.dart';
import 'package:wellfare_party_app/Screens/MemberManagement/membermanagment.dart';
import 'package:wellfare_party_app/Screens/NotificationScreen/notificationScreen.dart';
import 'package:wellfare_party_app/Screens/Reports/office_bearer_report.dart';
import 'package:wellfare_party_app/Screens/SignIn/signIn_screen.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';

import '../../commonComponents/appbar.dart';
import '../../providers/rootapp_provider.dart';
import '../HomeScreen/homeTab.dart';

class RootApp extends StatefulWidget {
  static const String id = "RootApp";
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _selectedIndex = 0;

  List<String> routes = [
    HomeTab.id,
    Attendence.id,
    HomeTab.id,
    HomeTab.id,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<RootAppProvider>(
      builder: (context, rootAppProvier, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
            child: ListView(
              children: [
                // DrawerHeader(
                //     child: Column(
                //   children: [
                //     Container(
                //       height: 100,
                //       width: 100,
                //       child: Image.asset("assets/images/logo.png"),
                //       decoration: const BoxDecoration(
                //           color: Colors.white, shape: BoxShape.circle),
                //     ),
                //     Text("Welfare Party of India")
                //   ],
                // )),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/svgicons/grid.svg"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "DashBoard",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textGreenColor),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Active Data",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {},
                    title: const Text(
                      "Monthly Report",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {},
                    title: const Text(
                      "Quarterly Report",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {},
                    title: const Text(
                      "Special Report",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Units",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {},
                    title: const Text(
                      "About Unit",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {
                      Navigator.pushNamed(context, MemberManagementScreen.id);
                    },
                    title: const Text(
                      "Member Management",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {
                      Navigator.pushNamed(context, LoginUsers.id);
                    },
                    title: const Text(
                      "App Admin Managment",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {
                      Navigator.pushNamed(context, OfficeBearerListScreen.id);
                    },
                    title: const Text(
                      "Office bearers",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, NotificationListScreen.id);
                //   },
                //   title: const Text(
                //     "Notifications &\nInformations",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),
                // ExpansionTile(
                //   // ignore: sort_child_properties_last
                //   children: [
                //     ListTile(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => OfficeBearerReport(
                //                       reporttype: 'bearer',
                //                     )));
                //       },
                //       title: Text(
                //         "Office Bearer Report",
                //         style: TextStyle(fontSize: 15),
                //       ),
                //     ),
                //     ListTile(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => OfficeBearerReport(
                //                       reporttype: 'subcommittee',
                //                     )));
                //       },
                //       title: Text(
                //         "Office Bearer Subcommittee Report",
                //         style: TextStyle(fontSize: 15),
                //       ),
                //     ),
                //   ],
                //   title: const Text("Reports"),
                // ),
                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, AddOfficeBearer.id);
                //   },
                //   leading: const Icon(
                //     Icons.backup_table_rounded,
                //     color: primaryGreen,
                //   ),
                //   title: const Text(
                //     "Add office bearer",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),

                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, AddLoginUsers.id);
                //   },
                //   leading: const Icon(
                //     Icons.backup_table_rounded,
                //     color: primaryGreen,
                //   ),
                //   title: const Text(
                //     "Add login users",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Reports",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    onTap: () {
                      Navigator.pushNamed(context, AttendenceReport.id);
                    },
                    title: const Text(
                      "Attendence report",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                // ListTile(
                //   onTap: () {},
                //   title: const Text(
                //     "Projects",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),
                // ListTile(
                //   onTap: () {},
                //   title: const Text(
                //     "Attendence",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),
                // ListTile(
                //   onTap: () {},
                //   title: const Text(
                //     "Inbox",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "User",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: const Text(
                      "Change password",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () async {
                      // await Provider.of<UserProvider>(context, listen: false)
                      //     .logout();
                      // // ignore: use_build_context_synchronously
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, SignInScreen.id, (route) => false);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () async {
                      await Provider.of<UserProvider>(context, listen: false)
                          .logout();
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignInScreen.id, (route) => false);
                    },
                  ),
                )
              ],
            ),
          ),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: getAppbar(rootAppProvier.pageId)),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Attendence',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.backup_table_rounded),
                label: 'Projects',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'User',
              ),
            ],
            unselectedItemColor: primaryGreyColor,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            selectedItemColor: primaryGreen,
            onTap: (index) {
              if (index == 1) {
                Navigator.pushNamed(context, Attendence.id);
                return;
              }
              setState(() {
                _selectedIndex = index;
              });

              rootAppProvier.selectTab(routes[index]);
            },
          ),
          body: getbody(rootAppProvier.pageId),
        ),
      ),
    );
  }

  Widget getbody(String pageId) {
    // return HomeTab();
    switch (pageId) {
      case HomeTab.id:
        return HomeTab();

      case Attendence.id:
        return Attendence();
      default:
        return Container();
    }
  }
}
