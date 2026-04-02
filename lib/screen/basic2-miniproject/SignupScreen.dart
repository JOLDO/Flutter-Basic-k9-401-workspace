import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 1. 상태 변수 선언 (입력 데이터 저장)
  String? _selectedGender;           // 라디오 버튼 값 (남/여 중 하나)
  bool _isKoreanSelected  = false;    // 체크박스: 한식 상태
  bool _isChineseSelected = false;    // 체크박스: 중식 상태
  bool _isJapaneseSelected = false;   // 체크박스: 일식 상태

  //========================================================
  // 이메일과 패스워드의 값을 제어하는 컨트롤러 선언
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 함수추가, 메모리 누수를 방지하는 컨트롤러 해제 함수
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //========================================================

  // 알림 메시지(SnackBar) 출력 함수
  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  // 다양한 옵션을 활용한, 스낵바 이용하기. 메서드 추가.
  void _showAdvancedSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 1. 내용물 (필수)
        content: Text(message),

        // 2. 노출 시간 (기본값은 약 4초로 꽤 깁니다. 보통 1~2초가 적당합니다.)
        duration: const Duration(seconds: 3),

        // 3. 배경색 (성공/경고/에러 상태에 따라 변경)
        backgroundColor: Colors.redAccent,

        // 4. 액션 버튼 (사용자가 즉시 행동할 수 있게 함)
        action: SnackBarAction(
          label: '되돌리기',
          textColor: Colors.white,
          onPressed: () {
            // 버튼 클릭 시 로직
            print('삭제가 취소되었습니다.');
          },
        ),

        // 5. 스타일 (플로팅 모드) - 하단에 딱 붙지 않고 떠 있는 효과
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView( // 입력 창이 많아지면 키보드에 가려질 수 있으므로 스크롤 가능한 ListView 사용
            children: [
              // [TextField] 글자 입력창
              TextField(
                // 컨트롤러 연결
                controller: _emailController,
                  decoration: InputDecoration(labelText: '이메일')
              ),
              const SizedBox(height: 16),
              // const TextField(decoration: InputDecoration(labelText: '패스워드')),
              TextField(
                // 컨트롤러 연결
                controller: _passwordController,
                // [핵심] 입력되는 텍스트를 가릴지 여부를 결정합니다.
                obscureText: true,

                // 가려지는 문자를 커스텀하고 싶을 때 사용합니다. (기본값은 '•')
                obscuringCharacter: '*',

                decoration: InputDecoration(
                  labelText: '패스워드',
                  hintText: '비밀번호를 입력하세요',
                  helperText: '영문, 숫자 포함 8자 이상', // 입력창 하단 안내문구
                ),
              ),
              const SizedBox(height: 16),
              // const TextField(decoration: InputDecoration(labelText: '패스워드 확인')),
              const TextField(
                // [핵심] 입력되는 텍스트를 가릴지 여부를 결정합니다.
                obscureText: true,

                // 가려지는 문자를 커스텀하고 싶을 때 사용합니다. (기본값은 '•')
                obscuringCharacter: '*',

                decoration: InputDecoration(
                  labelText: '패스워드확인',
                  hintText: '비밀번호를 입력하세요',
                  helperText: '영문, 숫자 포함 8자 이상', // 입력창 하단 안내문구
                ),
              ),
              const SizedBox(height: 16),

              // [RadioListTile] 성별 선택 (택 1)
              Row(
                children: [
                  // Flexible을 사용해 Row 안에서 라디오 버튼이 공간을 반씩 나눠 갖게 함
                  Flexible(child: RadioListTile<String>(
                    title: const Text('남자'),
                    value: '남자',          // 버튼이 가진 고유 값
                    groupValue: _selectedGender, // 그룹화: 현재 선택된 전역 변수
                    onChanged: (value) => setState(() {
                      _selectedGender = value; // 선택된 값을 변수에 저장하고 화면 갱신
                      // 확인 창을, 화면의 아래에서 출력을 함.
                      // _showToast(context, '성별: $_selectedGender');
                      _showAdvancedSnackBar(context, '성별: $_selectedGender');
                    }),
                  )),
                  Flexible(child: RadioListTile<String>(
                    title: const Text('여자'),
                    value: '여자',
                    groupValue: _selectedGender,
                    onChanged: (value) => setState(() {
                      _selectedGender = value;
                      // 확인 창을, 화면의 아래에서 출력을 함.
                      // _showToast(context, '성별: $_selectedGender');
                      _showAdvancedSnackBar(context, '성별: $_selectedGender');
                    }),
                  )),
                ],
              ),
              const SizedBox(height: 16),

              // [CheckboxListTile] 음식 취향 선택 (다중 선택 가능)
              CheckboxListTile(
                title: const Text('한식'),
                value: _isKoreanSelected, // 변수의 현재 상태(true/false) 연결
                onChanged: (value) => setState(() {
                  _isKoreanSelected = value ?? false; // null 방지 처리 후 상태 업데이트\
                  // 확인 창을, 화면의 아래에서 출력을 함.
                  _showToast(context, _isKoreanSelected ? '한식 선택됨' : '한식 해제됨');
                }),
              ),
              CheckboxListTile(
                title: const Text('중식'),
                value: _isChineseSelected,
                onChanged: (value) => setState(() {
                  _isChineseSelected = value ?? false;
                  _showToast(context, _isChineseSelected ? '중식 선택됨' : '중식 해제됨');
                }),
              ),
              CheckboxListTile(
                title: const Text('일식'),
                value: _isJapaneseSelected,
                onChanged: (value) => setState(() {
                  _isJapaneseSelected = value ?? false;
                  _showToast(context, _isJapaneseSelected ? '일식 선택됨' : '일식 해제됨');
                }),
              ),
              const SizedBox(height: 16),

              // [ElevatedButton] 제출 버튼
              ElevatedButton(
                onPressed: () => _showResultDialog(),
                child: const Text('회원 가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog() {
    // 다이얼로그 창 출력하는 기능 외부로 빼기.
    String food = '';
    if (_isKoreanSelected) food += '한식 ';
    if (_isChineseSelected) food += '중식 ';
    if (_isJapaneseSelected) food += '일식 ';

    // _showToast(context,
    //     '성별: ${_selectedGender ?? "선택 안됨"}\n선호 음식: ${food.isEmpty ? "선택 안됨" : food}');
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
              Text('이메일: ${_emailController.text}'),
              Text('패스워드: ${_passwordController.text}'), // 마스킹 없이 실제값 출력됨
              Text('성별: ${_selectedGender ?? "선택 안됨"}'),
              Text('선호 음식: ${food.isEmpty ? "선택 안됨" : food}'),
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
