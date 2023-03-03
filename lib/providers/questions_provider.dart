import 'package:flutter/cupertino.dart';
import 'package:wellfare_party_app/api/questions_list_api.dart';
import 'package:wellfare_party_app/models/qa_model.dart';
import 'package:wellfare_party_app/models/qustionnaire_model.dart';

class QuestionsProvider extends ChangeNotifier {
  bool loading = false;
  List<QuestionnaireModel> questionList = [];
  List<QAmodel> submittedqalist = [];
  List<QAmodel> draftqalist = [];
  // QuestionnaireModel? questionnaireModel;
  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  setQA(List<QuestionnaireModel> qmodel) async {
    questionList = qmodel;
    notifyListeners();
  }

  getQuestionsList() async {
    toggleloading(true);
    questionList = [];
    var response = await listQuestionAPI();

    // if (response.data["list"].length > 0) {
    //   questionnaireModel =
    //       QuestionnaireModel.fromJson(response.data["list"].first);
    //   return QuestionnaireModel.fromJson(response.data["list"].first);
    // } else {
    //   return null;
    // }
    for (var qmodel in response.data["list"]) {
      questionList.add(QuestionnaireModel.fromJson(qmodel));
    }
    toggleloading(false);
  }

  getSubmittedAnswersList() async {
    toggleloading(true);
    submittedqalist = [];

    var response = await submittedQuestionsListAPI();
    for (var answerModel in response.data["list"]) {
      submittedqalist.add(QAmodel.fromJson(answerModel));
    }
    toggleloading(false);
  }

  postAnswer({
    String? reportId,
    String? mainQanswer,
    String? subQanswer,
    int? status,
  }) async {
    toggleloading(true);

    await saveAnswersAPI(
      reportId: reportId,
      mainQanswer: mainQanswer,
      subQanswer: subQanswer,
      status: status,
    );
    getdraftList();
    getSubmittedAnswersList();
    toggleloading(false);
  }

  updateAnswer({
    String? reportId,
    String? mainQanswer,
    String? subQanswer,
    String? editedMainQanswer,
    String? editedSubQanswer,
    int? status,
  }) async {
    toggleloading(true);

    await updateAnswersAPI(
      reportId: reportId,
      mainQanswer: mainQanswer,
      subQanswer: subQanswer,
      editedMainQanswer: editedMainQanswer,
      editedSubQanswer: editedSubQanswer,
      status: status,
    );
    getdraftList();
    getSubmittedAnswersList();
    toggleloading(false);
  }

  getdraftList() async {
    toggleloading(true);
    draftqalist = [];
    var response = await draftAPI();
    for (var answerModel in response.data["list"]) {
      draftqalist.add(QAmodel.fromJson(answerModel));
    }
    toggleloading(false);
  }

  deleteAnswer(String id) async {
    toggleloading(true);

    var response = await deleteAPI(id);

    getdraftList();
    getSubmittedAnswersList();

    toggleloading(false);
  }
}
