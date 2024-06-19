import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/login/login_bloc.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/module/auth/auth_module.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/routes/auth/auth_routes.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/app_router.dart';
import 'package:youapp/util/validator.dart';
import 'package:youapp/widgets/background.dart';
import 'package:youapp/widgets/ptb_go_button.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isButtonEnabled = false;
  bool _hidePwd = true;

  LoginResponse? loginResponse;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _getForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLogo() {
    return Image.asset(
      'assets/images/ptbgo_black_logo.png',
      height: 40,
    );
  }

  Widget _getForm() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      switch (state.addStatus) {
        case Status.loading:
          const Center(
            child: CircularProgressIndicator(),
          );

          break;

        case Status.success:
          loginResponse = state.response;

          break;
        case Status.failed:
          const Center(
            child: Text('Failed'),
          );
        default:
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              const Text(
                'Login',
                style: TextStyle(
                  color: YouAppColor.whiteColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                cursorColor: YouAppColor.whiteColor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: validateUserName,
                style: const TextStyle(color: YouAppColor.whiteColor),
                decoration: _getInputDec("Name"),
                onFieldSubmitted: (_) =>
                    _fieldFocusChange(context, _nameFocus, _emailFocus),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                cursorColor: YouAppColor.whiteColor,
                validator: validateEmail,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: YouAppColor.whiteColor),
                decoration: _getInputDec(
                    _emailFocus.hasFocus ? "" : "Enter Username/Email"),
                onFieldSubmitted: (_) =>
                    _fieldFocusChange(context, _emailFocus, _passwordFocus),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                validator: validatePassword,
                cursorColor: YouAppColor.whiteColor,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hidePwd,
                style: const TextStyle(color: YouAppColor.whiteColor),
                textInputAction: TextInputAction.done,
                decoration: _getInputDec(
                  _passwordFocus.hasFocus ? "" : "Enter Password",
                  suffixIcon: InkWell(
                    child: _hidePwd
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: YouAppColor.whiteColor,
                          )
                        : const Icon(Icons.visibility_off,
                            color: YouAppColor.whiteColor),
                    onTap: () => setState(() => _hidePwd = !_hidePwd),
                  ),
                ),
                onFieldSubmitted: (_) => _passwordFocus.unfocus(),
              ),
              const SizedBox(height: 24),
              YouAppButton(
                onPressed: () {
                  context.read<LoginBloc>().add(LoginRequestEvent(
                      loginRequestModel: AuthRequestModel(
                          username: _nameController.text.toString(),
                          password: _passwordController.text.toString(),
                          email: _emailController.text.toString())));
                },
                isEnabled: isButtonEnabled,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: isButtonEnabled
                          ? YouAppColor.whiteColor
                          : YouAppColor.disableTextColor,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(text: 'No account?', children: [
                    TextSpan(
                      text: ' Register here',
                      style: const TextStyle(
                        fontSize: 13,
                        color: YouAppColor.goldColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppRouter.changeRoute<AuthModule>(AuthRoutes.register,
                              isReplaceAll: true);
                        },
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  InputDecoration _getInputDec(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: label,
      suffixIcon: suffixIcon,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.06),
      hintStyle: TextStyle(color: YouAppColor.whiteColor.withOpacity(0.4)),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.06),
        ),
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.06),
        ),
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.06),
        ),
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
    );
  }

  bool? _updateButtonState() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
    return null;
  }
}
