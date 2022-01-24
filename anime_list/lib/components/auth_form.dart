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
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  Map<String, String> authData = {};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submitForm() {
    bool isValid = formKey.currentState?.validate() ?? false;
  }

  Future<bool> onWillpop() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
      return Future.value(false);
    }
    if (passwordNode.hasFocus) {
      passwordNode.unfocus();
      return Future.value(false);
    }
    if (confirmPasswordNode.hasFocus) {
      confirmPasswordNode.unfocus();
      return Future.value(false);
    }
    bool willClose = false;
    showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              "Tem certeza?",
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              "Deseja mesmo sair do app?",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  SystemNavigator.pop();
                },
                child: const Text(
                  "sim",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("nao", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        }).then((value) => willClose = value ?? false);
    return Future.value(willClose);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillpop,
      child: GestureDetector(
        onTap: () {
          if (emailNode.hasFocus) {
            emailNode.unfocus();
          }
          if (passwordNode.hasFocus) {
            passwordNode.unfocus();
          }
          if (confirmPasswordNode.hasFocus) {
            confirmPasswordNode.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Card(
            elevation: 15,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        focusNode: emailNode,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: DecorationWithLabel("email:"),
                        onSaved: (emailEntry) {
                          String email = emailEntry ?? "";
                          authData["email"] = email;
                        },
                        validator: (emailEntry) {
                          String email = emailEntry ?? "";
                          if (email.isEmpty) {
                            return "O email nao pode estar vazio";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                            return "Email Invalido";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        focusNode: passwordNode,
                        autocorrect: false,
                        enableSuggestions: false,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        obscureText: isHidePassowrd,
                        onSaved: (passordEntry) {
                          String passord = passordEntry ?? "";
                          authData["passord"] = passord;
                        },
                        validator: (passEntry) {
                          String password = passEntry ?? "";
                          if (password.isEmpty) {
                            return "A senha nâo pode estar vazia";
                          }
                          if (password.length < 8) {
                            return "A senha nao deve ser menor que 8 digitos";
                          }
                          if (!RegExp(r"(?=.*?[A-Za-z])(?=.*?[0-9])")
                              .hasMatch(password)) {
                            return "A senha deve conter letras e numeros";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidePassowrd = !isHidePassowrd;
                              });
                            },
                            icon: Icon(
                              isHidePassowrd
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
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
                              focusNode: confirmPasswordNode,
                              autocorrect: false,
                              enableSuggestions: false,
                              cursorColor:
                                  Theme.of(context).colorScheme.secondary,
                              obscureText: isHidePassowrd,
                              onSaved: (confirmationEntry) {
                                String confirmation = confirmationEntry ?? "";
                                authData["confirmation"] = confirmation;
                              },
                              validator: loginStyle == LoginStyle.LOGIN
                                  ? null
                                  : (confirmationEntry) {
                                      String confirmation =
                                          confirmationEntry ?? "";
                                      if (confirmation.isEmpty) {
                                        return "A senha nâo pode estar vazia";
                                      }
                                      if (passwordController.text !=
                                          confirmation) {
                                        return "As senhas nao coecidem";
                                      }
                                    },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isHidePassowrd = !isHidePassowrd;
                                    });
                                  },
                                  icon: Icon(
                                    isHidePassowrd
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  onTap: () {},
                                  child: Text(
                                    "Esqueci minha senha",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ElevatedButton(
                        onPressed: () {
                          submitForm();
                        },
                        child: Text(
                          loginStyle == LoginStyle.LOGIN ? "Login" : "SignUp",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(95))),
                          primary: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(95),
                              ),
                            ),
                            primary: Colors.red,
                            textStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
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
        ),
      ),
    );
  }
}
