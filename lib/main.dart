import 'package:ecommerce/cart/cart_controller.dart';
import 'package:ecommerce/dashboard/dashboard_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) => setState(() {
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: ,
        primaryColor: Color(0xFF307D7E),
      ),
      home: loading
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : InitialProcess(),
    );
  }
}

class InitialProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges()
            .map((value) => value != null),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data) {
            return DashboardView();
          }
          return MyHomePage();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  User _firebaseUser;
  String _status = '';

  AuthCredential _phoneAuthCredential;
  String _verificationId;
  int _code;

  void _handleError(e) {
    print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((UserCredential authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
      }).catchError((e) => _handleError(e));
      setState(() {
        _status = 'Signed In';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      setState(() {
        _status = 'Signed out';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber() async {
    String phoneNumber = "+91 " + _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status = 'verificationCompleted';
      });
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      _handleError(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());
      setState(() {
        _status = 'Code Sent';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  void _submitOTP() {
    String smsCode = _otpController.text.toString().trim();
    this._phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this._verificationId, smsCode: smsCode);

    _login();
  }

  void _reset() {
    _phoneNumberController.clear();
    _otpController.clear();
    setState(() {
      _status = "";
    });
  }

  void _displayUser() {
    setState(() {
      _status += _firebaseUser.toString() + '\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://image.freepik.com/free-vector/spot-light-background_1284-4685.jpg',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Groczzz',
                  style: Get.textTheme.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Chaging the way you buy',
                    style: Get.textTheme.headline6,
                  ),
                ),
                SizedBox(height: 24),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      minWidth: Get.mediaQuery.size.width,
                      onPressed: _submitPhoneNumber,
                      child: Text('Fetch OTP'),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    Visibility(
                      visible: _status == 'Code Sent',
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Visibility(
                      visible: _status == 'Code Sent',
                      child: TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          hintText: 'OTP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: _status == 'Code Sent',
                      child: MaterialButton(
                        minWidth: Get.mediaQuery.size.width,
                        onPressed: _submitOTP,
                        child: Text('Submit'),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Text('$_status'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
