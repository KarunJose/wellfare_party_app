import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/providers/bearer_provider.dart';
import 'package:wellfare_party_app/providers/heirarchy_provider.dart';

import '../../MainConst/main_const.dart';
import '../../models/officebearer_list_model.dart';

class AddofficebearerToggleQuestionScreen extends StatefulWidget {
  static const String id = "addofficebearertoggle";
  OfficeBearerListModel? bearer;
  AddofficebearerToggleQuestionScreen({
    Key? key,
    this.bearer,
  }) : super(key: key);

  @override
  State<AddofficebearerToggleQuestionScreen> createState() =>
      _AddofficebearerToggleQuestionScreenState();
}

class _AddofficebearerToggleQuestionScreenState
    extends State<AddofficebearerToggleQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryGreen),
        title: const Text(
          "Add office bearer",
          style: TextStyle(color: primaryGreen, fontSize: 16),
        ),
      ),
      body: Consumer<BearerProvider>(
        builder: (context, bearerprovider, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "ആയോധനകല",
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.ayodhanakala,
                              onChanged: (val) {
                                bearerprovider.setayodhanakala(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.ayodhanakala,
                              onChanged: (val) {
                                bearerprovider.setayodhanakala(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "ഫെയ്സ്ബുക്ക് \nഅക്കൗണ്ട്\nഉണ്ടോ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.facebook,
                              onChanged: (val) {
                                bearerprovider.setfacebook(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.facebook,
                              onChanged: (val) {
                                bearerprovider.setfacebook(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "സ്വന്തമായി\nഎഴുതാറുണ്ടോ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.writer,
                              onChanged: (val) {
                                bearerprovider.setWriter(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.writer,
                              onChanged: (val) {
                                bearerprovider.setWriter(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "ഇന്‍സ്റ്റഗ്രാം\nഅക്കൗണ്ട് ഉണ്ടോ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.instagram,
                              onChanged: (val) {
                                bearerprovider.setinstagram(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.instagram,
                              onChanged: (val) {
                                bearerprovider.setinstagram(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "സജീവമായി\nഇടപെടാറുണ്ടോ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.igactive,
                              onChanged: (val) {
                                bearerprovider.setigactive(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.igactive,
                              onChanged: (val) {
                                bearerprovider.setigactive(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "ട്വിറ്റര്‍\nഅക്കൗണ്ട് ഉണ്ടോ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.twitter,
                              onChanged: (val) {
                                bearerprovider.settwitter(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.twitter,
                              onChanged: (val) {
                                bearerprovider.settwitter(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /////////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "സജീവമായി\nഇടപെടാറുണ്ടോ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.twitteractive,
                              onChanged: (val) {
                                bearerprovider.settwitteractive(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.twitteractive,
                              onChanged: (val) {
                                bearerprovider.settwitteractive(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "പൊതു പ്രഭാഷണം",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.publicspeech,
                              onChanged: (val) {
                                bearerprovider.setpublicspeech(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.publicspeech,
                              onChanged: (val) {
                                bearerprovider.setpublicspeech(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "പഠനക്ലാസ്സ്",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.studyclass,
                              onChanged: (val) {
                                bearerprovider.setstudyclass(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.studyclass,
                              onChanged: (val) {
                                bearerprovider.setstudyclass(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "എഴുത്ത്, കവിത, കഥ",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.poemstory,
                              onChanged: (val) {
                                bearerprovider.setpoemstory(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.poemstory,
                              onChanged: (val) {
                                bearerprovider.setpoemstory(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "മുദ്രാവാക്യം എഴുത്ത്",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.slogan,
                              onChanged: (val) {
                                bearerprovider.setslogan(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.slogan,
                              onChanged: (val) {
                                bearerprovider.setslogan(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "നേതൃശേഷി സംബന്ധിച്ച സ്വയം വിലയിരുത്തല്‍",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              ////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "സേവന മനസ്ഥിതി",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.service,
                              onChanged: (val) {
                                bearerprovider.setservice(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.service,
                              onChanged: (val) {
                                bearerprovider.setservice(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "കൗണ്‍സിലിംങ്,\nതര്‍ക്ക പരിഹാരം/\nമധ്യസ്ഥം വഹിക്കല്‍",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.counselling,
                              onChanged: (val) {
                                bearerprovider.setcounselling(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.counselling,
                              onChanged: (val) {
                                bearerprovider.setcounselling(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "ആളുകളുമായി\nവ്യക്തിബന്ധം ഉണ്ടാക്കല്‍",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.publicrelation,
                              onChanged: (val) {
                                bearerprovider.setpublicrelation(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.publicrelation,
                              onChanged: (val) {
                                bearerprovider.setpublicrelation(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "പുതിയ അവസരങ്ങള്‍\nകണ്ടെത്താനുള്ള കഴിവ്",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.opportunityfinder,
                              onChanged: (val) {
                                bearerprovider.setopportunityfinder(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.opportunityfinder,
                              onChanged: (val) {
                                bearerprovider.setopportunityfinder(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "സംഘാടനം",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.organize,
                              onChanged: (val) {
                                bearerprovider.setorganize(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.organize,
                              onChanged: (val) {
                                bearerprovider.setorganize(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "ടീം വര്‍ക്ക് സാധ്യമാക്കല്‍",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.teamwork,
                              onChanged: (val) {
                                bearerprovider.setteamwork(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.teamwork,
                              onChanged: (val) {
                                bearerprovider.setteamwork(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "സഹ പ്രവര്‍ത്തകര്‍ക്ക്\nപ്രചോദനം നല്‍കല്‍",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Yes"),
                          Radio(
                              value: "Yes",
                              groupValue: bearerprovider.motivation,
                              onChanged: (val) {
                                bearerprovider.setmotivation(val);
                              }),
                          const Text("No"),
                          Radio(
                              value: "No",
                              groupValue: bearerprovider.motivation,
                              onChanged: (val) {
                                bearerprovider.setmotivation(val);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: borderGrayColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // child: Text("dd"),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        dropdownColor: const Color(0xFFFFFFFF),
                        value: bearerprovider.statusDropDown,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        elevation: 16,
                        style: const TextStyle(
                            color: primaryGreyColor,
                            fontWeight: FontWeight.w500),
                        onChanged: (String? newValue) {
                          bearerprovider.selectStatus(newValue);
                        },
                        items: bearerprovider.status
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    // try {
                    var heirarchypov =
                        Provider.of<HeirarchyProvider>(context, listen: false);

                    await bearerprovider.submit(
                      stateDropDownValue: heirarchypov.stateDropDownValue,
                      districtDropdownValue: heirarchypov.districtDropdownValue,
                      constituencyDropdownValue:
                          heirarchypov.constituencyDropdownValue,
                      panchayathDropdownValue:
                          heirarchypov.panchayathDropdownValue,
                      wardDropdownValue: heirarchypov.wardDropdownValue,
                      unitDropdownValue: heirarchypov.unitDropdownValue,
                      id: widget.bearer != null ? widget.bearer!.id : null,
                    );

                    heirarchypov.setInitialData(
                      context: context,
                      all: false,
                      edit: false,
                    );

                    bearerprovider.resetdata();

                    var snackBar =
                        const SnackBar(content: Text('Submitted Successfully'));
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // } catch (ex) {
                    //   var snackBar = const SnackBar(content: Text('Failed'));
                    //   // ignore: use_build_context_synchronously
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: primaryGreen, fixedSize: const Size(150, 40)),
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
