import 'package:busanit_401_k9_flutter_project/screen/basic3-http/_2_reqres/screen/reqres_user_detail_screen.dart';
import 'package:flutter/material.dart';

import '../model/reqres_user.dart';
import '../service/reqres_service.dart';


class ReqresScreen extends StatefulWidget {
  const ReqresScreen({super.key});
  @override
  State<ReqresScreen> createState() => _ReqresScreenState();
}

class _ReqresScreenState extends State<ReqresScreen> {
  late Future<List<ReqresUser>> _usersFuture;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _usersFuture = ReqresService.fetchUsers(page: _currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reqres 사용자 목록'),
        actions: [
          // 이전 페이지
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1
                ? () {
              setState(() => _currentPage--);
              _loadUsers();
            }
                : null,
          ),
          // 현재 페이지 표시
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('$_currentPage 페이지',
                  style: const TextStyle(fontSize: 14)),
            ),
          ),
          // 다음 페이지
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() => _currentPage++);
              _loadUsers();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ReqresUser>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          // 로딩 중
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 오류
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('오류: ${snapshot.error}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loadUsers,
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }
          // 빈 데이터
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('사용자가 없습니다.'));
          }

          final users = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: users.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                // 탭을 했을 경우, 이벤트 핸들러 효과 추가하기.
                onTap: () {
                  Navigator.push(context, // 알아두기, 따로 , 라우팅 하는 방법
                      MaterialPageRoute(
                          builder: (context) => ReqresUserDetailScreen(user: user))
                  );
                },

                // 아바타 이미지: 네트워크 이미지 로드
                leading: Hero(
                  tag: 'reqres_avatar_${user.id}',
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(user.avatar),
                    // 이미지 로딩 전 플레이스홀더
                    onBackgroundImageError: (_, __) {},
                    child: user.avatar.isEmpty
                        ? Text(user.firstName[0]) // 이미지 없을 때 이니셜
                        : null,
                  ),
                ),
                title: Text(
                  user.fullName, // firstName + lastName
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(user.email),
                trailing: Chip(
                  label: Text('#${user.id}'),
                  backgroundColor: Colors.blue.shade50,
                ),
              );
            },
          );
        },
      ),
    );
  }
}