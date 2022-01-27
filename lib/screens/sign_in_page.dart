import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/configuration/app_text_styles.dart';
import 'package:timetable/models/country.dart';
import 'package:timetable/router/router.dart';
import 'package:timetable/blocs/utils/wait_for_state.dart';
import 'package:timetable/widgets/sign_in/country_code_input.dart';
import 'package:timetable/widgets/sign_in/login_layout.dart';
import 'package:timetable/widgets/sign_in/phone_number_input.dart';

enum SignInState {
  phone,
  code,
}

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _verificationCodeController;

  Country? _selectedCountry;
  bool _isLoading = false;
  SignInState _signInState = SignInState.phone;

  String get _fullPhoneNumber =>
      (_selectedCountry?.phoneCode ?? '') + _phoneNumberController.text;
  String get _verificationCode => _verificationCodeController.text;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _verificationCodeController = TextEditingController();
  }

  Future<void> _handleNextStep() async {
    setState(() => _isLoading = true);
    await handleNextStep();
    setState(() => _isLoading = false);
    if (_signInState == SignInState.phone) {
      setState(() {
        _signInState = SignInState.code;
        _phoneNumberController.clear();
      });
    }
  }

  Future<void> handleNextStep() async {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(_signInEvent);
    await authBloc.waitFor(_predicate);
    if (_signInState == SignInState.code) {
      context.router.push(const HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginLayout(
        formChildren: _formChildren,
        footer: _footer,
        isLoading: _isLoading,
        nextButtonLabel: _buttonText,
        onNextButtonPressed: _handleNextStep,
        isWide: _signInState == SignInState.code,
      ),
    );
  }

  List<Widget> get _formChildren {
    switch (_signInState) {
      case SignInState.code:
        return [
          Text('Введите код из смс', style: AppTexStyles.h300),
          const SizedBox(height: AppMargins.largeMargin),
          PinCodeTextField(
            controller: _verificationCodeController,
            appContext: context,
            length: 6,
            onChanged: (_) {},
          ),
        ];
      case SignInState.phone:
        return [
          CountryCodeInput(
            onCountryChanged: (country) {
              setState(() => _selectedCountry = country);
            },
          ),
          const SizedBox(height: AppMargins.smallMargin),
          PhoneNumberInput(controller: _phoneNumberController),
        ];
    }
  }

  String get inputHintText {
    switch (_signInState) {
      case SignInState.code:
        return 'Код из смс';
      case SignInState.phone:
        return 'Номер телефона';
    }
  }

  String get _buttonText {
    switch (_signInState) {
      case SignInState.code:
        return 'Далее';
      case SignInState.phone:
        return 'Отправить код';
    }
  }

  AuthEvent get _signInEvent {
    print('NUMBER: $_fullPhoneNumber');
    switch (_signInState) {
      case SignInState.code:
        return AuthConfirmPhome(_verificationCode);
      case SignInState.phone:
        return AuthLoginWithPhone(_fullPhoneNumber);
    }
  }

  bool Function(AuthState) get _predicate {
    switch (_signInState) {
      case SignInState.code:
        return (state) => state.isAuthenticated;
      case SignInState.phone:
        return (state) => state.authConfirmationResult != null;
    }
  }

  Widget get _footer {
    switch (_signInState) {
      case SignInState.code:
        return Container();
      case SignInState.phone:
        return SignInButton(
          Buttons.Google,
          onPressed: () async {
            final authBloc = context.read<AuthBloc>()
              ..add(const AuthLoginWithGoogle());
            await authBloc.waitFor((state) => state.isAuthenticated);
            context.router.push(const HomeRoute());
          },
        );
    }
  }
}
