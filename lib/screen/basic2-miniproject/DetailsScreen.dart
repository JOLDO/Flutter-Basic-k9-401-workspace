import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // 순서2, 로그인 화면에서, 전달한 데이터를 받기
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('상세 화면')),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(30.0),
              color: Colors.blue,
              child: Center(
                child: ListView(
                  children: [
                    Text(
                        args['title'],
                      style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '임시 ID : ${args['id']} 번 데이터 정보 받기 '
                    ),
                    Text(
                        '임시 email : ${args['email']} '
                    ),
                    Text(
                        '임시 password : ${args['password']} '
                    ),  Text(
                        '임시 ID : ${args['id']} 번 데이터 정보 받기 '
                    ),
                    Text(
                        '임시 email : ${args['email']} '
                    ),
                    Text(
                        '임시 password : ${args['password']} '
                    ),  Text(
                        '임시 ID : ${args['id']} 번 데이터 정보 받기 '
                    ),
                    Text(
                        '임시 email : ${args['email']} '
                    ),
                    Text(
                        '임시 password : ${args['password']} '
                    ),
                  ],
                ),
              ),
            ),

            // 리스트뷰 복사3, 스크롤 방향을 가로 방향으로 변경하고,
            // 이미지를 이용해보기,
            buildHorizontalImageList("샘플이미지 리스트뷰1"),
            // 리스트뷰 복사3

            // 리스트 뷰 빌더 예시 복사
            // 수정, Expanded 제거하고,
            // 내부 리스트에 shrinkWrap: true와
            // physics: const NeverScrollableScrollPhysics()를 추가하여 부모 스크롤에 포함시키기
            SizedBox(
              height: 300,
              child: ListView.builder(
                // shrinkWrap: true, // [중요] 내부 리스트가 필요한 만큼만 높이 차지
                // physics: const NeverScrollableScrollPhysics(), // [중요] 부모 스크롤 사용
                padding: const EdgeInsets.all(8),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Card( // 카드 형태의 디자인 적용
                    child: ListTile(
                      leading: const Icon(Icons.notifications_active, color: Colors.blue),
                      title: Text('[$index] Flutter 수업 안내'),
                      subtitle: const Text('내일은 리스트뷰 심화 과정입니다.'),
                      onTap: () {
                        // 클릭 시 피드백 알림
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$index번 공지를 확인했습니다.')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            //리스트 뷰 빌더 예시 복사


            // 리스트뷰 복사3, 스크롤 방향을 가로 방향으로 변경하고,
            // 이미지를 이용해보기,
            buildHorizontalImageList("샘플이미지 리스트뷰2"),
            // 리스트뷰 복사3

            // 리스트뷰 복사2
            SizedBox(
              height: 300,
              child: ListView.builder(
                // shrinkWrap: true, // [중요] 내부 리스트가 필요한 만큼만 높이 차지
                // physics: const NeverScrollableScrollPhysics(), // [중요] 부모 스크롤 사용
                itemCount: 20, // 총 20개의 아이템을 만들겠다!
                itemBuilder: (context, index) {
                  // index는 0부터 19까지 자동으로 증가합니다.
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('$index번 수강생님, 환영합니다!'),
                    subtitle: Text('오늘도 열공하세요.'),
                    trailing: Icon(Icons.check),
                  );
                },
              ),
            ),
            // 리스트뷰 복사2

            // 리스트뷰 복사3
            SizedBox(
              height: 300,
              child: ListView.separated(
                // shrinkWrap: true, // [중요] 내부 리스트가 필요한 만큼만 높이 차지
                // physics: const NeverScrollableScrollPhysics(), // [중요] 부모 스크롤 사용
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(title: Text('아이템 $index')),
                // 각 아이템 사이에 들어갈 위젯을 정해줍니다.
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            // 리스트뷰 복사3

            // 리스트뷰 복사4, 스크롤 방향을 가로 방향으로 변경하고,
            // 이미지를 이용해보기,
            buildHorizontalImageList("샘플이미지 리스트뷰3"),
            // 리스트뷰 복사4

            SizedBox(
              height: 300,
              child: ListView(
                // shrinkWrap: true, // [중요] 내부 리스트가 필요한 만큼만 높이 차지
                // physics: const NeverScrollableScrollPhysics(), // [중요] 부모 스크롤 사용
                children: List.generate(
                  20,
                      (index) => ListTile(
                    leading: const FlutterLogo(),
                    title: Text('항목 $index'),
                    subtitle: const Text('상세 설명'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalImageList(String label){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsetsGeometry.all(8.0),
            child : Text(label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ,)
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            // 중요, 기본 나열 방식이 세로 방향이 기본값인데,
            // 가로 방향 옵션으로 변경.
            scrollDirection: Axis.horizontal,
            // padding: const EdgeInsets.all(8),
            itemCount: 6,
            itemBuilder: (context, index) {
              // index : 0 ~ 부터 시작
              int imageNumber = index + 1;
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/logo${imageNumber}.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
      ],
    );

  }

}
