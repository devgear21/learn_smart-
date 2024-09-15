import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnsmart/pages/chatbot_screen.dart';
import 'package:learnsmart/pages/conversation.dart';
import 'package:learnsmart/pages/course_option.dart';
import 'package:learnsmart/pages/progress_track.dart';
//import 'package:learnsmart/pages/avatar_screen.dart';

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
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.06,
              child: TextField(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Explore categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle 'See all' tap
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 33, 150, 243),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 600 ? 2 : 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: screenWidth < 600 ? 3 / 2 : 4 / 3,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return CategoryCard(
                      category: 'Courses',
                      courseCount: 'Explore Learning',
                      color: const Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseOption(),
                          ),
                        );
                      },
                    );
                  case 1:
                    return CategoryCard(
                      category: 'ChatBuddy',
                      courseCount: 'Interact with AI',
                      color: const Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatbotScreen(),
                            ));
                        // Add navigation or functionality for ChatBuddy
                      },
                    );
                  case 2:
                    return CategoryCard(
                      category: 'FaceBuddy',
                      courseCount: 'Talk to your Avatar',
                      color: const Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConversationScreen(),
                            ));
                        // Add navigation or functionality for FaceBuddy
                      },
                    );
                  case 3:
                    return CategoryCard(
                      category: 'Rewards',
                      courseCount: 'See your trophies!',
                      color: const Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        // Add navigation or functionality for Rewards
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
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
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                courseCount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
