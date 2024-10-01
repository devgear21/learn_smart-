import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnsmart/pages/chatbot_screen.dart';
import 'package:learnsmart/pages/chat_screen.dart';
import 'package:learnsmart/pages/course_option.dart';
import 'package:learnsmart/pages/progress_track.dart';
import 'package:string_similarity/string_similarity.dart';

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
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

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
            builder: (context) => ProgressTrackPage(
                userId: FirebaseAuth.instance.currentUser!.uid),
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        title: Text(
          childName != null ? 'Welcome, $childName' : 'Welcome',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
                  hintText: 'Search your topics',
                  filled: true,
                  fillColor: Colors.grey[200],
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 600 ? 2 : 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: screenWidth < 600 ? 3 / 2 : 4 / 3,
                ),
                itemCount: _getSearchResults(searchQuery).length,
                itemBuilder: (context, index) {
                  final result = _getSearchResults(searchQuery)[index];
                  return CategoryCard(
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
                          // Add functionality for rewards
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
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
            label: 'Learnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6, // Adds a subtle shadow for better visual separation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        color: color, // Keeps the original color
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.03, horizontal: screenWidth * 0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Matches card rounding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getCategoryIcon(), // Add an icon relevant to the category
                  size: screenWidth * 0.12,
                  color: Colors.white.withOpacity(0.8),
                ),
                const SizedBox(height: 10),
                Text(
                  category,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.05, // Make category name larger
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8), // Spacing between text
                Text(
                  courseCount,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize:
                        screenWidth * 0.035, // Smaller text for subheading
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    // Assign an icon based on the category for better UI clarity
    switch (category) {
      case 'Courses':
        return Icons.school;
      case 'ChatBuddy':
        return Icons.chat;
      case 'FaceBuddy':
        return Icons.face;
      case 'Rewards':
        return Icons.emoji_events;
      default:
        return Icons.category;
    }
  }
}
