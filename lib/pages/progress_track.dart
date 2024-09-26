import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressTrackPage extends StatefulWidget {
  final String userId;

  const ProgressTrackPage({super.key, required this.userId});

  @override
  _ProgressTrackPageState createState() => _ProgressTrackPageState();
}

class _ProgressTrackPageState extends State<ProgressTrackPage> {
  bool _isLocked = true; // Indicates whether the page is locked
  final _passwordController = TextEditingController();

  // Mocked data for progress tracking
  double productiveHours = 6.5;
  double unproductiveHours = 2.25;
  double totalScore = 79;
  String dateRange = "Today";
  double percentageChange = 3.6;

  @override
  void initState() {
    super.initState();
    _checkParentalLock();
  }

  Future<void> _checkParentalLock() async {
    // Fetch parental lock password from Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.userId)
        .get();

    String? savedPassword = snapshot.data()?['parentalLockPassword'];

    if (savedPassword != null && savedPassword.isNotEmpty) {
      _showLockDialog(savedPassword);
    } else {
      // If no password is set, allow access
      setState(() {
        _isLocked = false;
      });
    }
  }

  void _showLockDialog(String savedPassword) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog without entering the password
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Enter Parental Lock Password",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          ),
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

  @override
  Widget build(BuildContext context) {
    if (_isLocked) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Statistics",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Text(
                  dateRange,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview and Detailed Tab
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Overview",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle detailed tab change
                  },
                  child: Text(
                    "Detailed",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Logged time and breakdown
            Text(
              "Logged time",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "08h 45m",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "+ $percentageChange%",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Productive vs Unproductive
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeBox("Productive", productiveHours, Colors.blue),
                _buildTimeBox("Unproductive", unproductiveHours, Colors.red),
              ],
            ),
            const SizedBox(height: 30),
            // Score Indicator
            Center(
              child: _buildScoreIndicator(totalScore),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBox(String label, double hours, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${hours.toStringAsFixed(2)}h",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreIndicator(double score) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 12,
                color: score > 50 ? Colors.blue : Colors.red,
              ),
            ),
            Column(
              children: [
                Text(
                  score.toStringAsFixed(0),
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  score > 70 ? "Very Productive" : "Needs Improvement",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
