import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/resourcemodel.dart';

/*class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override*/
  /*Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,elevation: 0,
        title: const Text('Helpful Learning Resources',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/compbook.jpg"),
    fit: BoxFit.cover,),),
          child: ListView(
            children: <Widget>[
              _buildResourceTile(
                title: 'National Institute of Mental Health',
                subtitle: 'Information on mental health disorders and treatment',
                url: 'https://www.nimh.nih.gov/',
              ),
              _buildResourceTile(
                title: 'Mayo Clinic',
                subtitle: 'Mental Illness symptoms,causes and Diagnosis',
                url:' https://www.mayoclinic.org/diseases-conditions/mental-illness/symptoms-causes/syc-20374968'),
              _buildResourceTile(
                title: 'Issues I Face',
                subtitle: 'Find Topics of all issues we all face',
                url:'https://issuesiface.com/magazine/topics'
              ),
              _buildResourceTile(
                title: 'Psychology Today',
                subtitle: 'Articles on mental health and therapy',
                url: 'https://www.psychologytoday.com/',
              ),
              _buildResourceTile(
                title: 'American Counseling Association',
                subtitle: 'Resources for professional counselors and clients',
                url: 'https://www.counseling.org/',
              ),
          _buildResourceTile(
            title: 'UCDavis Student Health And Counselling Services',
            subtitle: 'Eight Dimension Of wellness',
            url:'https://shcs.ucdavis.edu/wellness'
          ),
          _buildResourceTile(
            title: 'Medical News Today',
            subtitle: 'Diet For a Helthy Life',
            url: 'https://www.medicalnewstoday.com/articles/160774'),

          _buildResourceTile(
            title: 'Global Youth Dynamics',
            subtitle: 'Helpful Blogs',
            url:'https://globalyouthdynamics.co.ke/news.html'),
              // Add more resource tiles here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceTile({
    required String title,
    required String subtitle,
    required String url,
  }) {
    return ListTile(
      title: Text(title,style: GoogleFonts.alice(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.cyan),),
      subtitle: Text(subtitle,style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.purpleAccent),),
      trailing: const Icon(Icons.arrow_forward_ios,size: 40,color: Colors.cyanAccent,),
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}*/

  /*class ResourcesPage extends StatelessWidget {
    const ResourcesPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Resources'),
        ),
        body: FutureBuilder<List<Resource>>(
          future: ResourceDatabaseHelper.getResources(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final resources = snapshot.data!;
              return ListView.builder(
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  final resource = resources[index];
                  return ListTile(
                    title: Text(resource.title),
                    subtitle: Text(resource.subtitle),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      if (await canLaunch(resource.url)) {
                        await launch(resource.url);
                      } else {
                        throw 'Could not launch ${resource.url}';
                      }
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Text('Error loading resources'),

              );
            } else {
              return const Center(
                child: SpinKitPumpingHeart(size: 60,color: Colors.pink),
              );
            }
          },
        ),
      );
    }
  }*/
/*class ResourceDatabaseHelper {
  static Future<List<Resource>> getResources() async {
    final databaseRef = FirebaseDatabase.instance.reference();
    final resourcesRef = databaseRef.child('resources');
    final completer = Completer<List<Resource>>();
    final resources = <Resource>[];

    final listener = resourcesRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final value = dataSnapshot.value;
      if (value is Map<String, dynamic>) {
        resources.clear();
        value.forEach((key, value) {
          resources.add(Resource.fromJson(value));
        });
        completer.complete(resources);
      } else if (value is String) {
        completer.completeError('Invalid data format.');
      } else {
        completer.completeError('There are no resources available.');
      }
    }, onError: (error) {
      completer.completeError(error);
    });

    final result = await completer.future;
    await listener.cancel();
    return result;
  }
}*/

/*class ResourceDatabaseHelper {
  static Future<List<Resource>> getResources() async {
    final databaseRef = FirebaseDatabase.instance.reference();
    final resourcesRef = databaseRef.child('resources');
    final completer = Completer<List<Resource>>();
    final resources = <Resource>[];

    final listener = resourcesRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        final jsonMap = dataSnapshot.value as Map<dynamic, dynamic>;
        resources.clear();
        jsonMap.forEach((key, value) {
          resources.add(Resource.fromJson(value));
        });
        completer.complete(resources);
      } else {
        completer.completeError('No data available.');
      }
    }, onError: (error) {
      completer.completeError(error);
    });

    final result = await completer.future;
    await listener.cancel();
    return result;
  }*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,elevation: 0,
        title: const Text('Helpful Learning Resources',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
      ),
      body: SizedBox(width: double.infinity,
        height: double.infinity,
        child: Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/compbook.jpg"),
            fit: BoxFit.cover,),),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('resources').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(size: 80,color: Colors.orangeAccent,),
                );
              }

              final resources = snapshot.data?.docs;

              return ListView.builder(
                itemCount: resources?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final resource = resources?[index].data() as Map<String, dynamic>;

                  return ListTile(
                    title: Text(resource['title'] ?? '',style: GoogleFonts.alice(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.cyan),),
                    subtitle: Text(resource['description'] ?? '',style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.purpleAccent),),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 40,color: Colors.cyanAccent,),
                    onTap: ()  async {
                      final url = resource['url'];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                   throw 'Could not launch $url';}}
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}



