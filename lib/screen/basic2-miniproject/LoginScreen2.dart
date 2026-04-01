import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {

  // 순서1, 컨트롤러를 정의하기.
  // 이메일과 패스워드의 값을 제어하는 컨트롤러 선언
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 순서2, (자원반납)화면이 제거 될 경우, 컨트롤러 객체를 메모리 해제하기,
  // 함수추가, 메모리 누수를 방지하는 컨트롤러 해제 함수
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // 순서3, 화면에 컨트롤러 붙이기 작업

  // 순서4, 이벤트 리스너 작업.



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인 화면2, 스테이트풀 위젯 버전')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(child: FlutterLogo(size: 100)),
              const SizedBox(height: 16),
              // 순서3, 화면에 컨트롤러 붙이기 작업
              // 2, 컨트롤러 적용하기.
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: '이메일')
              ),
              const SizedBox(height: 16),
              // 순서3, 화면에 컨트롤러 붙이기 작업
              // 2, 컨트롤러 적용하기.
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: '패스워드')
              ),
              const SizedBox(height: 20),
              // 순서4, 이벤트 리스너 작업.
              // 3. 버튼 클릭시, 이벤트 리스너 동작.
              ElevatedButton(
                // 화면 이동하는 이벤트 리스너 , 잠시 대기.
                // onPressed: () => Navigator.pushNamed(context, '/details'),
                // 리팩토링 , 함수를 따로 아래에 분리.
                onPressed:() => _showResultDialog(),
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 다이얼로그창을 함수 분리. 리팩토링.
void _showResultDialog() {
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
}
}
