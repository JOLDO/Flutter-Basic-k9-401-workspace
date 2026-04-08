import 'package:flutter/material.dart';

import '../model/Note.dart';
import '../service/DatabaseHelper.dart';

class DbBasicScreen extends StatefulWidget {
  const DbBasicScreen({super.key});
  @override
  State<DbBasicScreen> createState() => _DbBasicScreenState();
}

class _DbBasicScreenState extends State<DbBasicScreen> {
  final DatabaseHelper _db = DatabaseHelper();

  List<Note> _notes = [];
  int _totalCount = 0;
  int _currentPage = 0;
  static const int _pageSize = 10; // 페이지당 항목 수

  String _keyword = '';
  bool _showSearch = false;          // 검색창 표시 여부
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // 노트 목록 + 전체 건수 로드
  Future<void> _load() async {
    final notes = await _db.getNotes(
      keyword: _keyword,
      limit: _pageSize,
      offset: _currentPage * _pageSize,
    );
    final count = await _db.getCount(keyword: _keyword);
    setState(() {
      _notes = notes;
      _totalCount = count;
    });
  }

  // 총 페이지 수
  int get _totalPages => (_totalCount / _pageSize).ceil().clamp(1, 9999);

  // ── 추가 / 수정 다이얼로그 ─────────────────────────────
  Future<void> _showNoteDialog({Note? note}) async {
    final isEdit = note != null;
    final titleCtrl = TextEditingController(text: note?.title ?? '');
    final contentCtrl = TextEditingController(text: note?.content ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? '노트 수정' : '노트 추가'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentCtrl,
              decoration: const InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleCtrl.text.trim();
              final content = contentCtrl.text.trim();
              if (title.isEmpty) return;
              if (isEdit) {
                // 기존 노트 수정: copyWith로 변경 필드만 교체
                await _db.updateNote(
                    note.copyWith(title: title, content: content));
              } else {
                // 새 노트 추가
                await _db.insertNote(Note(
                  title: title,
                  content: content,
                  createdAt: DateTime.now().toIso8601String(),
                ));
                _currentPage = 0; // 추가 후 첫 페이지로
              }
              if (ctx.mounted) Navigator.pop(ctx);
              _load();
            },
            child: Text(isEdit ? '수정' : '추가'),
          ),
        ],
      ),
    );
  }

  // ── 삭제 확인 다이얼로그 ──────────────────────────────
  Future<void> _confirmDelete(Note note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('"${note.title}"을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('삭제', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _db.deleteNote(note.id!);
      // 마지막 페이지의 마지막 항목 삭제 시 이전 페이지로 이동
      if (_notes.length == 1 && _currentPage > 0) _currentPage--;
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar ─────────────────────────────────────────
      // ── AppBar ─────────────────────────────────────────
      appBar: AppBar(
        titleSpacing: 0,
        title: _showSearch
            ? Container(
          margin: const EdgeInsets.symmetric(horizontal: 12), // 좌우 여백 확보
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, // ⚪ 배경색: 흰색
            borderRadius: BorderRadius.circular(8), // 둥근 모서리
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchCtrl,
            autofocus: true,
            textAlignVertical: TextAlignVertical.center,
            // ⚫ 입력 글자 스타일: 검정색
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              textBaseline: TextBaseline.alphabetic,
            ),
            decoration: InputDecoration(
              hintText: '검색어 입력...',
              // 힌트 글자 스타일: 흐린 회색
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
            ),
            cursorColor: Colors.blue, // 커서 색상
            onChanged: (v) {
              setState(() {
                _keyword = v;
                _currentPage = 0;
              });
              _load();
            },
          ),
        )
            : const Text('내부 DB 기초'),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) {
                  _searchCtrl.clear();
                  _keyword = '';
                  _currentPage = 0;
                  _load();
                }
              });
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // ── 검색 결과 배너 ────────────────────────────
          if (_keyword.isNotEmpty)
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: Colors.blue.shade50,
              child: Text(
                '"$_keyword" 검색 결과: $_totalCount건',
                style:
                TextStyle(color: Colors.blue.shade700, fontSize: 13),
              ),
            ),

          // ── 노트 목록 ─────────────────────────────────
          Expanded(
            child: _notes.isEmpty
                ? const Center(child: Text('노트가 없습니다.'))
                : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: _notes.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1),
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(
                    note.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        note.createdAt.substring(0, 10),
                        style: const TextStyle(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 수정 버튼
                      IconButton(
                        icon: const Icon(Icons.edit,
                            color: Colors.blue),
                        onPressed: () =>
                            _showNoteDialog(note: note),
                      ),
                      // 삭제 버튼
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red),
                        onPressed: () => _confirmDelete(note),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ── 페이지네이션 바 ───────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(
                  top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 이전 페이지
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _currentPage > 0
                      ? () {
                    setState(() => _currentPage--);
                    _load();
                  }
                      : null,
                ),
                // 현재 페이지 / 전체 페이지 표시
                Text(
                  '${_currentPage + 1} / $_totalPages  (전체 $_totalCount건)',
                  style: const TextStyle(fontSize: 13),
                ),
                // 다음 페이지
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _currentPage < _totalPages - 1
                      ? () {
                    setState(() => _currentPage++);
                    _load();
                  }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),

      // ── 추가 버튼 (FAB) ────────────────────────────────
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        tooltip: '노트 추가',
        child: const Icon(Icons.add),
      ),
    );
  }
}