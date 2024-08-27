import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnsmart/pages/course_option.dart';
import 'package:learnsmart/pages/progress_track.dart'; // Import your progress_track.dart file

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? childName;
  String? userEmail;
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
        });
      }
    }
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Parental lock check before navigating to ProgressTrackPage
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
                  title: Text('Enter Parental Lock Password'),
                  content: TextField(
                    controller: lockController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text('Unlock'),
                      onPressed: () {
                        if (lockController.text == storedPassword) {
                          Navigator.of(context).pop(true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
    return true; // If no parental lock is set, allow access
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 150, 243),
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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child:
                  Icon(Icons.person, color: Color.fromARGB(255, 33, 150, 243)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return CategoryCard(
                      category: 'Courses',
                      courseCount: 'Explore Learning',
                      color: Color.fromARGB(255, 33, 150, 243),
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
                      color: Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        // Add navigation or functionality for ChatBuddy
                      },
                    );
                  case 2:
                    return CategoryCard(
                      category: 'FaceBuddy',
                      courseCount: 'Talk to your Avatar',
                      color: Color.fromARGB(255, 33, 150, 243),
                      onTap: () {
                        // Add navigation or functionality for FaceBuddy
                      },
                    );
                  case 3:
                    return CategoryCard(
                      category: 'Rewards',
                      courseCount: 'See your trophies!',
                      color: Color.fromARGB(255, 33, 150, 243),
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
        selectedItemColor: Color.fromARGB(255, 33, 150, 243),
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
    Key? key,
    required this.category,
    required this.courseCount,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                courseCount,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
