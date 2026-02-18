import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  bool isOnline = true;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// PROFILE CARD
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 4, // shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Profile Image
                          const CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage('assets/images/professional/imgas.jpg'),
                          ),
                          const SizedBox(width: 14),

                          // Name & Profession
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Joseph Roldan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text("Professional"),
                              ],
                            ),
                          ),

                          // Notification Button
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Card(
                    elevation: 4, // shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // নাম ও পেশা
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Joseph Roldan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text("Professional"),
                              ],
                            ),
                          ),
                          // Online switch
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: isOnline,
                                onChanged: (v) {
                                  setState(() => isOnline = v);
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 14),

            /// STATS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: statCard('assets/images/professional/chart.png', "Today", "120"),
                ),
                Expanded(
                  child: statCard('assets/images/professional/checkbox.png', "Jobs", "300"),
                ),
                Expanded(
                  child: statCard('assets/images/professional/star.png', "Rating", "50"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// ACTIVE JOBS
            titleRow("Active Jobs"),
            jobCard("Michael Ben", "otc24,2023", "\ on the way"),

            const SizedBox(height: 12),

            /// EMERGENCY REQUEST
            titleRow("Emergency Request"),
            jobCard("Plumbing", "otc24,2023", "\ new",),
            jobCard("Plumbing", "otc24,2023", "\ new",),

            const SizedBox(height: 12),

            /// NEW REQUEST
            titleRow("New Requests"),
            jobCard("Electrical", "Today", "\ new"),
            jobCard("Electrical", "Today", "\ new"),
          ],
        ),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  Widget statCard(String imagePath, String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8), // margin ছোট
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6), // padding ছোট
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            Container(
              width: 40, // circle size
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade100, // background color
                shape: BoxShape.circle,      // circle shape
              ),
              padding: const EdgeInsets.all(8), // image padding ভিতরে
              child: Image.asset(
                imagePath,
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(height: 4),

            // Value
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // font size ছোট করা
              ),
            ),
            const SizedBox(height: 2),

            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 12), // title ছোট
            ),
          ],
        ),
      ),
    );
  }



  Widget titleRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Row(children: [
          Text("View All", style: TextStyle(color: Colors.blueAccent)),
          Icon(Icons.keyboard_arrow_right,color: Colors.blueAccent,)
        ],)
      ],
    );
  }

  Widget jobCard(
      String title,
      String time,
      String price,
      ) {
    return Card(
      elevation: 4, // shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/professional/water.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 12),

                // Title & Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // Price
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100, // background
                    borderRadius: BorderRadius.circular(20), // text অনুযায়ী গোল
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                // Title & Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₪450",
                        style: const TextStyle(color: Color(0xffF8C106)),
                      ),
                    ],
                  ),
                ),

                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Distance",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text("2.3 Km",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

