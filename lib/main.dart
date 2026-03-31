// 1. 플러터의 머티리얼 디자인(Material Design)
// UI 위젯들을 사용하기 위해 패키지를 불러옵니다.
import 'package:flutter/material.dart';

// 2. 앱이 실행될 때 가장 먼저 호출되는 진입점(Entry Point) 함수입니다.
void main() {
  // 3. runApp()은 플러터 프레임워크에게
  // "이 위젯을 화면에 그려라"라고 명령하는 함수입니다.
  runApp(
    // 4. MaterialApp: 머티리얼 디자인 스타일의
    // 앱을 만들기 위한 최상위 껍데기(설정) 위젯입니다.
    MaterialApp(
      // 5. home: 앱이 실행될 때
      // 가장 먼저 화면에 보여줄 기본 위젯을 지정합니다.
      // 6. Scaffold: 앱의 기본 화면 구조(도화지 역할)를 잡아주는 위젯입니다.
      home: Scaffold(
        // 7. body: 화면의 메인 콘텐츠가 들어갈 공간입니다.
        body: Center(  // 8. Center: 자식(child) 위젯을 화면의 정중앙에 배치하는 레이아웃 위젯입니다.
          // 9. child: Center 위젯 안에 들어갈 단일 자식 위젯을 지정합니다.
          child: Text( // 10. Text: 화면에 글자를 보여주는 위젯입니다.
            '!!오늘 점심 뭐먹죠? 텍스트 변경하고, 화면을 변경, 핫리로드 클릭.~~ ',
          ),
        ),
      ),
    ),
  );
}