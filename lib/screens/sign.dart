import 'package:cls/models/user/googleauth.dart';
import 'package:cls/screens/bottomNavBar/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> with TickerProviderStateMixin {

TabController tabController;

@override
void initState(){
  tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        elevation: 0.0,
        title: Text(
          'Welcome!',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 40.0),
          child: TabBar(
            controller: tabController,
            tabs: [
              Text('Sign In'), Text('Register')
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              shape: BoxShape.rectangle
            ),
            labelColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
            unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: TabBarView(
          controller: tabController,
          children: [
            SignIn(), Register(),
          ],
        ),
      ),
    );
  }
}



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final TextEditingController emailController = TextEditingController();
final TextEditingController resetPasswordController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool obsecure = true;

final _formKey = GlobalKey<FormState>();

static final GlobalKey<FormFieldState<String>> emailKey = GlobalKey<FormFieldState<String>>();
static final GlobalKey<FormFieldState<String>> passwordKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            field('email', Icons.email, emailController, TextInputType.emailAddress, emailKey),
            SizedBox(height: 10.0),
            field('password', Icons.lock, passwordController, TextInputType.text, passwordKey),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        actions: [
                          FlatButton(
                            child: Text(
                                'Send',
                                style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)
                              ),
                            color: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {}
                          ),
                          FlatButton(
                            child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)
                              ),
                            color: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                          ),
                        ],
                        title: Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
                        ),
                        content: field('Type Email', Icons.email, resetPasswordController, TextInputType.emailAddress, emailKey),
                      );
                    }
                  );
                },
                  child: Text(
                  'Forogt Password?!',
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            FlatButton(
              child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
              color: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () async {
                // if(_formKey.currentState.validate()){
                //   return Navigator.push(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                // }else{
                //   return Scaffold.of(context).showSnackBar(
                //     SnackBar(
                //       backgroundColor: Colors.black,
                //       duration: Duration(seconds: 5),
                //       content: Text(
                //         'Some Fields Required',
                //         style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                //       ),
                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                //     ),
                //   );
                // }
                SharedPreferences user = await SharedPreferences.getInstance();
                user.setString('email', emailController.text);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
              },
            ),
            FlatButton(
              child: Text(
                  'Google',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
              color: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () async {
                signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();})));
              },
            ),
          ],
        ),
      ),
    );
  }
  field(String label, IconData icon, TextEditingController controller, TextInputType type, Key key) {
    return TextFormField(
      key: label == 'Type Email' ? null : key,
      validator: (value) {
        if(value.isEmpty){
          return 'this field required';
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black, width: 0.5)
        ),
          disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey, width: 0.5)
        ),
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black, width: 0.5)
        ),
          errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 0.5)
        ),
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black, width: 0.5)
        ),
          focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 0.5)
        ),
        prefixIcon: Icon(icon, color: Colors.black, size: 20.0),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
        suffixIcon: label == 'password' ? IconButton(
          icon: Icon(Icons.remove_red_eye),
          color: Colors.black,
          iconSize: 20.0,
          onPressed: () {
            setState(() {
              obsecure = !obsecure;
            });
          },
        ) : null
      ),
      keyboardType: type,
      textInputAction: TextInputAction.done,
      controller: controller,
      obscureText: label == 'email' ? false : obsecure,
    );
  }
}



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

final TextEditingController emailController = TextEditingController();
final TextEditingController resetPasswordController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool obsecure = true;

final _formKey = GlobalKey<FormState>();

static final GlobalKey<FormFieldState<String>> emailKey = GlobalKey<FormFieldState<String>>();
static final GlobalKey<FormFieldState<String>> passwordKey = GlobalKey<FormFieldState<String>>();


String gender = 'None';

bool checked = false;

String pickedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            field('email', Icons.email, emailController, TextInputType.emailAddress, emailKey),
            SizedBox(height: 10.0),
            field('password', Icons.lock, passwordController, TextInputType.text, passwordKey),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
              ),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ListTile(
                title: Text(
                  'Gender',
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)
                ),
                subtitle: Text(
                  gender,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                trailing: PopupMenuButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20.0,),
                  itemBuilder: (BuildContext context){
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        child: Text('Male', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                        value: 'Male',
                      ),
                      PopupMenuItem(
                        child: Text('Female', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                        value: 'FeMale',
                      ),
                    ];
                  },
                  onSelected: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
              ),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ListTile(
                title: Text(
                  'Accept Conditions',
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)
                ),
                subtitle: Text(
                  'Read Terms & Conditions',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                trailing: Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      checked = value;
                    });
                  }
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                    builder: (BuildContext context){
                      return Container(
                        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                        child: ListTile(
                          title: Text(
                            'Our Terms & Conditions',
                            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
                          ),
                          subtitle: Text(
                            'Our Terms & Conditions \n Our Terms & Conditions Our Terms & Conditions Our Terms & Conditions Our Terms & ConditionsOur Terms & Conditions\n Our Terms & ConditionsOur Terms & Conditions',
                            style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold)
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
              ),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ListTile(
                title: Text(
                  'Date of Birth',
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)
                ),
                subtitle: Text(
                  '${pickedDate.toString()}',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                onTap: () async {
                  var picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now(),
                  );
                  setState(() {
                    pickedDate = picked.toString().substring(0, 10);
                  });
                },
              ),
            ),
            FlatButton(
              child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
              color: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  SharedPreferences user = await SharedPreferences.getInstance();
                  user.setString('email', emailController.text);
                  return Navigator.push(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                }else{
                  return Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black,
                      duration: Duration(seconds: 5),
                      content: Text(
                        'Some Fields Required',
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                    ),
                  );
                }
              },
            ),
            FlatButton(
              child: Text(
                  'Google',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
              color: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () async {
                signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();})));
              },
            ),
          ],
        ),
      ),
    );
  }
  field(String label, IconData icon, TextEditingController controller, TextInputType type, Key key) {
    return TextFormField(
      key: label == 'Type Email' ? null : key,
      validator: (value) {
        if(value.isEmpty){
          return 'this field required';
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black, width: 0.5)
        ),
          disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey, width: 0.5)
        ),
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black, width: 0.5)
        ),
          errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 0.5)
        ),
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black, width: 0.5)
        ),
          focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red, width: 0.5)
        ),
        prefixIcon: Icon(icon, color: Colors.black, size: 20.0),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
        suffixIcon: label == 'password' ? IconButton(
          icon: Icon(Icons.remove_red_eye),
          color: Colors.black,
          iconSize: 20.0,
          onPressed: () {
            setState(() {
              obsecure = !obsecure;
            });
          },
        ) : null
      ),
      keyboardType: type,
      textInputAction: TextInputAction.done,
      controller: controller,
      obscureText: label == 'email' ? false : obsecure,
    );
  }
}