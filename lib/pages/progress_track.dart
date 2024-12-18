import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../global_user.dart';

class ProgressTrackPage extends StatefulWidget {
  const ProgressTrackPage({super.key});

  @override
  State<ProgressTrackPage> createState() => _ProgressTrackPageState();
}

class _ProgressTrackPageState extends State<ProgressTrackPage> {
  final String userId = GlobalUser().userId;
  Map<String, dynamic> quizData = {};
  bool _isLocked = true;
  bool _isLoading = true;
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkParentalLock();
  }

  Future<void> _checkParentalLock() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final savedPassword = userDoc.data()?['parentalLockPassword'];
        if (savedPassword != null && savedPassword.isNotEmpty) {
          _showLockDialog(savedPassword);
        } else {
          setState(() {
            _isLocked = false;
          });
          _fetchQuizData();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching parental lock: $e')),
      );
    }
  }

  void _showLockDialog(String savedPassword) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Parental Lock Password"),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_passwordController.text == savedPassword) {
                  setState(() {
                    _isLocked = false;
                  });
                  Navigator.of(context).pop();
                  _fetchQuizData();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect password')),
                  );
                }
              },
              child: const Text("Unlock"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchQuizData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();

        setState(() {
          quizData['English'] = data?['quiz_data_english'] ?? {};
          quizData['Math'] = data?['quiz_data_math'] ?? {};
          quizData['General Knowledge'] =
              data?['quiz_data_general_knowledge'] ?? {};
          _isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching quiz data: $e')),
      );
    }
  }

  Widget _buildPieChart(String subject, Map<String, dynamic> data) {
    final pieData = data.entries
        .where((entry) => entry.key != 'train') // Exclude unwanted fields
        .map((entry) =>
            ChartData(entry.key, double.tryParse(entry.value.toString()) ?? 0))
        .toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$subject - Quiz Distribution',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SfCircularChart(
              title: ChartTitle(text: '$subject Quiz Categories'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: pieData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizChart(String subject, Map<String, dynamic> data) {
    final chartData = data.entries
        .where((entry) => entry.key != 'train') // Exclude unwanted fields
        .map((entry) =>
            ChartData(entry.key, double.tryParse(entry.value.toString()) ?? 0))
        .toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: '$subject Quiz Performance'),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                ColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLocked || _isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 33, 150, 243),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Progress Tracker')),
      body: quizData.isEmpty
          ? const Center(child: Text('No quiz data available'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: quizData.entries
                    .map((entry) => Column(
                          children: [
                            _buildPieChart(entry.key, entry.value),
                            _buildQuizChart(entry.key, entry.value),
                          ],
                        ))
                    .toList(),
              ),
            ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
