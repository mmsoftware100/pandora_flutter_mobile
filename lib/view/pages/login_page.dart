
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pandora_flutter_mobile/providers/article_provider.dart';
import 'package:pandora_flutter_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../components/loader.dart';
import '../../data/constant/const.dart';
import '../../data/constant/theme_helper.dart';
import '../widgets/header_widget.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
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

                                    // hide loading indicator
                                    Navigator.pop(context);

                                    print("loginStatus status is "+loginStatus.toString());

                                    if(loginStatus == true){
                                      int? currentPage = Provider.of<ArticleProvider>(context, listen: false).current_page;
                                      bool atricleStatus = await Provider.of<ArticleProvider>(context, listen: false).getArticle(currentPage!);

                                      if(atricleStatus == true){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                      }
                                      else{
                                        _showToast(context,'Article bug');

                                      }

                                    }
                                    else{
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
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
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