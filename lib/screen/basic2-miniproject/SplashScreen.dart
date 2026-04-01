import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// stf 생성하는 방법에 대해서 기억하기.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3초 후 메인 화면으로 이동 (뒤로가기 불가)
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(child: Text('환영합니다!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            SizedBox(height: 20),
            Center(child: FlutterLogo(size: 100)),
            SizedBox(height: 20),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
