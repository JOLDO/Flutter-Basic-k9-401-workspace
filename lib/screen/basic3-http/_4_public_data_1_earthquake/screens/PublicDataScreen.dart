import 'package:flutter/material.dart';
import '../models/EarthquakeInfo.dart';
import '../services/EarthquakeApiService.dart';

class PublicDataScreen extends StatefulWidget {
  const PublicDataScreen({super.key});
  @override
  State<PublicDataScreen> createState() => _PublicDataScreenState();
}

class _PublicDataScreenState extends State<PublicDataScreen> {
  late Future<List<EarthquakeInfo>> _earthquakeFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _earthquakeFuture = EarthquakeApiService.fetchEarthquakes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공공데이터 - 지진정보'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: FutureBuilder<List<EarthquakeInfo>>(
        future: _earthquakeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('오류: ${snapshot.error}'),
                  ElevatedButton(onPressed: _loadData, child: const Text('재시도')),
                ],
              ),
            );
          }
          // 3. 데이터 없음 (3일 내 지진 없음)
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 64, color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    '최근 3일간 지진이 없습니다 😊',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '지진 발생 시 자동으로 목록이 표시됩니다.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          final earthquakes = snapshot.data!;
          return ListView.builder(
            itemCount: earthquakes.length,
            itemBuilder: (context, index) {
              final eq = earthquakes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                    eq.magnitude >= 3.0 ? Colors.red : Colors.orange,
                    child: Text(
                      eq.magnitude.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  title: Text(eq.location),
                  subtitle: Text(eq.originTime),
                  trailing: Text('진원: ${eq.depth}km'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}