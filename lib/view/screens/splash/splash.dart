import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/routes.dart';
import 'package:place_order/services/local_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Place',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' Order',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold // Specify the color for 'Order'
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadData() async {
    String? token = await ref.read(localStorageProvider).getToken();
    if (token != null) {
      Navigator.pushNamed(context, Routes.dashboard);
    } else {
      Navigator.pushNamed(context, Routes.login);
    }
  }
}
