
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pandora_flutter_mobile/providers/article_provider.dart';
import 'package:pandora_flutter_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/loader.dart';
import '../../data/constant/const.dart';
import '../../data/constant/theme_helper.dart';
import '../../providers/shared_preference_provider.dart';
import '../widgets/header_widget.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget{
  bool loginStautus;
  LoginPage({Key? key,required this.loginStautus}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _showToast(BuildContext context,String result) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(result),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

   saveUserNameAndPassword(String userName, String password) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('username', userName);
    prefs.setString('password', password);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            widget.loginStautus == false ? Divider(
              thickness: 1,
            ) : Container(),
            widget.loginStautus == false ? SizedBox(
              height: 20,
            ) : Container(),
            widget.loginStautus == false ?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ):Container(),
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Pandora',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                controller: userNameController,
                                decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your user name'),
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            /*
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),

                             */
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: () async{
                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));


                                  print("Hey");
                                  print(userNameController.text);
                                  print("Hey");

                                  if(userNameController.text != "" && passwordController.text != ""){
                                    // show loading indicator
                                    Dialogs.showLoadingDialog(context, _keyLoader);
                                    // bool loginStatus = await Provider.of<UserProvider>(context, listen: false).login(email: defaultEmail, password: defaultPassword);
                                    bool loginStatus = await Provider.of<UserProvider>(context, listen: false).login(email: userNameController.text, password: passwordController.text);


                                    print("loginStatus status is "+loginStatus.toString());

                                    if(loginStatus == true){
                                      print("store in localStorage");
                                      // save in local storage
                                      // saveUserNameAndPassword(userNameController.text,passwordController.text);
                                      await Provider.of<SharedPreferenceProvider>(context,listen:  false).saveUserNameAndPassword(userNameController.text, passwordController.text);
                                      print("stored in localStorage");

                                      // back key show up or not
                                      print("widget.loginStatus is ${widget.loginStautus}");


                                      int? currentPage = Provider.of<ArticleProvider>(context, listen: false).current_page;
                                      String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                                      bool articleStatus = await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,currentPage!);

                                      print("articleStatus is $articleStatus");


                                      // hide loading indicator
                                      Navigator.pop(context);
                                      if(articleStatus == true){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                      }
                                      else{
                                        _showToast(context,'Article bug');

                                      }

                                    }
                                    else{
                                      // hide loading indicator
                                      Navigator.pop(context);
                                      _showToast(context,'Login fail');

                                    }
                                  }
                                  else{
                                    _showToast(context,'Username or password incorrect');
                                  }



                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}