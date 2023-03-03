import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/AddLoginUsersScreen/add_login_users.dart';
import 'package:wellfare_party_app/Screens/LoginUsers/components/app_admin_card.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/loginUserModel.dart';
import 'package:wellfare_party_app/providers/userrole_provider.dart';

import '../../MainConst/main_const.dart';

class LoginUsers extends StatefulWidget {
  static const String id = "loginusers";
  LoginUsers({Key? key}) : super(key: key);

  @override
  State<LoginUsers> createState() => _LoginUsersState();
}

class _LoginUsersState extends State<LoginUsers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() {
    Provider.of<UserRoleProvider>(context, listen: false).getLoginUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 40.0,
        width: 40.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: textGreenColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddLoginUsers.id);
            },
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "App Admin",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Consumer<UserRoleProvider>(
        builder: (context, userroleprovider, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (userroleprovider.loading == true)
                  const Center(child: WaveLoader()),
                for (LoginUserModel loginUser in userroleprovider.loginUsers)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => AddLoginUsers(
                            edit: true,
                            loginuser: loginUser,
                          ),
                        ),
                      );
                    },
                    child: AppAdminCard(loginuserList: loginUser),
                  ),

                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           width: MediaQuery.of(context).size.width,
                //           child: Text(
                //             "Name : ${loginUser.name}",
                //             style: const TextStyle(
                //                 fontSize: 15, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         // Text(
                //         //   "Username : ${loginUser.username}",
                //         //   style: const TextStyle(
                //         //     fontSize: 14,
                //         //   ),
                //         // ),

                //         Text("Phone : ${loginUser.phone}"),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text("Role : ${loginUser.role}"),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
