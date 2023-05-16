import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/AddLoginUsersScreen/add_login_users.dart';

import 'package:wellfare_party_app/Screens/AddMemberScreen/add_member_screen.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/add_office_bearer.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/add_office_bearer_toggle_screen.dart';
import 'package:wellfare_party_app/Screens/AddOfficeBearerScreen/officeBearer/officebearer_list.dart';
import 'package:wellfare_party_app/Screens/Attendence/AttendenceReport/attendence_report.dart';
import 'package:wellfare_party_app/Screens/Attendence/attendence.dart';
import 'package:wellfare_party_app/Screens/LoginUsers/login_users.dart';
import 'package:wellfare_party_app/Screens/MemberManagement/membermanagment.dart';
import 'package:wellfare_party_app/Screens/NotificationScreen/notificationScreen.dart';
import 'package:wellfare_party_app/Screens/ReportData/add_report_screen.dart';
import 'package:wellfare_party_app/Screens/ReportListScreen/report_list_screen.dart';
import 'package:wellfare_party_app/Screens/Reports/office_bearer_report.dart';
import 'package:wellfare_party_app/Screens/Reports/report_search_result.dart';
import 'package:wellfare_party_app/Screens/SignIn/signIn_screen.dart';
import 'package:wellfare_party_app/Screens/SubmittedReportList/submitted_report_list.dart';
import 'package:wellfare_party_app/Screens/member_list/member_list_screen.dart';
import 'package:wellfare_party_app/Screens/messages/AllMessages/all_messages.dart';
import 'package:wellfare_party_app/Screens/messages/AllMessages/singleMessageView.dart';
import 'package:wellfare_party_app/Screens/messages/SendMessages/send_message.dart';
import 'package:wellfare_party_app/providers/attendence_Provider.dart';
import 'package:wellfare_party_app/providers/bearer_provider.dart';
import 'package:wellfare_party_app/providers/constituencyList_provider.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';

import 'package:wellfare_party_app/providers/member_provider.dart';
import 'package:wellfare_party_app/providers/messageProvider.dart';
import 'package:wellfare_party_app/providers/notificationprovider.dart';
import 'package:wellfare_party_app/providers/panchayat_provider.dart';
import 'package:wellfare_party_app/providers/position_provider.dart';
import 'package:wellfare_party_app/providers/questions_provider.dart';
import 'package:wellfare_party_app/providers/report_provider.dart';
import 'package:wellfare_party_app/providers/rootapp_provider.dart';
import 'package:wellfare_party_app/providers/unit_provider.dart';
import 'package:wellfare_party_app/providers/userprovider.dart';
import 'package:wellfare_party_app/providers/userrole_provider.dart';
import 'package:wellfare_party_app/providers/ward_provider.dart';

import 'Screens/Root_app/root_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RootAppProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvder()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => PositionProvider()),
        ChangeNotifierProvider(create: (_) => WardProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => BearerProvider()),
        ChangeNotifierProvider(create: (_) => UserRoleProvider()),
        ChangeNotifierProvider(create: (_) => HeirarchyProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => AttendenceProvider()),
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
        ChangeNotifierProvider(create: (_) => ConstituencyProvider()),
        ChangeNotifierProvider(create: (_) => PanchayatProvider()),
        ChangeNotifierProvider(create: (_) => UnitProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: SignInScreen.id,
        routes: {
          RootApp.id: (context) => const RootApp(),
          SignInScreen.id: (context) => SignInScreen(),
          AddMemberScreen.id: (context) => const AddMemberScreen(),
          NotificationListScreen.id: ((context) => NotificationListScreen()),
          OfficeBearerReport.id: ((context) => OfficeBearerReport(
                reporttype: 'bearer',
              )),
          ReportSearchResult.id: ((context) => const ReportSearchResult()),
          AddOfficeBearer.id: ((context) => AddOfficeBearer()),
          AddofficebearerToggleQuestionScreen.id: (context) =>
              AddofficebearerToggleQuestionScreen(),
          OfficeBearerListScreen.id: (context) => OfficeBearerListScreen(),
          AddLoginUsers.id: (context) => const AddLoginUsers(),
          LoginUsers.id: ((context) => LoginUsers()),
          MemberManagementScreen.id: ((context) => MemberManagementScreen(
              // memberType: "member",
              // show: false,
              )),
          Attendence.id: (context) => Attendence(),
          AttendenceReport.id: (context) => AttendenceReport(),
          SendMessageScreen.id: ((context) => SendMessageScreen()),
          AllMessagesScreen.id: (context) => AllMessagesScreen(),
          AddReport.id: ((context) => AddReport()),
          ReportListScreen.id: ((context) => ReportListScreen()),
          SubmittedReportList.id: (context) => SubmittedReportList(),
        },
        home: const RootApp(),
      ),
    );
  }
}
