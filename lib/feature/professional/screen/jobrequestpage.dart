import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobRequestPage extends StatelessWidget {
  const JobRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // আগের পেজে ফেরার জন্য
          },
        ),
        title: const Text(
          "Job Requests",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                /// Emergency Requests Section
                jobCard(
                  clientName: "David Cohen",
                  task: "Leaking pipe under kitchen sink",
                  task2: "Leaking pipe under kitchen sink",
                  distance: "2.3 km",
                  herzi: "\ 15 Herzi St, Tel Aviv",
                ),
                const SizedBox(height: 12),
            
                /// New Requests Section
                jobCard(
                  clientName: "Plumbing",
                  task: "Pipe replacement in bathroom",
                  task2: "Pipe replacement in bathroom",
                  distance: "2.1 km",
                  herzi: "\ 15 Herzi St, Tel Aviv",
                ),
                jobCard(
                  clientName: "Electrical",
                  task: "Fixing broken switch",
                  task2: "Fixing broken switch",
                  distance: "1.8 km",
                  herzi: "\ 15 Herzi St, Tel Aviv",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget jobCard({
    required String clientName,
    required String task,
    required String task2,
    required String distance,
    required String herzi,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Client Name & Time & images
          Row(
            children: [
            // Profile Image
            const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/images/professional/imgas.jpg'),
            ),
              SizedBox(width: 8,),
            Row(
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(clientName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4.h),
                  const Text("2h ago", style: TextStyle(color: Colors.grey)),
                ],
              ),
                SizedBox(width: 120.w,),
                Image.asset(
                  'assets/images/professional/build.png.png',color: Colors.black,
                ),
            ],)
          ],),
          SizedBox(height: 8.h),

          /// Task Description
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xffF8F9FA), // gray background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6), // spacing between texts
                Text(
                  task2,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),


          SizedBox(height: 8.h),

          /// Distance & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(herzi, style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey)
              ),
              Text(distance, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Price Range",style: TextStyle(fontSize: 15),),
                  Text("₪150-₪300",style: TextStyle(color: Color(0xffF8C106),fontWeight: FontWeight.bold,fontSize: 16),),
                ],
              ),
              /// Accept / Decline Buttons
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // background white
                      side: const BorderSide(color: Colors.red, width: 1.5), // red border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // rounded corner
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: const Text(
                      "× Decline",
                      style: TextStyle(
                        color: Colors.red, // text red
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("✓ Accept",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
