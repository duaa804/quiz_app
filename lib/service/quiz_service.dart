import 'package:dio/dio.dart';

import 'package:quiz_with_api/model/quiz_model.dart';

abstract class QuizService{
  Dio dio = Dio();
  late Response response;
  String baseUrl = 'https://6655d3aa3c1d3b60293b4036.mockapi.io/quiz';
 
  Future<bool> createNewQuiz(QuizModel quiz);
  Future<List<QuizModel>>  getAllQuiz();

}
class QuizServiceImp extends QuizService{
  @override
  Future<bool> createNewQuiz(QuizModel quiz)async {
  try {
      response = await dio.post(baseUrl, data: quiz.toMap());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    }  catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<QuizModel>> getAllQuiz() async{
    response =await dio.get(baseUrl);
    print(response);
    try{
       if(response.statusCode==200){
      List <QuizModel> question = List.generate(response.data.length, (index) => QuizModel.fromMap(response.data[index]));
      return question;
    }
     else{
      return [];
     }
   

    }
     on DioException catch(e){
      print(e);
        return [];
      }
   

   
  }
}