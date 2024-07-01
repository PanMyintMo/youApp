import 'package:flutter/material.dart';
import 'package:youapp/auth/authutil/youapprichtext.dart';
import 'package:youapp/auth/authutil/youapptextbutton.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/validator.dart';
import 'package:youapp/register/auth_bloc.dart';
import 'package:youapp/util/youapp_dynamic_textfield.dart';
import 'package:youapp/util/youapp_text_style.dart';
import 'package:youapp/widgets/background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/widgets/ptb_go_button.dart';
import 'package:youapp/routes/auth/auth_routes.dart';
import 'package:youapp/model/authrequest_model.dart';

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
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _getForm(),
                  ],
                ),
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
        switch (state.status) {
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
                Text('Register', style: authHeaderTextStyle),
                const SizedBox(height: 10),
                youAppTextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  hintText: "Enter Username/Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  onFieldSubmitted: (_) =>
                      fieldFocusChange(context, _emailFocus, _passwordFocus),
                ),
                const SizedBox(
                  height: 10,
                ),
                youAppTextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  hintText: "Name",
                  keyboardType: TextInputType.text,
                  validator: validateUserName,
                  onFieldSubmitted: (_) =>
                      fieldFocusChange(context, _nameFocus, _emailFocus),
                ),
                const SizedBox(height: 10),
                youAppTextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  hintText: "Enter Password",
                  keyboardType: TextInputType.visiblePassword,
                  validator: validatePassword,
                  obscureText: _hidePwd,
                  suffixIcon: InkWell(
                    child: _hidePwd
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: YouAppColor.whiteColor,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: YouAppColor.whiteColor,
                          ),
                    onTap: () => setState(() => _hidePwd = !_hidePwd),
                  ),
                  onFieldSubmitted: (_) => _passwordFocus.unfocus(),
                ),
                const SizedBox(
                  height: 10,
                ),
                youAppTextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPassFocus,
                  hintText: "Enter Confirm Password",
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validateConfirmPassword(
                      value, _confirmPasswordController.text),
                  obscureText: _hidePwd,
                  suffixIcon: InkWell(
                    child: _hideConfirmPassword
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: YouAppColor.whiteColor,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: YouAppColor.whiteColor,
                          ),
                    onTap: () => setState(
                        () => _hideConfirmPassword = !_hideConfirmPassword),
                  ),
                  onFieldSubmitted: (_) => _confirmPassFocus.unfocus(),
                ),
                const SizedBox(height: 24),
                YouAppButton(
                  key: Key('Register_Btn'),
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
                  child: DynamicYouAppAuthButton(
                      str: "Register", isButtonEnabled: isButtonEnabled),
                ),
                const SizedBox(height: 20),
                const AuthRichText(
                  str1: 'Have an account?',
                  actionText: 'Login Here',
                  route: AuthRoutes.login,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
