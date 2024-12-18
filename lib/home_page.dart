import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnsmart/pages/accessibilty_settings_page.dart';
import 'package:learnsmart/pages/chatbot_screen.dart';
import 'package:learnsmart/pages/chat_screen.dart';
import 'package:learnsmart/pages/course_option.dart';
import 'package:learnsmart/pages/progress_track.dart';
import 'package:learnsmart/pages/rewards.dart';
import 'package:learnsmart/pages/feedback.dart'; // Import the Feedback page
import 'package:provider/provider.dart';
import 'package:learnsmart/accessibility_settings.dart';
import 'package:string_similarity/string_similarity.dart';
import 'global_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? childName;
  String? userEmail;
  String? profileImageUrl;
  int _selectedIndex = 0;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();
  List<Map<String, String>> categories = [
    {'title': 'Courses', 'subtitle': 'Explore Learning'},
    {'title': 'ChatBuddy', 'subtitle': 'Interact with AI'},
    {'title': 'FaceBuddy', 'subtitle': 'Talk to your Avatar'},
    {'title': 'Rewards', 'subtitle': 'See your trophies!'},
    {'title': 'Feedback', 'subtitle': 'Share your thoughts!'}, // New category
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    GlobalUser().userId = (user?.uid).toString();

    if (user != null) {
      userEmail = user.email;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          childName = snapshot.data()?['name'];
          profileImageUrl = snapshot.data()?['profileImageUrl'];
        });
      }
    }
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      bool isUnlocked = await _checkParentalLock(context);
      if (isUnlocked) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProgressTrackPage(),
          ),
        );
      }
    }
  }

  Future<bool> _checkParentalLock(BuildContext context) async {
    TextEditingController lockController = TextEditingController();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists && snapshot.data()?['parentalLock'] != null) {
        String storedPassword = snapshot.data()?['parentalLock'];

        return await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Enter Parental Lock Password'),
                  content: TextField(
                    controller: lockController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text('Unlock'),
                      onPressed: () {
                        if (lockController.text == storedPassword) {
                          Navigator.of(context).pop(true);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Incorrect password'),
                          ));
                          Navigator.of(context).pop(false);
                        }
                      },
                    ),
                  ],
                );
              },
            ) ??
            false;
      }
    }
    return true;
  }

  void _showProfileImage(BuildContext context) {
    if (profileImageUrl != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.network(profileImageUrl!),
          ),
        ),
      );
    }
  }

  // Search logic
  List<Map<String, String>> _getSearchResults(String query) {
    if (query.isEmpty) return categories;
    return categories
        .where((category) =>
            category['title']!.toLowerCase().contains(query.toLowerCase()) ||
            category['title']!.toLowerCase().similarityTo(query.toLowerCase()) >
                0.4)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AccessibilitySettings>(context);

    // Accessibility settings
    final fontFamily = settings.dyslexiaFriendly ? 'OpenDyslexic' : 'Poppins';

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: settings.highContrast ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: settings.highContrast
            ? Colors.black
            : const Color.fromARGB(255, 33, 150, 243),
        title: Text(
          childName != null ? 'Welcome, $childName' : 'Welcome',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: fontFamily,
            color: settings.highContrast ? Colors.yellow : Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => _showProfileImage(context),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!)
                    : null,
                child: profileImageUrl == null
                    ? const Icon(Icons.person,
                        color: Color.fromARGB(255, 33, 150, 243))
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.06,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search your field',
                  hintStyle: TextStyle(
                    fontFamily: fontFamily,
                  ),
                  filled: true,
                  fillColor:
                      settings.highContrast ? Colors.black : Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _getSearchResults(searchQuery).length,
                itemBuilder: (context, index) {
                  final result = _getSearchResults(searchQuery)[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CategoryCard(
                      category: result['title']!,
                      courseCount: result['subtitle']!,
                      color: const Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        switch (result['title']) {
                          case 'Courses':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CourseOption(),
                              ),
                            );
                            break;
                          case 'ChatBuddy':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatbotScreen(),
                              ),
                            );
                            break;
                          case 'FaceBuddy':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              ),
                            );
                            break;
                          case 'Rewards':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RewardsPage(),
                              ),
                            );
                            break;
                          case 'Feedback': // New Feedback case
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeedbackPage(),
                              ),
                            );
                            break;
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AccessibilitySettingsPage()),
          );
        },
        backgroundColor: settings.highContrast
            ? Colors.black
            : const Color.fromARGB(255, 33, 150, 243),
        child: Icon(
          Icons.settings_accessibility,
          color: settings.highContrast ? Colors.yellow : Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 33, 150, 243),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final String courseCount;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.courseCount,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                _getCategoryIcon(),
                size: screenWidth * 0.1,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      courseCount,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (category) {
      case 'Courses':
        return Icons.school;
      case 'ChatBuddy':
        return Icons.chat;
      case 'FaceBuddy':
        return Icons.face;
      case 'Rewards':
        return Icons.emoji_events;
      case 'Feedback':
        return Icons.feedback; // Icon for Feedback
      default:
        return Icons.category;
    }
  }
}
