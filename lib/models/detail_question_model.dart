class DetailQuestionModel {
  Data? data;
  String? message;

  DetailQuestionModel({this.data, this.message});

  DetailQuestionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<ListAnswer>? listAnswer;
  QuestionDetail? questionDetail;

  Data({this.listAnswer, this.questionDetail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list_answer'] != null) {
      listAnswer = <ListAnswer>[];
      json['list_answer'].forEach((v) {
        listAnswer!.add(ListAnswer.fromJson(v));
      });
    }
    questionDetail = json['question_detail'] != null
        ? QuestionDetail.fromJson(json['question_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listAnswer != null) {
      data['list_answer'] = listAnswer!.map((v) => v.toJson()).toList();
    }
    if (questionDetail != null) {
      data['question_detail'] = questionDetail!.toJson();
    }
    return data;
  }
}

class ListAnswer {
  String? answer;
  int? id;
  int? likeNum;
  String? releasedDate;
  String? userProfile;
  String? username;

  ListAnswer(
      {this.answer,
      this.id,
      this.likeNum,
      this.releasedDate,
      this.userProfile,
      this.username});

  ListAnswer.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    id = json['id'];
    likeNum = json['like_num'];
    releasedDate = json['released_date'];
    userProfile = json['user_profile'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['id'] = id;
    data['like_num'] = likeNum;
    data['released_date'] = releasedDate;
    data['user_profile'] = userProfile;
    data['username'] = username;
    return data;
  }
}

class QuestionDetail {
  String? description;
  int? id;
  int? likeNum;
  int? numberOfAnswer;
  String? questionThumbnail;
  String? questionType;
  String? releasedDate;
  String? titleQuestion;
  String? userProfile;
  String? username;

  QuestionDetail(
      {this.description,
      this.id,
      this.likeNum,
      this.numberOfAnswer,
      this.questionThumbnail,
      this.questionType,
      this.releasedDate,
      this.titleQuestion,
      this.userProfile,
      this.username});

  QuestionDetail.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    likeNum = json['like_num'];
    numberOfAnswer = json['number_of_answer'];
    questionThumbnail = json['question_thumbnail'];
    questionType = json['question_type'];
    releasedDate = json['released_date'];
    titleQuestion = json['title_question'];
    userProfile = json['user_profile'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['like_num'] = likeNum;
    data['number_of_answer'] = numberOfAnswer;
    data['question_thumbnail'] = questionThumbnail;
    data['question_type'] = questionType;
    data['released_date'] = releasedDate;
    data['title_question'] = titleQuestion;
    data['user_profile'] = userProfile;
    data['username'] = username;
    return data;
  }
}
