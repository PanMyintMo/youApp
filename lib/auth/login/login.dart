import 'package:flutter/material.dart';
import 'package:youapp/enum/status.dart';
import 'package:youapp/login/login_bloc.dart';
import 'package:youapp/response/authresponse.dart';
import 'package:youapp/routes/auth/auth_routes.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/validator.dart';
import 'package:youapp/widgets/background.dart';
import 'package:youapp/widgets/ptb_go_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp/model/authrequest_model.dart';
import 'package:youapp/util/youapp_text_style.dart';
import 'package:youapp/auth/authutil/youapprichtext.dart';
import 'package:youapp/auth/authutil/youapptextbutton.dart';
import 'package:youapp/util/youapp_dynamic_textfield.dart';

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
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      switch (state.addStatus) {
        case Status.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );

        case Status.success:
          loginResponse = state.response;
          break;

        case Status.failed:
          return const Center(
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
              Text('Login',
                  key: Key('login_header'), style: authHeaderTextStyle),
              const SizedBox(height: 10),
              youAppTextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                hintText: "Name",
                keyboardType: TextInputType.text,
                validator: validateUserName,
                onFieldSubmitted: (_) =>
                    fieldFocusChange(context, _nameFocus, _emailFocus),
              ),
              const SizedBox(height: 8),
              youAppTextFormField(
                key: const Key('emailField'),
                controller: _emailController,
                focusNode: _emailFocus,
                hintText: "Enter Username/Email",
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                onFieldSubmitted: (_) =>
                    fieldFocusChange(context, _emailFocus, _passwordFocus),
              ),
              youAppTextFormField(
                key: Key('passwordField'),
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
              const SizedBox(height: 24),
              YouAppButton(
                key: Key('login_button'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginRequestEvent(
                        loginRequestModel: AuthRequestModel(
                            username: _nameController.text.toString(),
                            password: _passwordController.text.toString(),
                            email: _emailController.text.toString())));
                  }
                },
                isEnabled: isButtonEnabled,
                child: DynamicYouAppAuthButton(
                    str: "Login", isButtonEnabled: isButtonEnabled),
              ),
              const SizedBox(height: 20),
              const AuthRichText(
                str1: 'No account?',
                actionText: 'Register here',
                route: AuthRoutes.register,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }
}
