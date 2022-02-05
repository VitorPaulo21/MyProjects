import 'package:anime_list/components/input_decoration_white.dart';
import 'package:anime_list/models/user_profile.dart';
import 'package:anime_list/providers/anime_list.dart';
import 'package:anime_list/providers/auth.dart';
import 'package:anime_list/providers/user_profile_provider.dart';
import 'package:anime_list/utils/app_routes.dart';
import 'package:anime_list/utils/check_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginStyle { LOGIN, SIGNUP, RECUPERATION }

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
  GlobalKey<FormState> passRecuperationKey = GlobalKey<FormState>();
  String recuperationEmail = "";
  bool isLoading = false;

  void submitForm() async {
    Auth auth = Provider.of<Auth>(context, listen: false);
    if (loginStyle == LoginStyle.RECUPERATION) {
      bool isValid = passRecuperationKey.currentState?.validate() ?? false;
      if (isValid) {
        passRecuperationKey.currentState?.save();
        bool hasNoError = true;
        try {
          bool connected = await CheckConnection.isConnected();
          if (connected) {
            await auth.forgotPassword(recuperationEmail);
          } else {
            showSnackbar(context, text: "Sem conexão a Internet");
            return;
          }
        } on FirebaseAuthException catch (e) {
          hasNoError = false;
          if (e.code == "user-not-found") {
            showSnackbar(context, text: "Usuario Não Encontrado");
          }
          if (e.code == "invalid-email") {
            showSnackbar(context, text: "Email Inválido");
          }
        } catch (e) {
          print(e);
        } finally {
          Navigator.of(context).pop();
          setState(() {
            loginStyle = LoginStyle.LOGIN;
          });
        }
        if (hasNoError) {
          showSnackbar(context, text: "Enviado!");
        }
      }
    }
    bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      formKey.currentState?.save();
      try {
        SharedPreferences sharedData = await SharedPreferences.getInstance();
        await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Quase lá"),
                content: const Text("Deseja salvar os seus dados de login?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        "Sim",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        "Não",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              );
            }).then((wilSave) {
          if (wilSave ?? false) {
            sharedData.setString("email", authData["email"] ?? "");
            sharedData.setString("password", authData["password"] ?? "");
          } else {
            sharedData.setString("email", "");
            sharedData.setString("password", "");
          }
        });
        bool connected = await CheckConnection.isConnected();
        if (connected) {
          await auth.Autenticate(loginStyle, authData);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.NO_CONNECTION);
          return;
        }
        if (FirebaseAuth.instance.currentUser != null) {
          await Provider.of<UserProfileProvider>(context, listen: false)
              .setUserProfile();
          if (loginStyle == LoginStyle.SIGNUP) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.USER_DETAILS_EDIT);
          } else {
            if (!Provider.of<UserProfileProvider>(context, listen: false)
                .isvalidUser()) {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.USER_DETAILS_EDIT);
            } else {
              await Provider.of<AnimeList>(context, listen: false)
                  .getAnimes(context);
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            }
          }
        } else {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text("Alerta"),
                  content: const Text(
                      "Um erro aconteceu por favor entre em contato com o suporte"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "ok",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                );
              });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.code);
        if (e.code == 'weak-password') {
          showSnackbar(context, text: "A senha é muito fraca");
        } else if (e.code == 'email-already-in-use') {
          showSnackbar(context, text: "Este email ja esta em uso");
        } else if (e.code == 'user-not-found') {
          showSnackbar(context, text: "Usuarion Não Encontrado");
        } else if (e.code == 'wrong-password') {
          showSnackbar(context, text: "O email ou senha estão incorretos");
        } else if (e.code == 'user-disabled') {
          showSnackbar(context, text: "Conta temporariamente Indisponível");
        } else {
          print(e.code);
        }
      }
    }
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
              height: isLoading ? 250 : null,
              width: MediaQuery.of(context).size.width * 0.7,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            focusNode: emailNode,
                            cursorColor:
                                Theme.of(context).colorScheme.secondary,
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
                            onFieldSubmitted: (text) => submitForm(),
                            controller: passwordController,
                            focusNode: passwordNode,
                            autocorrect: false,
                            enableSuggestions: false,
                            cursorColor:
                                Theme.of(context).colorScheme.secondary,
                            obscureText: isHidePassowrd,
                            textInputAction: TextInputAction.go,
                            onSaved: (passordEntry) {
                              String passord = passordEntry ?? "";
                              authData["password"] = passord;
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
                                    String confirmation =
                                        confirmationEntry ?? "";
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
                                      onTap: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Esqueci minha senha!"),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                        "Insira seu email para enviarmos a redefinião de senha"),
                                                    Form(
                                                      key: passRecuperationKey,
                                                      child: TextFormField(
                                                        decoration:
                                                            DecorationWithLabel(
                                                                'Email:'),
                                                        validator: (value) {
                                                          String email =
                                                              value ?? "";
                                                          if (email.isEmpty) {
                                                            return "email vazio";
                                                          }
                                                          if (!RegExp(
                                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                              .hasMatch(
                                                                  email)) {
                                                            return "Email Invalido";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          String email = value!;
                                                          recuperationEmail =
                                                              "";
                                                          recuperationEmail =
                                                              email;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                          "cancelar",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                  TextButton(
                                                    onPressed: () {
                                                      loginStyle = LoginStyle
                                                          .RECUPERATION;
                                                      submitForm();
                                                    },
                                                    child: const Text("Enviar",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: const Text(
                                        "Esqueci minha senha",
                                        style: TextStyle(color: Colors.white),
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
                              loginStyle == LoginStyle.LOGIN
                                  ? "Login"
                                  : "SignUp",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                                primary: Colors.white,
                                textStyle:
                                    const TextStyle(color: Colors.white)),
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

  void showSnackbar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[850],
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
