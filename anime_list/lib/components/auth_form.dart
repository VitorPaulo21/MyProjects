import 'package:anime_list/components/input_decoration_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum LoginStyle { LOGIN, SIGNUP }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isHidePassowrd = true;
  LoginStyle loginStyle = LoginStyle.LOGIN;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 15,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: DecorationWithLabel("email:"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                obscureText: isHidePassowrd,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidePassowrd = !isHidePassowrd;
                      });
                    },
                    icon: Icon(Icons.visibility),
                  ),
                  label: const Text(
                    "senha:",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (loginStyle == LoginStyle.SIGNUP)
                Column(
                  children: [
                    TextFormField(
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      obscureText: isHidePassowrd,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidePassowrd = !isHidePassowrd;
                            });
                          },
                          icon: Icon(Icons.visibility),
                        ),
                        label: const Text(
                          "repetir senha:",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              if (loginStyle == LoginStyle.LOGIN)
                Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Esqueci minha senha",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  loginStyle == LoginStyle.LOGIN ? "Login" : "SignUp",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(95))),
                  primary: Theme.of(context).colorScheme.secondary,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.red,
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
                onPressed: () {
                  setState(() {
                    if (loginStyle == LoginStyle.LOGIN) {
                      loginStyle = LoginStyle.SIGNUP;
                    } else {
                      loginStyle = LoginStyle.LOGIN;
                    }
                  });
                },
                child: Text(
                  loginStyle == LoginStyle.LOGIN
                      ? "Deseja criar um conta?"
                      : "Já possuo uma conta",
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
