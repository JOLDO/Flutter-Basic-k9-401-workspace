import 'package:busanit_401_k9_flutter_project/screen/basic3-http/_2_reqres/model/reqres_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReqresUserDetailScreen extends StatelessWidget {
  final ReqresUser user;
  const ReqresUserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reqres 사용자 상세'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero( // 화면 전환 시 자연스러운 애니메이션
              tag: 'reqres_avatar_${user.id}',
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.avatar),
                onBackgroundImageError: (_, __) {},
                child: user.avatar.isEmpty
                    ? Text(user.firstName[0], style: const TextStyle(fontSize: 40))
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              user.fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Chip(
              label: Text('ID: ${user.id}'),
              backgroundColor: Colors.blue.shade50,
            ),
          ],
        ),
      ),
    );
  }
}
