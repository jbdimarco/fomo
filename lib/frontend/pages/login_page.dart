import 'package:flutter/material.dart';
import 'package:project_fomo/frontend/pages/root_page.dart';
import 'package:provider/provider.dart';
import 'package:project_fomo/backend/state_models/login_model.dart';
import 'package:project_fomo/frontend/components/input_field.dart';
import 'package:project_fomo/frontend/components/gradient_button.dart';
import 'package:project_fomo/frontend/components/login_page_header.dart';
import 'package:project_fomo/backend/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  static const String pageRoute = '/login';

  @override
  Widget build(BuildContext context) {
    String _email;
    String _password;

    InputField emailInput =
        InputField('Email or Username', Icons.person, (String input) {
      _email = input;
    });
    InputField passwordInput =
        InputField('Password', Icons.lock, (String input) {
      _password = input;
    }, true);

    return ChangeNotifierProvider(
      create: (_) => LoginModel(
        authenticator: Provider.of<AuthService>(context),
      ),
      child: Consumer<LoginModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 40, left: 15, right: 15, top: 30),
                child: model.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          loginPageHeader('Log In'),
                          SizedBox(height: 60),
                          emailInput,
                          SizedBox(height: 30),
                          passwordInput,
                          SizedBox(
                            height: 50,
                          ),
                          GradientButton(
                            buttonText: 'Log In',
                            buttonPressed: () async {
                              bool success =
                                  await model.login(_email, _password);
                              if (success) {
                                Navigator.pushNamed(
                                    context, RootPage.pageRoute);
                              }
                            },
                          ),
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
