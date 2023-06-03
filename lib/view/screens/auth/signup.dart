// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/provider/auth_provider.dart';
import 'package:place_order/provider/product_provider.dart';
import 'package:place_order/routes.dart';
import 'package:place_order/view/base/custom_button.dart';
import 'package:place_order/view/base/custom_text_form_field.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(authProvider);
          return SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          isPassword: true,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be longer than 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        provider.isLoading == true
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    bool isSuccess = await provider
                                        .signUpWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
                                    );
                                    if (isSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              'Account created successfully'),
                                        ),
                                      );
                                      Navigator.pushNamed(
                                          context, Routes.dashboard);
                                      await ref
                                          .read(productProvider)
                                          .getProducts();
                                      await ref
                                          .read(productProvider)
                                          .getCartProducts(userId: 1);
                                    }
                                  }
                                },
                                buttonText: 'Sign Up',
                                height: 50,
                                width: double.infinity,
                              ),
                        const SizedBox(height: 80),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do you have an account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.login);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 16,
                                    fontWeight: FontWeight
                                        .w500 // Specify the color for 'Order'
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
