import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_excellence_limited/pages/Booking.dart';

import 'home.dart';

class SelfCareQuizPage extends StatefulWidget {
  @override
  _SelfCareQuizPageState createState() => _SelfCareQuizPageState();
}

class _SelfCareQuizPageState extends State<SelfCareQuizPage> {
  // Define the quiz questions and answers
  List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'How many hours of sleep did you get last night?',
      'answers': ['Less than 6', '6-8 hours', 'More than 8']
    },
    {
      'question': 'Significant Changes of Mood?(UP/Down)',
      'answers': ['None', 'Sometimes Maybe', 'Yes Actually Most of the Time']
    },
    {
      'question': 'Problem With Functioning at work or in Your Social-Life',
      'answers': ['No Problem', 'Sometimes Maybe', 'Yes Actually Most of the Time']
    },
    {
      'question': 'Suicidal Thoughts or acts of Self-harm?',
      'answers': ['None', 'Sometimes Maybe', 'Yes Actually Most of the Time']
    },
    {
      'question': 'Did you exercise today?',
      'answers': ['Yes', 'No']
    },
    {
      'question': 'Did you eat a healthy meal today?',
      'answers': ['Yes', 'No']
    },
    {
      'question': 'Did you practice mindfulness today?',
      'answers': ['Yes', 'No']
    },
    {
      'question': 'Did you connect with a friend or loved one today?',
      'answers': ['Yes', 'No']
    },
  ];

  // Initialize the user's quiz progress
  Map<String, dynamic> quizProgress = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.cyanAccent,
      appBar: AppBar(backgroundColor: Colors.pinkAccent,
        title: Text('Daily Self-Care Quiz'),centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display each quiz question
              for (int i = 0; i < quizQuestions.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(quizQuestions[i]['question'], style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    // Display each quiz answer as a radio button
                    for (int j = 0; j < quizQuestions[i]['answers'].length; j++)
                      RadioListTile(
                        title: Text(quizQuestions[i]['answers'][j]),
                        value: j,
                        groupValue: quizProgress[i.toString()],
                        onChanged: (value) {
                          setState(() {
                            quizProgress[i.toString()] = value;
                          });
                        },
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              // Display the Submit button
              Flat3dButton(color: Colors.lightBlue,
                child: Center(child: Text('Submit Quiz',style: GoogleFonts.alice(color: Colors.redAccent,fontSize: 24,fontWeight: FontWeight.w700),)),
                onPressed: () {
                  int score = 0;
                  // Calculate the user's score based on their answers
                  for (int i = 0; i < quizQuestions.length; i++) {
                    if (quizProgress[i.toString()] == null) {
                      // If the user did not answer a question, skip it
                      continue;
                    }
                    if (quizProgress[i.toString()] == 0) {
                      // If the user answered the question correctly, add 1 point
                      score++;
                    }
                  }
                  // Save the user's quiz score and reset the quiz progress
                  // You can save the score to a database or local storage
                  quizProgress = {};
                  // Display the user's score and feedback
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(icon: GestureDetector(child: Icon(CupertinoIcons.xmark,size: 50,color: Colors.red,),onTap: (){Navigator.pop(context);},),
                      title: Text('Quiz Score'),
                      content: Text('Your score is $score out of ${quizQuestions.length}.\n Need Help?',style: GoogleFonts.adventPro(fontSize: 18),),
                      actions: [
                        ElevatedButton(
                          child: Text('Yes, I Need Counselling'),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingForm()));
                          },
                        ),Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8),
                          child: Flat3dButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));}, child: Text("No, Go Home")),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
