import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandora_flutter_mobile/providers/article_provider.dart';
import 'package:pandora_flutter_mobile/providers/user_provider.dart';
import 'package:pandora_flutter_mobile/tweets.dart';
import 'package:provider/provider.dart';

import 'data/constant/global.dart';
import 'view/pages/home_page.dart';
import 'view/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main()async {

  print("main");
  WidgetsFlutterBinding.ensureInitialized();

  print("WidgetsFlutterBinding.ensureInitialized");
  // await Firebase.initializeApp();
  try{
    //MobileAds.instance.initialize();

    print("MobileAds.instance.initialize");
  }
  catch(exp){
    print("MobileAds.instance.initialize init exp");
    print(exp);
  }

  await di.init();
  runApp(
    MultiProvider(
      providers:[
        /*
        ChangeNotifierProvider(create: (_) => UserProvider(
          userLogin: di.sl(),
          loginWithEmail: di.sl()
        ))

         */
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),


      ],
      child:TwitterCloneApp()
    )
  );
}

class TwitterCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   primaryColorBrightness: Brightness.light,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      // home: HomeScreen(),
      home:SplashScreen(title: '',),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   HomeScreen();
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         leading: Container(
//           margin: const EdgeInsets.all(10.0),
//           child: CircleAvatar(
//             backgroundImage: AssetImage('assets/nano.jpeg'),
//           ),
//         ),
//         title: Text(
//           'Home',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: listOfTweets(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: parseColor("#69001e"),
//         child: Icon(FontAwesomeIcons.envelope,color: Colors.white,),
//         onPressed: () {},
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             buildBottomIconButton(Icons.home, parseColor("#69001e")),
//             buildBottomIconButton(Icons.search, parseColor("#69001e")),
//             buildBottomIconButton(Icons.notifications, parseColor("#69001e")),
//             buildBottomIconButton(Icons.mail_outline, parseColor("#69001e")),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildBottomIconButton(IconData icon, Color color) {
//     return IconButton(
//       icon: Icon(
//         icon,
//         color: color,
//       ),
//       onPressed: () {},
//     );
//   }
//
//   Widget listOfTweets() {
//     return Container(
//       color: Colors.white,
//       child: ListView.separated(
//         itemBuilder: (BuildContext context, int index) {
//           return tweets[index];
//         },
//         separatorBuilder: (BuildContext context, int index) => Divider(
//           height: 0,
//         ),
//         itemCount: tweets.length,
//       ),
//     );
//   }
// }
