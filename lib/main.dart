
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Australian Education Institute',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;

  final List<String> menuItems = [
    'Home',
    'About Us',
    'Courses',
    'Contact Us',
  ];

  void changePage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        title: const Text(
          'Australian Education Institute',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          if (MediaQuery.of(context).size.width > 650)
            ...List.generate(menuItems.length, (index) {
              return TextButton(
                onPressed: () => changePage(index),
                child: Text(
                  menuItems[index],
                  style: TextStyle(
                    color: selectedPage == index
                        ? Colors.yellow
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            })
          else
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu),
              onSelected: changePage,
              itemBuilder: (context) {
                return List.generate(menuItems.length, (index) {
                  return PopupMenuItem<int>(
                    value: index,
                    child: Text(menuItems[index]),
                  );
                });
              },
            ),
        ],
      ),
      body: IndexedStack(
        index: selectedPage,
        children: const [
          HomePage(),
          AboutPage(),
          CoursesPage(),
          ContactPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.blue.shade900,
        padding: const EdgeInsets.all(18),
        child: const Text(
          '© 2026 Australian Education Institute | All Rights Reserved',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// HOME PAGE

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 75,
              horizontal: 20,
            ),
            color: Colors.blue.shade900,
            child: const Column(
              children: [
                Text(
                  'Welcome to Our Institute',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Learn Today, Lead Tomorrow!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          const SectionTitle(title: 'About Our Institute'),
          const Padding(
            padding: EdgeInsets.all(25),
            child: Text(
              'We provide quality education and professional courses '
              'to help students build a successful future. '
              'Our mission is to develop knowledge, skills and confidence.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          const SectionTitle(title: 'Our Featured Courses'),
          const CourseGrid(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ABOUT PAGE

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const SectionTitle(title: 'About Us'),
          const SizedBox(height: 20),
          const Text(
            'Australian Education Institute is dedicated to providing '
            'quality education and professional learning opportunities. '
            'We aim to prepare students for successful careers through '
            'practical knowledge and modern teaching methods.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 35),
          const SectionTitle(title: 'Our Mission'),
          const Text(
            'To provide quality education, encourage creativity '
            'and develop professional skills among students.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),
          const SectionTitle(title: 'Our Facilities'),
          const SizedBox(height: 15),
          const FacilityCard(
            icon: Icons.computer,
            title: 'Computer Laboratory',
            description: 'Modern computer learning facilities.',
          ),
          const FacilityCard(
            icon: Icons.library_books,
            title: 'Digital Library',
            description: 'Learning resources for students.',
          ),
          const FacilityCard(
            icon: Icons.wifi,
            title: 'Internet Facility',
            description: 'Access to online learning resources.',
          ),
          const FacilityCard(
            icon: Icons.school,
            title: 'Expert Teaching',
            description: 'Professional guidance and education.',
          ),
        ],
      ),
    );
  }
}

// COURSES PAGE

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const SectionTitle(title: 'Our Courses'),
          const SizedBox(height: 10),
          const Text(
            'Explore our professional courses and develop new skills.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          const CourseGrid(),
        ],
      ),
    );
  }
}

// CONTACT PAGE

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: Column(
            children: [
              const SectionTitle(title: 'Contact Us'),
              const SizedBox(height: 20),
              const ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: Text('Email'),
                subtitle: Text('info@example.com'),
              ),
              const ListTile(
                leading: Icon(Icons.phone, color: Colors.blue),
                title: Text('Phone'),
                subtitle: Text('+61 123 456 789'),
              ),
              const ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text('Address'),
                subtitle: Text('Australian Education Institute'),
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Enquiry Form'),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                .hasMatch(value.trim())) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: messageController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Your Message',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Your enquiry form is valid!',
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Submit Enquiry'),
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
}

// REUSABLE SECTION TITLE

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade900,
      ),
    );
  }
}

// REUSABLE COURSE GRID

class CourseGrid extends StatelessWidget {
  const CourseGrid({super.key});

  final List<Map<String, String>> courses = const [
    {
      'title': 'Flutter Development',
      'description': 'Learn mobile and web development.',
    },
    {
      'title': 'Web Development',
      'description': 'Learn modern website development.',
    },
    {
      'title': 'Computer Science',
      'description': 'Build computer fundamentals.',
    },
    {
      'title': 'Data Science',
      'description': 'Learn data analysis and technology.',
    },
    {
      'title': 'Graphic Design',
      'description': 'Develop creative design skills.',
    },
    {
      'title': 'Digital Marketing',
      'description': 'Learn online marketing strategies.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth < 600
            ? constraints.maxWidth
            : 280;

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 15,
          runSpacing: 15,
          children: courses.map((course) {
            return SizedBox(
              width: cardWidth,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        course['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course['description']!,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// REUSABLE FACILITY CARD

class FacilityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FacilityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
