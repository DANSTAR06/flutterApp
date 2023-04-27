import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/pages/home.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
class aboutUs extends StatefulWidget {
  const aboutUs({Key? key}) : super(key: key);

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      appBar: AppBar(leading: IconButton(onPressed: () {
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => home()));
        }
      },
        icon: Icon(CupertinoIcons.back,size: 40, color: Colors.white,),),
          elevation: 1,title: Text("ABOUT US", style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 24.0, fontFamily:
      "NotoSansMono",
          letterSpacing: 1.5),),
          centerTitle: true, backgroundColor: Colors.transparent,

          actions: [
            TextButton.icon( onPressed:(){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(title: Row(children: [Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.warning_amber,color: Colors.redAccent,
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("Log Out!",style: TextStyle(fontFamily: "NotoSnasMono",
                      fontSize: 20,fontWeight: FontWeight.w900,color: Colors.orange[800]),),
                ),
                ],
                ),content: Text("Confirm You want to Log out?",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 16,fontWeight: FontWeight.w600)),
                  actions: [TextButton(onPressed: ()async{
                    Navigator.pop(context);
                  }, child: Text("No stay In",style: TextStyle(fontFamily: "NotoSnasMono",
                      fontSize: 20,fontWeight: FontWeight.w900),),),
                    TextButton(onPressed: ()async{
                      Navigator.pop(context);
                      await _auth.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginscreen()));
                    }, child: Text("Yess Log Out please",style: TextStyle(fontFamily: "NotoSnasMono",
                        fontSize: 18,fontWeight: FontWeight.w900),))],
                );
              });
            },
              icon: Icon(CupertinoIcons.person_crop_circle_badge_minus,size: 20,color: Colors.cyan[100],),label: Text("Log out",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.0,fontFamily:
                "NotoSansMono",color: Colors.red[500]
                ),),
            ),]
      ),
      body: SingleChildScrollView(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
      width: w,
      height: h * 0.35,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/ultimate.jpg"),
              fit: BoxFit.cover
          )
      ),
    ),SizedBox(height: 50,),
      Column(
        children: [
          Text("BRIEF BIO",style: TextStyle(fontFamily: "NotoSnasMono",fontSize: 28,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Divider(thickness: 5,height: 2,),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Samuel Kanja was born in the rural Kenyan village called Kiandu in Tetu Division (home for Nobel Laureate Winner 2004-Wangari Maathai) in Nyeri County."'\t'
                " He attended the Kiandu Primary School and proceeded to St Mary’s Boys Secondary School,"'\n'
                " Nyeri where he emerged top of the class with Grade A-Plain of 83 points.He was admitted to University of Nairobi to pursue Bachelor of Science, "'\n'
                "Statistics where he graduated with Second Class Upper Division Honors and also as a Certified Public Accountant (CPA-K)."'\n'
                " He holds a Masters of Science, Entrepreneurship and Innovations Management from University of Nairobi."'\n',style: TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
          ),
          SizedBox(height: 30,),
          Text("CAREER", style: TextStyle(fontFamily: "NotoSnasMono",fontSize: 28,fontWeight: FontWeight.w300),),
          SizedBox(height: 20,),
          Divider(thickness: 5,height: 2,),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("A young achiever, a highly regarded corporate auditor,"'\t'
                " and a man who has surpassed and broken chains of myths and obstacles are just a few ways people "'\n'
                "have described Samuel Kanja.samuel kanja Over the last 8 years,'\t he has evolved from one great statistician, "
                "accountant and author to become one of the most sought after business trainer, "'\n'
                "student mentor and life coach in the country. Not just speaking but inspiring"'\n'
                " & igniting change for better in all circles of life."'\n'
                "He has gained wholesome experience from the many engagements in various firms "'\n'
                ";Ernst & Young, Leading Global Consulting Firms (Senior Auditor) "'\n'
                "KPMG (Monitory & Evaluation)Citi Bank NA (HR & Corporate Services)"'\n'
                "British American Tobacco Limited (HR Department)National Bank of KenyaCurrently, "'\n'
                "he is the Founding Director and Chief Trainer at Ultimate Excellence Ltd, "'\n'
                "a training and mentor-ship hub. The company has trainers and mentors"'\n'
                " from various professions that meets the needs of our clients."'\n'
                "He has also authored two other books, Fashioned for Life, "'\n'
                "The Ultimate Recipe for a Wholesome Student, The Career Decoder, "'\n'
                "and a booklet, My Values; My Identity. He is driven by excellence "'\n'
                "and a deep desire for value-based living. He is currently doing a career book."'\n'
                "He is well versed in performance improvement, work-life balance, "'\n'
                "personal and talent development, career and change management, "'\n'
                "life and entrepreneurial skills training. His vision is to inform, "'\n'
                "ignite and inspire in pursuit of value-based living."'\n'
                "Mr Kanja is quoted saying “One of my biggest goals in life is to uplift many lives as possible."'\n'
                " From the challenges I faced in my childhood, I recognize the importance of mentor-ship and "'\n'
                "how important it is to inspire and guide the young generation"'\n'
                " who are in their most important stage in their lives."'\n'
                " From my corporate experience in various companies, I know there is value in training, "'\n'
                "coaching and motivating the staff."'\n'
                "”Our tagline is ‘Unleashing the Best in Your Life’Our leading quote is "'\n'
                "‘Better Light a Candle than Curse Darkness’Our slogan is ‘BEING AT YOUR BEST’"'\n'
                ".We, The Ultimate Excellence Team, are convinced beyond doubt that life is not poisoned and"'\n'
                " there is a unique and secured purpose for each person."
                " We speak to people to IGNITE any degree of positive change for we have learnt and "
                "experienced the power in words.", style: TextStyle(fontFamily:
            "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
          ),
          SizedBox(height: 45),
          Container(
            width: w,
            height: h * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/services.jpg"),
                    fit: BoxFit.cover
                )
            ),),
          SizedBox(height: 40),
          Text("TOP CLIENTS",style: TextStyle(fontFamily: "NotoSnasMono",fontSize: 28,fontWeight: FontWeight.w500),),
          SizedBox(height: 20),
          Divider(thickness: 5,height: 2,),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('\n''\t''\t''\t'"SCHOOLS"'\n''\n'

              '\n'"St Mary’s School – Nairobi"'\n'
              "St Mary’s Boys Sec School- Nyeri"'\n'
              'La Salle Academy''\n'
              "Chania Girls High School-Thika"'\n'
              "Kagumo High School"'\n'
              "Makini Schools"'\n'
              "Mugoiri Girls High School"'\n'
              "Kiangunyi Girls High School"'\n'
              "Kiine Girls High School"'\n'
              'Ng’iya Girls High School-Siaya''\n'
              'Nakeel Boys High School''\n'
              'Oloo Laiser High School''\n'
              'Ruchu Girls High School''\n'
              'Kiunyu Girls High School''\n'
              'Watuka Boys High School''\n'
              'Sugoi Girls High School''\n'
              'Ongata Rongai Senior Academy''\n'
              'Mweiga High School''\n'
              'Karima Boys High School''\n'
              'Bishop Gatimu Ngandu Girls''\n'
              'Mt Kenya Senior Academy-Nyeri''\n'
              'St Cecilia Girls High- Nyahururu''\n'
              'Sunshine School-Nairobi''\n'
               'Mt Laverna Girls-Nairobi''\n'
                'Kiandu Primary School''\n'
              'Mary Immaculate Primary School''\n'
              'Ihithe Secondary School''\n'
              'Mt Carmel Academy-Narumoru''\n'
              'Senior Chief Nyandusi- Kisii''\n'
              'Dr Kamundia Girls Secondary School''\n'
              'Kiandu Primary School Prize Giving Ceremony''\n'
              'Gichira Sec School''\n'
              'Nakeel Boys High School''\n'
              'St Mary’s Sec School-Nyeri''\n'
              'St Elizabeth Boys-Nairobi''\n'
              'Kiandu Sec School''\n'
              'Utugi Sec School-Limuru''\n'
              'Trikha Girls-Thika''\n'
              'Ithekahuno Sec School-Nyeri''\n'
              'Irene School- Maralal''\n'
              'Ruth Kiptanui Girls High School-Baringo''\n'
              'St John High School-Baringo''\n'
              'St Joseph Wamagana Sec School''\n'
              'Ithangarari Sec School-Gatanga''\n'
              'Othaya Girls High School''\n'
             ' Kiriti Sec School''\n'
              'Heights High School-Thika''\n'
              'Meridian High School-Karen''\n'
              'St Paul’s Githakwa Sec School''\n'
              'Mutathiini Sec School''\n'
              'Kenyatta High School Thika''\n'
              'Gathitu Primary School-Mukurwe-ini''\n'
              'Wamagana Primary School''\n'
              'Ikutha Boys High School-Kitui''\n'
              'Shadows of Hope Academy-Dagorreti''\n'
              'Ikanga Boys High School-Kitui''\n'
              'Kalivu Sec School-Kitui''\n'
              'Monguni Sec School-Kitui''\n''\n''\t'

                '\t''\t''\t''SEMINARS''\n''\t'

              '\t''\n''\n'"Murang’a Diocese Catholic Sponsored Principals Conference 2017"'\n'
              "Archdiocese of Nairobi Catholic Sponsored Deputy Principals’ Conference 2018"'\n'
              "Archdiocese of Nairobi Student Council Conference 2019"'\n'
              "Nyeri County Student Leaders Conference 2016"'\n'
              '1st East Africa Education Conference''\n'
              'St Mary’s Catholic Church-Nairobi''\n'
              'Our Lady Cathedral Youth-Nyeri''\n'
              'Archdiocese of Nyeri Youth Seminar''\n'
              'Moi Equator Catholic Youth-Nanyuki''\n'
              'Tetu High School Principals Association''\n'
              'Kiandu Catholic Youth''\n'
              'Mweiga Parish Young Parents Seminar''\n'
              'Tetu Parish Youth Seminar''\n'
              'Ithenguri parish Youth''\n'
              'Kiganjo Catholic Youth''\n'
              'AIPCA Conference-Thegenge Zone in Tetu''\n'
              'Kajiado County Deputy Principals Conference 2017''\n'
              'Kariko Parish Youth-Othaya''\n'
              "Gataragwa Parish Challenge Week 2015"'\n'
              "Sirima Parish Challenge Week 2015"'\n''\t'


                '\n''\t''\t''\t''UNIVERSITIES & COLLEGES''\n'

              '\n''University of Nairobi Business School''\n'
              'University of Nairobi-Main campus''\n'
              'University of Nairobi- Chiromo campus''\n'
              'Kisii University''\n'
              'Maasai Mara University''\n'
              'Royal School of Business''\n'
              'Githunguri Institute of Business',style: TextStyle(fontFamily: "NotoSnasMono",
                fontSize: 18,fontWeight: FontWeight.w400),),
          ),
          SizedBox(height: 50,),
          Container(
            width: w,
            height: h * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/ultimate_app.jpg"),
                    fit: BoxFit.cover
                )
            ),),

        ],
      )]
      )
      )
    );
  }
}
