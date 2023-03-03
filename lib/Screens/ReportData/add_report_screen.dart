import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/ReportData/components/single_column_field.dart';
import 'package:wellfare_party_app/Screens/ReportData/const.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/qa_model.dart';
import 'package:wellfare_party_app/models/qustionnaire_model.dart';
import 'package:wellfare_party_app/providers/questions_provider.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

import 'components/dipartment_section.dart';
import 'components/multiple_column_section.dart';

class AddReport extends StatefulWidget {
  static const String id = "addreport";
  QAmodel? qAmodel;
  bool edit;
  bool draft;

  AddReport({
    this.qAmodel,
    this.draft = false,
    this.edit = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  List<Map<String, dynamic>> mainQuestionAnswers = [];
  List<Map<String, dynamic>> subQuestionAnswers = [];

  List<Map<String, dynamic>> editedMainQuestionAnswers = [];
  List<Map<String, dynamic>> editedSubQuestionAnswers = [];

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    var qpov = Provider.of<QuestionsProvider>(context, listen: false);

    if (widget.edit == false) {
      await qpov.getQuestionsList();
    } else {
      await qpov.setQA(widget.qAmodel!.reports);

      //
      setState(() {
        for (int rindex = 0;
            rindex < widget.qAmodel!.reports.length;
            rindex++) {
          mainQuestionAnswers.add({});
          subQuestionAnswers.add({});
          editedMainQuestionAnswers.add({});
          editedSubQuestionAnswers.add({});
          for (var question in widget.qAmodel!.reports[rindex].mainQuestions) {
            if (question.questionTypeName == multipleColumnType) {
              if (question.male!.isNotEmpty) {
                if (mainQuestionAnswers[rindex][question.id] == null) {
                  mainQuestionAnswers[rindex]
                      [question.id] = {'male': question.male};
                } else {
                  mainQuestionAnswers[rindex][question.id]['male'] =
                      question.male;
                }
              } else if (question.female!.isNotEmpty) {
                if (mainQuestionAnswers[rindex][question.id] == null) {
                  mainQuestionAnswers[rindex]
                      [question.id] = {'female': question.female};
                } else {
                  mainQuestionAnswers[rindex][question.id]['female'] =
                      question.female;
                }
              }
              if (question.total!.isNotEmpty) {
                if (mainQuestionAnswers[rindex][question.id] == null) {
                  mainQuestionAnswers[rindex]
                      [question.id] = {'total': question.total};
                } else {
                  mainQuestionAnswers[rindex][question.id]['total'] =
                      question.total;
                }
              }
            } else {
              if (question.answer!.isNotEmpty) {
                mainQuestionAnswers[rindex][question.id] = question.answer;
              }
            }

            for (var subquestion in question.subQuestions!) {
              if (subquestion.questionTypeName == multipleColumnType) {
                if (subquestion.male!.isNotEmpty) {
                  if (subQuestionAnswers[rindex][subquestion.id] == null) {
                    subQuestionAnswers[rindex]
                        [subquestion.id] = {'male': subquestion.male};
                  } else {
                    subQuestionAnswers[rindex][subquestion.id]['male'] =
                        subquestion.male;
                  }
                } else if (subquestion.female!.isNotEmpty) {
                  if (subQuestionAnswers[rindex][subquestion.id] == null) {
                    subQuestionAnswers[rindex]
                        [subquestion.id] = {'female': subquestion.female};
                  } else {
                    subQuestionAnswers[rindex][subquestion.id]['female'] =
                        subquestion.female;
                  }
                }
                if (subquestion.total!.isNotEmpty) {
                  if (subQuestionAnswers[rindex][subquestion.id] == null) {
                    subQuestionAnswers[rindex]
                        [subquestion.id] = {'total': subquestion.total};
                  } else {
                    subQuestionAnswers[rindex][subquestion.id]['total'] =
                        subquestion.total;
                  }
                }
              } else {
                if (subquestion.answer!.isNotEmpty) {
                  subQuestionAnswers[rindex][subquestion.id] =
                      subquestion.answer;
                }
              }
            }
          }
        }
      });
    }

    if (mainQuestionAnswers.length < qpov.questionList.length) {
      setState(() {
        for (int i = 0; i < qpov.questionList.length; i++) {
          mainQuestionAnswers.add({});
          subQuestionAnswers.add({});
          editedMainQuestionAnswers.add({});
          editedSubQuestionAnswers.add({});
        }
      });
    }

    setState(() {
      selectedIndex = 0;
    });
  }

  postAnswer({bool draft = false}) {
    var questionProvider =
        Provider.of<QuestionsProvider>(context, listen: false);

    if (widget.edit == true) {
      for (int i = 0; i < mainQuestionAnswers.length; i++) {
        questionProvider.updateAnswer(
          reportId: questionProvider.questionList[i].id,
          mainQanswer: json.encode(mainQuestionAnswers[i]),
          subQanswer: json.encode(subQuestionAnswers[i]),
          editedMainQanswer: json.encode(editedMainQuestionAnswers[i]),
          editedSubQanswer: json.encode(editedSubQuestionAnswers[i]),
          status: draft ? 0 : 1,
        );
      }

      showSnackbar(context: context, text: "Report updated successfully");
    } else {
      // Final submission
      for (int i = 0; i < mainQuestionAnswers.length; i++) {
        questionProvider.postAnswer(
          reportId: questionProvider.questionList[i].id,
          mainQanswer: json.encode(mainQuestionAnswers[i]),
          subQanswer: json.encode(subQuestionAnswers[i]),
          status: draft ? 0 : 1,
        );
      }
      showSnackbar(
          context: context,
          text: "Report ${draft ? "drafted" : "submitted"} successfully");
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsProvider>(
      builder: (context, questionProvider, child) => WillPopScope(
        onWillPop: () async {
          questionProvider.getSubmittedAnswersList();
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Periodic Reports",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  // if (questionProvider.questionnaireModel != null)
                  //   Text(
                  //     questionProvider.questionnaireModel!.createdAt
                  //         .toString()
                  //         .split(" ")[0],
                  //     style: const TextStyle(color: Colors.grey, fontSize: 13),
                  //   ),
                ],
              ),
              actions: [
                // if (widget.edit)
                //   GestureDetector(
                //     onTap: () async {
                //       await questionProvider
                //           .deleteAnswer(widget.qAmodel!.reports.first.id);
                //       Navigator.pop(context);
                //     },
                //     child: const Icon(Icons.delete),
                //   ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    postAnswer(draft: false);
                  },
                  child: const Icon(Icons.send_outlined),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "പ്രാദേശിക ഘടകങ്ങളുടെ പരിപാടി",
                                ),
                              ),
                            ),
                            if (widget.edit == false || widget.draft == true)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    const Text(""),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        postAnswer(draft: true);
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Center(
                                            child: Text(
                                          "Draft",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (selectedIndex >= 0)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Row(
                                  children: [
                                    const Text("Meeting Date"),
                                    const Spacer(),
                                    Text(
                                      questionProvider
                                          .questionList[selectedIndex].createdAt
                                          .toString(),
                                    )
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            questionProvider
                                                .questionList.length;
                                        i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = i;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DipartmentSection(
                                              selected: selectedIndex == i,
                                              title: questionProvider
                                                  .questionList[i]
                                                  .departmentName,
                                              dipCode: questionProvider
                                                      .questionList[i]
                                                      .dipCode ??
                                                  ""),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (selectedIndex >= 0)
                        Expanded(
                          child: ListView.builder(
                            itemCount: questionProvider
                                .questionList[selectedIndex]
                                .mainQuestions
                                .length,
                            itemBuilder: (context, index) => Card(
                              borderOnForeground: false,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                  title: Text(
                                    questionProvider.questionList[selectedIndex]
                                        .mainQuestions[index].question,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  children: [
                                    // Main Question answers
                                    if (questionProvider
                                            .questionList[selectedIndex]
                                            .mainQuestions[index]
                                            .questionTypeName ==
                                        objectiveType)
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: ObjectiveSection(
                                          value: widget.edit
                                              ? questionProvider
                                                  .questionList[selectedIndex]
                                                  .mainQuestions[index]
                                                  .answer!
                                              : "",
                                          onChange: (value) {
                                            setState(() {
                                              if (widget.edit) {
                                                editedMainQuestionAnswers[
                                                        selectedIndex][
                                                    questionProvider
                                                        .questionList[
                                                            selectedIndex]
                                                        .mainQuestions[index]
                                                        .id] = value;
                                              } else {
                                                mainQuestionAnswers[
                                                        selectedIndex][
                                                    questionProvider
                                                        .questionList[
                                                            selectedIndex]
                                                        .mainQuestions[index]
                                                        .id] = value;
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    else if (questionProvider
                                            .questionList[selectedIndex]
                                            .mainQuestions[index]
                                            .questionTypeName ==
                                        singleColumnType)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: SingleColumnField(
                                              value: widget.edit
                                                  ? widget
                                                      .qAmodel!
                                                      .reports[selectedIndex]
                                                      .mainQuestions[index]
                                                      .answer!
                                                  : "",
                                              title: "Total",
                                              onChange: (String? txt) {
                                                setState(() {
                                                  if (widget.edit) {
                                                    editedMainQuestionAnswers[
                                                            selectedIndex][
                                                        questionProvider
                                                            .questionList[
                                                                selectedIndex]
                                                            .mainQuestions[
                                                                index]
                                                            .id] = txt;
                                                  } else {
                                                    mainQuestionAnswers[
                                                            selectedIndex][
                                                        questionProvider
                                                            .questionList[
                                                                selectedIndex]
                                                            .mainQuestions[
                                                                index]
                                                            .id] = txt;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (questionProvider
                                            .questionList[selectedIndex]
                                            .mainQuestions[index]
                                            .questionTypeName ==
                                        multipleColumnType)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: MultipleColumnSection(
                                            male: widget.edit
                                                ? questionProvider
                                                    .questionList[selectedIndex]
                                                    .mainQuestions[index]
                                                    .male!
                                                : "",
                                            female: widget.edit
                                                ? questionProvider
                                                    .questionList[selectedIndex]
                                                    .mainQuestions[index]
                                                    .female!
                                                : "",
                                            total: widget.edit
                                                ? questionProvider
                                                    .questionList[selectedIndex]
                                                    .mainQuestions[index]
                                                    .total!
                                                : "",
                                            onChange: (key, val) {
                                              setState(() {
                                                if (widget.edit) {
                                                  if (editedMainQuestionAnswers[
                                                              selectedIndex][
                                                          questionProvider
                                                              .questionList[
                                                                  selectedIndex]
                                                              .mainQuestions[
                                                                  index]
                                                              .id] ==
                                                      null) {
                                                    editedMainQuestionAnswers[
                                                            selectedIndex][
                                                        questionProvider
                                                            .questionList[
                                                                selectedIndex]
                                                            .mainQuestions[
                                                                index]
                                                            .id] = {};
                                                  }
                                                  editedMainQuestionAnswers[
                                                          selectedIndex][
                                                      questionProvider
                                                          .questionList[
                                                              selectedIndex]
                                                          .mainQuestions[index]
                                                          .id][key] = int.parse(
                                                      val != ""
                                                          ? val.toString()
                                                          : "0");
                                                } else {
                                                  if (mainQuestionAnswers[
                                                              selectedIndex][
                                                          questionProvider
                                                              .questionList[
                                                                  selectedIndex]
                                                              .mainQuestions[
                                                                  index]
                                                              .id] ==
                                                      null) {
                                                    mainQuestionAnswers[
                                                            selectedIndex][
                                                        questionProvider
                                                            .questionList[
                                                                selectedIndex]
                                                            .mainQuestions[
                                                                index]
                                                            .id] = {};
                                                  }
                                                  mainQuestionAnswers[
                                                          selectedIndex][
                                                      questionProvider
                                                          .questionList[
                                                              selectedIndex]
                                                          .mainQuestions[index]
                                                          .id][key] = int.parse(
                                                      val != ""
                                                          ? val.toString()
                                                          : "0");
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    else if (questionProvider
                                            .questionList[selectedIndex]
                                            .mainQuestions[index]
                                            .questionTypeName ==
                                        descriptionType)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SingleColumnField(
                                            title: "Total",
                                            textfield: true,
                                            value: widget.edit
                                                ? widget
                                                    .qAmodel!
                                                    .reports[selectedIndex]
                                                    .mainQuestions[index]
                                                    .answer!
                                                : "",
                                            onChange: (String? txt) {
                                              setState(() {
                                                if (widget.edit) {
                                                  editedMainQuestionAnswers[
                                                          selectedIndex][
                                                      questionProvider
                                                          .questionList[
                                                              selectedIndex]
                                                          .mainQuestions[index]
                                                          .id] = txt;
                                                } else {
                                                  mainQuestionAnswers[
                                                          selectedIndex][
                                                      questionProvider
                                                          .questionList[
                                                              selectedIndex]
                                                          .mainQuestions[index]
                                                          .id] = txt;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),

                                    //////////////////////////////////////////////////////////////////////////////////////////
                                    // Sub Questions

                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: questionProvider
                                          .questionList[selectedIndex]
                                          .mainQuestions[index]
                                          .subQuestions!
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, subIndex) {
                                        List<Question> subQuestions =
                                            questionProvider
                                                .questionList[selectedIndex]
                                                .mainQuestions[index]
                                                .subQuestions!;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                subQuestions[subIndex].question,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              if (subQuestions[subIndex]
                                                      .questionTypeName ==
                                                  objectiveType)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    child: ObjectiveSection(
                                                      value: widget.edit
                                                          ? subQuestions[
                                                                  subIndex]
                                                              .answer!
                                                          : "",
                                                      onChange: (value) {
                                                        setState(() {
                                                          if (widget.edit) {
                                                            editedSubQuestionAnswers[
                                                                    selectedIndex]
                                                                [subQuestions[
                                                                        subIndex]
                                                                    .id] = value;
                                                          } else {
                                                            subQuestionAnswers[
                                                                    selectedIndex]
                                                                [subQuestions[
                                                                        subIndex]
                                                                    .id] = value;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )
                                              else if (subQuestions[subIndex]
                                                      .questionTypeName ==
                                                  singleColumnType)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: SingleColumnField(
                                                        title: "Total",
                                                        value: widget.edit
                                                            ? subQuestions[
                                                                    subIndex]
                                                                .answer!
                                                            : "",
                                                        onChange:
                                                            (String? txt) {
                                                          setState(() {
                                                            if (widget.edit) {
                                                              editedSubQuestionAnswers[
                                                                      selectedIndex]
                                                                  [subQuestions[
                                                                          subIndex]
                                                                      .id] = txt;
                                                            } else {
                                                              subQuestionAnswers[
                                                                      selectedIndex]
                                                                  [subQuestions[
                                                                          subIndex]
                                                                      .id] = txt;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              else if (subQuestions[subIndex]
                                                      .questionTypeName ==
                                                  multipleColumnType)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          MultipleColumnSection(
                                                        male: widget.edit
                                                            ? subQuestions[
                                                                    subIndex]
                                                                .male!
                                                            : "",
                                                        female: widget.edit
                                                            ? subQuestions[
                                                                    subIndex]
                                                                .female!
                                                            : "",
                                                        total: widget.edit
                                                            ? subQuestions[
                                                                    subIndex]
                                                                .total!
                                                            : "",
                                                        onChange: (key, val) {
                                                          setState(() {
                                                            if (widget.edit) {
                                                              if (editedSubQuestionAnswers[
                                                                          selectedIndex]
                                                                      [
                                                                      subQuestions[
                                                                              subIndex]
                                                                          .id] ==
                                                                  null) {
                                                                editedSubQuestionAnswers[
                                                                        selectedIndex]
                                                                    [
                                                                    subQuestions[
                                                                            subIndex]
                                                                        .id] = {};
                                                              }
                                                              editedSubQuestionAnswers[
                                                                      selectedIndex]
                                                                  [subQuestions[
                                                                          subIndex]
                                                                      .id][key] = val;
                                                            } else {
                                                              if (subQuestionAnswers[
                                                                          selectedIndex]
                                                                      [
                                                                      subQuestions[
                                                                              subIndex]
                                                                          .id] ==
                                                                  null) {
                                                                subQuestionAnswers[
                                                                        selectedIndex]
                                                                    [
                                                                    subQuestions[
                                                                            subIndex]
                                                                        .id] = {};
                                                              }
                                                              subQuestionAnswers[
                                                                      selectedIndex]
                                                                  [subQuestions[
                                                                          subIndex]
                                                                      .id][key] = val;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              else if (subQuestions[subIndex]
                                                      .questionTypeName ==
                                                  descriptionType)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors
                                                            .grey.shade100),
                                                    child: SingleColumnField(
                                                      title: "",
                                                      value: widget.edit
                                                          ? subQuestions[
                                                                  subIndex]
                                                              .answer!
                                                          : "",
                                                      textfield: true,
                                                      onChange: (String? txt) {
                                                        setState(() {
                                                          if (widget.edit) {
                                                            editedSubQuestionAnswers[
                                                                    selectedIndex]
                                                                [subQuestions[
                                                                        subIndex]
                                                                    .id] = txt;
                                                          } else {
                                                            subQuestionAnswers[
                                                                    selectedIndex]
                                                                [subQuestions[
                                                                        subIndex]
                                                                    .id] = txt;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  questionProvider.loading == true ? WaveLoader() : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ObjectiveSection extends StatefulWidget {
  Function(String?) onChange;
  String value;
  ObjectiveSection({
    Key? key,
    this.value = "",
    required this.onChange,
  }) : super(key: key);

  @override
  State<ObjectiveSection> createState() => _ObjectiveSectionState();
}

class _ObjectiveSectionState extends State<ObjectiveSection> {
  String yesnoGrp = "";

  @override
  void initState() {
    super.initState();
    yesnoGrp = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Radio(
                  value: "Yes",
                  groupValue: yesnoGrp,
                  onChanged: (value) {
                    setState(() {
                      yesnoGrp = "Yes";
                    });
                    widget.onChange(value.toString());
                  },
                )
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "No",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Radio(
                  value: "No",
                  groupValue: yesnoGrp,
                  onChanged: (value) {
                    setState(() {
                      yesnoGrp = "No";
                    });
                    widget.onChange(
                      value.toString(),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
