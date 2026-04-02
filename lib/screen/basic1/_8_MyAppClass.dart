// 코드 스니펫
// 웹에서 1) html 파일에서 ,
// 느낌표 !, 아래 자동완성 코드 나와서, 뼈대 코드를 쉽게 작성

// 플러터 다트에서도, 코드 스니펫
// 간단히, 스테이리스 위젯 ,: stl 정도까지 입력하시면, 자동으로 stless 작성.
// 클래스 이름만 작성.

// 스테이트풀 : stf -> stfull
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppTest extends StatelessWidget {
  const MyAppTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // 플로팅 액션 버튼 위젯 그려보기.
        floatingActionButton: FloatingActionButton(
          onPressed: () => print('FloatingActionButton 클릭됨'),
          child: Text('클릭'),
        ),
        body: SafeArea(
          // [top] 상단 상태바(시간, 배터리 표시줄) 및 노치 영역을 회피할지 여부
          // 기본값은 true. false로 변경하면 빨간 상자가 화면 맨 위(상태바 밑)까지 파고들어갑니다.
          top: true,

          // [bottom] 아이폰 하단의 홈 인디케이터(가로줄) 영역을 회피할지 여부
          // 기본값은 true. false로 변경하면 화면 맨 아래 끝까지 위젯이 확장됩니다.
          bottom: true,

          // [left] 기기를 가로(Landscape)로 눕혔을 때 좌측 베젤/노치 영역을 회피할지 여부
          // 기본값은 true. 세로 모드일 때는 큰 의미가 없습니다.
          left: true,

          // [right] 기기를 가로(Landscape)로 눕혔을 때 우측 베젤 영역을 회피할지 여부
          // 기본값은 true.
          right: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    '오늘 점심 뭐 먹죠?',
                    style: TextStyle(
                      fontSize: 50.0,               // 글자 크기
                      fontWeight: FontWeight.w700,  // 글자 굵기
                      color: Colors.blue,           // 글자 색상
                    ),
                  ),
                ),
                // TextButton
                Center(
                  child: TextButton(
                    // 이벤트 리스너를 등록하기, 나중에 클릭시 동작하는 함수를 입력 할 예정.
                    onPressed: () {},
                    // 버튼의 스타일을 구성.
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    // 버튼의 라벨
                    child: Text('텍스트 버튼'),
                  ),
                ),
                // OutlinedButton
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.blue),
                    child: Text('아웃라인드 버튼'),
                  ),
                ),
                // ElevatedButton
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    child: Text('엘리베이티드 버튼'),
                  ),
                ),
                // IconButton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        // 아이콘 목록: https://fonts.google.com/icons
                      ),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bolt),
                        // 아이콘 목록: https://fonts.google.com/icons
                      ),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.logout),
                        // 아이콘 목록: https://fonts.google.com/icons
                      ),
                    ),
                  ],
                ),
                // GestureDetector
                Center(
                  child: GestureDetector(
                    // 기본 옵션1
                    // onTap: () => print('on tap'),
                    // onDoubleTap: () => print('on double tap'),
                    // onLongPress: () => print('on long press'),

                    // 기본 옵션2
                    // 샘플 추가 옵션 확인.
                    // 👇 여기에 자유 드래그(Pan) 옵션을 추가합니다.
                    // onPanStart: (details) {
                    //   print('드래그 시작! 위치: ${details.globalPosition}');
                    // },
                    // onPanUpdate: (details) {
                    //   // details.delta를 통해 손가락이 움직인 거리를 알 수 있습니다.
                    //   print('드래그 중... 이동 거리: ${details.delta}');
                    // },
                    // onPanEnd: (details) {
                    //   print('드래그 종료!');
                    // },

                    // 기본 옵션 3
                    // 실물 기기로, 두손가락으로 탭을 해서, 늘리거나, 줄이기 작업.
                    // 👇 Pan 대신 확대/축소(Scale) 옵션을 추가합니다.
                    onScaleStart: (details) {
                      print('확대/축소 시작!');
                    },
                    onScaleUpdate: (details) {
                      // details.scale 값이 1.0보다 크면 확대, 작으면 축소입니다.
                      print('확대/축소 중... 현재 배율: ${details.scale}');
                    },
                    onScaleEnd: (details) {
                      print('확대/축소 종료!');
                    },
                    child: Container( // 임의의 빨간 박스 넣었다 대신에, 텍스트, 버튼, 다른  UI 가능.
                      decoration: BoxDecoration(color: Colors.red),
                      width: 300.0,
                      height: 300.0,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 16.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(width: 16.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 200.0,
                  width: 100.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    border: Border.all(width: 16.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 200.0,
                  width: 100.0,
                ),
                const SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: ColoredBox(
                      color: Colors.yellow
                  ),
                ),
                // 패딩만 적용
                Container(
                  width: 200.0, height: 200.0,
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(color: Colors.red, width: 50.0, height: 50.0),
                  ),
                ),
                // 마진 + 패딩 동시 적용
                Container(
                  color: Colors.black,
                  child: Container(
                    color: Colors.blue,
                    margin: EdgeInsets.all(30.0),      // 마진: 위젯 바깥 간격
                    child: Padding(
                      padding: EdgeInsets.all(16.0),   // 패딩: 위젯 안쪽 간격
                      child: Container(color: Colors.red, width: 50.0, height: 50.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(height: 50.0, width: 50.0, color: Colors.red),
                      SizedBox(width: 12.0),
                      Container(height: 50.0, width: 50.0, color: Colors.green),
                      SizedBox(width: 12.0),
                      Container(height: 50.0, width: 50.0, color: Colors.blue),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 50.0, width: 50.0, color: Colors.red),
                      SizedBox(height: 12.0),
                      Container(height: 50.0, width: 50.0, color: Colors.green),
                      SizedBox(height: 12.0),
                      Container(height: 50.0, width: 50.0, color: Colors.blue),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,  // 전체 공간의 3/4 차지
                        child: Container(color: Colors.blue),
                      ),
                      Flexible(
                        flex: 1,  // 전체 공간의 1/4 차지
                        child: Container(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    children: [
                      Expanded(child: Container(color: Colors.yellow)),  // 1/2
                      Expanded(child: Container(color: Colors.red)),   // 1/2
                      Expanded(child: Container(color: Colors.green)),   // 1/2
                      Expanded(child: Container(color: Colors.purple)),   // 1/2
                      Expanded(child: Container(color: Colors.pink)),   // 1/2
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Stack(
                    children: [
                      Container(height: 300.0, width: 300.0, color: Colors.red),
                      Container(height: 250.0, width: 250.0, color: Colors.yellow),
                      Container(height: 200.0, width: 200.0, color: Colors.blue),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



