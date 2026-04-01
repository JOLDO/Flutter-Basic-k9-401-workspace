import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. 입력 값을 제어하는 컨트롤러 선언.
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('로그인 화면')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(child: FlutterLogo(size: 100)),
              const SizedBox(height: 16),
              // 2, 컨트롤러 적용하기.
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: '이메일')
              ),
              const SizedBox(height: 16),
              // 2, 컨트롤러 적용하기.
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: '패스워드')
              ),
              const SizedBox(height: 20),
              // 3. 버튼 클릭시, 이벤트 리스너 동작.
              ElevatedButton(
                // 화면 이동하는 이벤트 리스너 , 잠시 대기.
                // onPressed: () => Navigator.pushNamed(context, '/details'),
                onPressed:() {
                  // 다이얼로그창 을 이용하기.
                  // 화면 중앙에 다이얼로그 뛰우기 작업.
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('가입 정보 확인'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min, // 내용만큼만 높이 차지
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('이메일: ${emailController.text}'),
                            Text('패스워드: ${passwordController.text}'), // 마스킹 없이 실제값 출력됨
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), // 창 닫기
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
