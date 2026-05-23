import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool freeTrialUsed = false;
  bool isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    loadTrialStatus();
  }

  void loadTrialStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      freeTrialUsed = prefs.getBool('freeTrialUsed') ?? false;
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,

        title: Row(
          children: [
            Image.asset('assets/logo.jpg', width: 40),

            const SizedBox(width: 10),

            const Text(
              "SOUND UPI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () async {
              final RenderBox button = context.findRenderObject() as RenderBox;

              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              final position = RelativeRect.fromRect(
                Rect.fromPoints(
                  button.localToGlobal(
                    Offset(button.size.width, 0),
                    ancestor: overlay,
                  ),

                  button.localToGlobal(
                    button.size.bottomRight(Offset.zero),
                    ancestor: overlay,
                  ),
                ),

                Offset.zero & overlay.size,
              );

              showMenu(
                context: context,

                position: position,

                color: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                items: [
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Profile"),
                    ),
                  ),

                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text("Language"),
                    ),
                  ),

                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About"),
                    ),
                  ),

                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                    ),
                  ),
                ],
              );
            },

            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          ),

          const SizedBox(width: 10),
        ],
      ),

      body: currentIndex == 0
          ? homeTab()
          : currentIndex == 1
          ? qrTab()
          : currentIndex == 2
          ? historyTab()
          : voiceTab(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.black,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: "Your QR",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),

          BottomNavigationBarItem(icon: Icon(Icons.volume_up), label: "Voice"),
        ],
      ),
    );
  }

  Widget homeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // VIDEO GUIDE SECTION
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0xff111111),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white24, width: 1.5),
            ),

            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),

                  child: const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Video Guide",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Watch full setup process",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(18),

              border: Border.all(color: Colors.white12, width: 1.5),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [
                    Text(
                      "Start Day",
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "15 May 2026",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Container(width: 1, height: 40, color: Colors.white12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: const [
                    Text(
                      "End Day",
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "15 June 2026",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          freeTrialUsed
              ? SizedBox(
                  width: 240,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: const Text(
                      "PREMIUM PLANS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: 250,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.setBool('freeTrialUsed', true);

                      setState(() {
                        freeTrialUsed = true;
                      });
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: const Text(
                      "FREE TRIAL • 7 DAYS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // SOUND ON BUTTON
              Stack(
                alignment: Alignment.topCenter,

                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!isPremiumUser) {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen(),
                          ),
                        );
                      } else {
                        // SOUND ON
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 61, 6, 226),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 18,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    icon: const Icon(Icons.volume_up, color: Colors.white),

                    label: const Text(
                      "SOUND ON",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  if (!isPremiumUser)
                    Positioned(
                      top: -8,

                      child: Container(
                        padding: const EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,

                          border: Border.all(color: Colors.white24),
                        ),

                        child: const Icon(
                          Icons.lock,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 22),

              // SOUND OFF BUTTON
              Stack(
                alignment: Alignment.topCenter,

                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!isPremiumUser) {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen(),
                          ),
                        );
                      } else {
                        // SOUND OFF
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 18,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    icon: const Icon(Icons.volume_off, color: Colors.white),

                    label: const Text(
                      "SOUND OFF",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  if (!isPremiumUser)
                    Positioned(
                      top: -8,

                      child: Container(
                        padding: const EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,

                          border: Border.all(color: Colors.white24),
                        ),

                        child: const Icon(
                          Icons.lock,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget qrTab() {
    return Center(
      child: Container(
        width: 260,
        height: 260,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),

        child: const Center(
          child: Icon(Icons.qr_code_2, size: 180, color: Colors.black),
        ),
      ),
    );
  }

  Widget historyTab() {
    return const Center(
      child: Text(
        "NO HISTORY",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget voiceTab() {
    return const Center(
      child: Text(
        "VOICE SETTINGS",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
