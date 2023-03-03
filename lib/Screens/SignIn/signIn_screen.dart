import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/HomeScreen/homeTab.dart';
import 'package:wellfare_party_app/Screens/Root_app/root_app.dart';
import 'package:wellfare_party_app/providers/rootapp_provider.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "signin";
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showpassword = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getInitialDetails();
  }

  _getInitialDetails() async {
    final prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString("user_id");
    var role = prefs.getString("role_name");

    if (userId != null) {
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setRole(role!);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (builder) => const RootApp(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Consumer2<RootAppProvider, UserProvider>(
          builder: (context, rootAppProvider, userProvider, child) =>
              SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height / 8,
                    left: (MediaQuery.of(context).size.width / 2) - 60,
                    child: Container(
                      width: 120,
                      height: 120,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff3C7252),
                              Color(0xff44C576),
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: (MediaQuery.of(context).size.height * 48) / 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 0,
                              color: primaryGreen.withOpacity(0.5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 23, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: textGreenColor,
                                    ),
                                  ),
                                  Container(
                                    height: 4,
                                    width: 44,
                                    decoration: BoxDecoration(
                                        color: primaryRed,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                spreadRadius: 2,
                                                color: Colors.grey.shade100),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: TextField(
                                            controller: usernameController,
                                            cursorColor: primaryGreen,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: const Icon(
                                                  Icons.phone_android_outlined,
                                                  color: primaryGreen,
                                                ),
                                                hintText: "Username",
                                                hintStyle: TextStyle(
                                                    color: primaryGreyColor
                                                        .withOpacity(0.7))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                spreadRadius: 2,
                                                color: Colors.grey.shade100),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: TextField(
                                            controller: passwordController,
                                            obscureText: !showpassword,
                                            cursorColor: primaryGreen,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                                color: primaryGreen,
                                              ),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showpassword =
                                                        !showpassword;
                                                  });
                                                },
                                                child: Icon(
                                                  showpassword == true
                                                      ? Icons.visibility
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color: primaryGreyColor,
                                                ),
                                              ),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                color: primaryGreyColor
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (userProvider.error == true)
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Incorrect username or password",
                                            style: TextStyle(color: primaryRed),
                                          ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (userProvider.loading == true)
                                const Center(child: CircularProgressIndicator())
                              else
                                Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: primaryRed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        fixedSize: Size(
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                            45),
                                      ),
                                      onPressed: () async {
                                        bool error = await userProvider.signIn(
                                          usernameController.text,
                                          passwordController.text,
                                        );
                                        if (error == false) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (builder) =>
                                                  const RootApp(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/icons/152533.png",
                                        width: 25,
                                        height: 35,
                                      )),
                                ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Center(child: Text("Forgot password")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
