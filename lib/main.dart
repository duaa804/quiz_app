import 'package:flutter/material.dart';
import 'package:quiz_with_api/model/quiz_model.dart';
import 'package:quiz_with_api/service/quiz_service.dart';

void main() {
  runApp(const MyApp());
}

List<QuizModel> result = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
    );
  }
}

// ignore: must_be_immutable
class CreateQuiz extends StatelessWidget {
  CreateQuiz({super.key});
  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController indexOfCorrect = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QustionPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(child: Icon(Icons.menu)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (Context) => LogIn()))
                    },
                child: CircleAvatar(child: Icon(Icons.logout))),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: question,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: answer,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: answer1,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: answer2,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: answer3,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: indexOfCorrect,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        )
      ]),
      floatingActionButton: InkWell(
        onTap: () async {
          bool status = await QuizServiceImp().createNewQuiz(QuizModel(
              question: question.text,
              answers: [answer.text, answer1.text, answer2.text, answer3.text],
              indexOfCorrect: num.parse(indexOfCorrect.text)));
          if (status) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Success"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Success"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Icon(Icons.send),
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Spacer(flex: 2),
      Padding(
        padding: EdgeInsets.all(40.0),
        child: TextField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        child: Container(
            height: 50,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'save',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    colors: [Color(0xffDA8BD9), Color(0xffF3BD6B)]))),
      ),
      Spacer(
        flex: 2,
      )
    ]));
  }
}

int _currentQuestionIndex = 0;
int _scor = 0;
int _answeredQuestions = 0;
double _progressValue = 0.0;

class QustionPage extends StatefulWidget {
  const QustionPage({super.key});

  @override
  State<QustionPage> createState() => _QustionPageState();
}

PageController pageController = PageController();

class _QustionPageState extends State<QustionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: QuizServiceImp().getAllQuiz(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QuizModel> question = snapshot.data as List<QuizModel>;
                result = question;
                print(result);
                return PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Scaffold(
                      body: Column(
                        children: [
                          Spacer(),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 205,
                                width: 291,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    // color: Color(0xffA42FC1)
                                    gradient: const LinearGradient(
                                        // begin: Alignment.topLeft,
                                        // end: Alignment.topRight,
                                        colors: [
                                          Color(0xffDA8BD9),
                                          Color(0xffF3BD6B),
                                        ])),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 30.0),
                                    child: Row(
                                      //  mainAxisAlignment: MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '$_scor',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                              Expanded(
                                                child: LinearProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.green),
                                                  //color: Colors.green,
                                                  value: _scor / result.length,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Center(
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xffDA8BD9),
                                                      Color(0xffF3BD6B),
                                                    ]),
                                                shape: BoxShape.circle),
                                            child: CircularProgressIndicator(
                                              value: _progressValue,
                                              color: Colors.brown,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 60,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '$_currentQuestionIndex',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              Expanded(
                                                child: LinearProgressIndicator(
                                                  value: _currentQuestionIndex /
                                                      result.length,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Question $_answeredQuestions'),
                                  ),
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(result[index].question),
                                  )),
                                ]),
                              ),
                            ),
                          ),
                          Container(
                            height: 400,
                            child: ListView.builder(
                              itemCount: result[index].answers.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {
                                      if (index ==
                                          result[index].indexOfCorrect) {
                                        setState(() {
                                          ++_scor;
                                          ++_answeredQuestions;
                                          _progressValue = _answeredQuestions /
                                              result.length;
                                        });

                                        pageController.nextPage(
                                            duration: Duration(seconds: 2),
                                            curve: Curves.bounceInOut);
                                      } else {
                                        setState(() {
                                          ++_currentQuestionIndex;
                                          ++_answeredQuestions;
                                          _progressValue = _answeredQuestions /
                                              result.length;
                                        });
                                        pageController.nextPage(
                                            duration: Duration(seconds: 2),
                                            curve: Curves.bounceInOut);
                                      }
                                    },
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Center(
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xffDA8BD9),
                                                      Color(0xffF3BD6B),
                                                    ])),
                                            child: Center(
                                                child: Text(result[index]
                                                    .answers[index]))),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}

// class ListQuestion extends StatelessWidget {
//   const ListQuestion({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: FutureBuilder(
//             future: QuizServiceImp().getAllQuiz(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<QuizModel> question = snapshot.data as List<QuizModel>;
//                 result = question;
//                 print(result);
//                 return Text(question.toString());
//               } else {
//                 return Text('false');
//               }
//             }));
//   }
// }
