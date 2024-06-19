import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/validator.dart';
import 'package:youapp/util/app_router.dart';
import 'package:youapp/register/auth_bloc.dart';
import 'package:youapp/widgets/background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/widgets/ptb_go_button.dart';
import 'package:youapp/routes/auth/auth_routes.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/module/auth/auth_module.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _hidePwd = true;
  bool _hideConfirmPassword = true;

  AuthResponse? responseData;

  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  bool? _updateButtonState() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  Widget _getForm() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state.addStatus) {
          case Status.loading:
            const Center(
              child: CircularProgressIndicator(),
            );

          case Status.success:
            responseData = state.response;

          case Status.failed:
            const Center(
              child: Text('Register Failed'),
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
                  'Register',
                  style: TextStyle(
                    color: YouAppColor.whiteColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  cursorColor: YouAppColor.whiteColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: YouAppColor.whiteColor),
                  validator: validateEmail,
                  decoration:
                      _getInputDec(_emailFocus.hasFocus ? "" : "Enter Email"),
                  onFieldSubmitted: (_) =>
                      _fieldFocusChange(context, _nameFocus, _passwordFocus),
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
                      _fieldFocusChange(context, _nameFocus, _passwordFocus),
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
                  textInputAction: TextInputAction.next,
                  decoration: _getInputDec(
                    _passwordFocus.hasFocus ? "" : "Create Password",
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPassFocus,
                  validator: (value) => validateConfirmPassword(
                      value, _confirmPasswordController.text),
                  cursorColor: YouAppColor.whiteColor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _hideConfirmPassword,
                  style: const TextStyle(color: YouAppColor.whiteColor),
                  textInputAction: TextInputAction.done,
                  decoration: _getInputDec(
                    _confirmPassFocus.hasFocus ? "" : "Confirm Password",
                    suffixIcon: InkWell(
                      child: _hideConfirmPassword
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: YouAppColor.whiteColor,
                            )
                          : const Icon(Icons.visibility_off,
                              color: YouAppColor.whiteColor),
                      onTap: () => setState(
                          () => _hideConfirmPassword = !_hideConfirmPassword),
                    ),
                  ),
                  onFieldSubmitted: (_) => _confirmPassFocus.unfocus(),
                ),
                const SizedBox(height: 24),
                YouAppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(RegisterEvent(
                              authRequestModel: AuthRequestModel(
                            username: _nameController.text.toString(),
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString(),
                          )));
                    }
                  },
                  isEnabled: isButtonEnabled,
                  child: Text(
                    "Register",
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
                    text: TextSpan(text: 'Have an account? ', children: [
                      TextSpan(
                        text: 'Login Here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppRouter.changeRoute<AuthModule>(
                              AuthRoutes.login,
                            );
                          },
                        style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: YouAppColor.goldColor),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
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
}
