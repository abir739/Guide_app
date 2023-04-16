import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:guide_app/NetworkHandler.dart';
import 'package:guide_app/planning/planing_list.dart';
import 'package:guide_app/success_login_page.dart';
import 'package:guide_app/themes/colors.dart';
import 'package:guide_app/utils/icon_name.dart';
//import 'package:guide_app/planning/planning.dart';
//import 'package:guide_app/planning/planning_test.dart';
import 'package:flutter_svg/svg.dart';

import 'components/border_button_widget.dart';
import 'components/custom_appbar.dart';
import 'components/custom_button_widget.dart';
import 'components/custom_textfield.dart';
import 'components/custom_textfield_password.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late GoogleSignIn _googleSignIn;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  int selectedRadio = 0;
  TextEditingController forgetEmailController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();

  late String errorText;
  bool validate = false;
  bool circular = false;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // Ajoutez les scopes supplémentaires ici selon vos besoins
      ],
    );
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Utilisez les informations de l'utilisateur et de l'authentification pour authentifier l'utilisateur dans votre application ici
    } catch (error) {
      // Gérez les erreurs de connexion ici
    }
  }

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _buildAppbar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSize _buildAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: CustomAppBar(
        leftWidget: SizedBox(),
        color: Colors.transparent,
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15, top: 30),
      child: Form(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              width: 100, // replace with your desired width
              height: 80, // replace with your desired height
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(" Welcome to Zenify app!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _getEmailTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  _getPasswordTextField(),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButtonWidget(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Handle login button pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlanningListPage(),
                          ),
                        );
                      }
                    },
                    title: "Sign In",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _getForgetPassword(),
            SizedBox(
              height: 50,
            ),
            _getTextOnLineDivider(),
            SizedBox(
              height: 50,
            ),
            _getSocialMediaButton()
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        height: 100,
        child: Center(
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: "Don't have an account?",
                style: TextStyle(color: primary.withOpacity(0.5))),
            TextSpan(text: "  "),
            TextSpan(text: "Sign Up", style: TextStyle(color: primary)),
          ])),
        ));
  }

  Widget _getEmailTextField() {
    return CustomTextField(
      controller: emailController,
      prefixIcon: const Icon(
        Icons.email,
        size: 18,
      ),
      labelText: "Email",
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _getPasswordTextField() {
    return CustomTextFieldPassword(
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
    );
  }

  Widget _getForgetPassword() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Text("Forgot Password", style: TextStyle(color: primary)),
      ),
    );
  }

  Widget _getTextOnLineDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: lineBorderColor, thickness: 1),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: white,
          child: Text("Or Login With"),
        )
      ],
    );
  }

  Widget _getSocialMediaButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BorderButtonV2(
          preIcon: IconName.facebook,
          iconSize: 30,
          onTap: () {
            _facebookLogin();
          },
        ),
        SizedBox(
          width: 20,
        ),
        BorderButtonV2(
          preIcon: IconName.google,
          iconSize: 30,
          onTap: _handleSignIn,
        ),
        SizedBox(
          width: 20,
        ),
        BorderButtonV2(
          preIcon: IconName.apple,
          iconSize: 30,
          onTap: () {},
        )
      ],
    );
  }

  _facebookLogin() async {
    // Create an instance of FacebookLogin
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile, // permission to get public profile
      FacebookPermission.email, // permission to get email address
    ]);
    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken =
            res.accessToken; // get accessToken for auth login
        final profile = await fb.getUserProfile(); // get profile of user
        final imageUrl =
            await fb.getProfileImageUrl(width: 100); // get user profile image
        final email = await fb.getUserEmail(); // get user's email address

        print('Access token: ${accessToken?.token}');
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        print('Your profile image: $imageUrl');
        if (email != null) print('And your email is $email');

        //push to success page after successfully signed in
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => SuccessLoginPage(
                      fbAccessToken: accessToken!.token,
                      profileImage: imageUrl!,
                      fbName: profile.name!,
                      fbId: profile.userId,
                      fbEmail: email!,
                    ))));

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
}
