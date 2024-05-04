
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/index.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormBuilderState>();
  bool isObscuredText = true;
  changeObscureTextState() {
    setState(() {
      isObscuredText = !isObscuredText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: AssetImage("assets/images/bg.avif"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(.6),
        body: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 4,
                  backgroundImage: const AssetImage("assets/images/bg.avif"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          name: 'identifiant',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Color(0xFF33BBC5),
                            labelText: 'Your unique ID',
                            labelStyle: TextStyle(
                                color: Color(0xFF33BBC5),
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Unique ID is required"),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          name: 'password',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: const Color(0xFF33BBC5),
                            suffixIcon: IconButton(
                              onPressed: changeObscureTextState,
                              icon: Icon(isObscuredText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            suffixIconColor: const Color(0xFF33BBC5),
                            labelText: 'Your password',
                            labelStyle: const TextStyle(
                                color: Color(0xFF33BBC5),
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          obscureText: isObscuredText,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Password field is required"),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GFButton(
                          size: GFSize.LARGE,
                          fullWidthButton: true,
                          type: GFButtonType.outline,
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              // navigation sur la page profil
                              Get.to(IndexPage());
                            }
                          },
                          color: const Color(0xFF33BBC5),
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
