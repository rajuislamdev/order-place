import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/routes.dart';
import 'package:place_order/services/local_storage.dart';
import 'package:place_order/view/base/custom_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Center(
        child: SizedBox(
          height: 45,
          child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.login);
                ref.read(localStorageProvider).removeToken();
              },
              buttonText: 'Logout'),
        ),
      ),
    );
  }
}
