import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ReviewModel {
  final String name;
  final String comment;
  final double rating;
  final Color avatarColor;
  final String initials;

  const ReviewModel({
    required this.name,
    required this.comment,
    required this.rating,
    required this.avatarColor,
    required this.initials,
  });
}

final List<ReviewModel> reviews = [
  ReviewModel(name: 'David Cohen', comment: 'Excellent work, very professional!', rating: 2, avatarColor: const Color(0xFFFFC107), initials: 'DC'),
  ReviewModel(name: 'Sarah Levi', comment: 'Fixed the issue quickly. Highly recommend!', rating: 4, avatarColor: const Color(0xFFE53935), initials: 'SL'),
  ReviewModel(name: 'David Cohen', comment: 'Excellent work, very professional!', rating: 2, avatarColor: const Color(0xFFFFC107), initials: 'DC'),
  ReviewModel(name: 'Sarah Levi', comment: 'Fixed the issue quickly. Highly recommend!', rating: 4, avatarColor: const Color(0xFFE53935), initials: 'SL'),
  ReviewModel(name: 'David Cohen', comment: 'Excellent work, very professional!', rating: 2, avatarColor: const Color(0xFFFFC107), initials: 'DC'),
  ReviewModel(name: 'Sarah Levi', comment: 'Fixed the issue quickly. Highly recommend!', rating: 4, avatarColor: const Color(0xFFE53935), initials: 'SL'),
  ReviewModel(name: 'David Cohen', comment: 'Excellent work, very professional!', rating: 2, avatarColor: const Color(0xFFFFC107), initials: 'DC'),
  ReviewModel(name: 'Sarah Levi', comment: 'Fixed the issue quickly. Highly recommend!', rating: 4, avatarColor: const Color(0xFFE53935), initials: 'SL'),
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(Icons.arrow_back_ios_new, size: 16.sp, color: Colors.black87),
                  ),
                  SizedBox(width: 12.w),
                  Text('My Profile', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Card
                    _buildCard(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundImage: const AssetImage(
                              'assets/images/professional/imgas.jpg',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Michael Ben', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                              SizedBox(height: 3.h),
                              Text('michaelben@gmail.com', style: TextStyle(fontSize: 12.sp, color: Colors.grey[500])),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Stats Row
                    _buildCard(
                      child: Row(
                        children: [
                          _buildStatCard(Icons.trending_up, '৳850', 'Today', const Color(0xFF1565C0)),
                          _buildStatCard(Icons.check_circle_outline, '342', 'Jobs', const Color(0xFF4CAF50)),
                          _buildStatCard(Icons.star_outline, '4.8', 'Rating', const Color(0xFFFFC107)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Text('Categories', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                    SizedBox(height: 10.h),

                    _buildCard(
                      child: Column(
                        children: [
                          _buildCategoryItem(Icons.person_outline, 'Personal Info', null, null),
                          Divider(height: 1, color: Colors.grey[100]),
                          _buildCategoryItem(Icons.shield_outlined, 'ID Verification', 'Verified', const Color(0xFF4CAF50)),
                          Divider(height: 1, color: Colors.grey[100]),
                          _buildCategoryItem(Icons.description_outlined, 'Certificates', null, null, badge: '3'),
                          Divider(height: 1, color: Colors.grey[100]),
                          _buildCategoryItem(Icons.location_on_outlined, 'Service Areas', null, null),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Recent Reviews Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Reviews', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const AllReviewsPage()));
                          },
                          child: Text('View All', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFFFFC107))),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // Show 2 reviews
                    ...reviews.take(2).map((r) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _buildReviewCard(r),
                    )),

                    SizedBox(height: 16.h),

                    // Log Out
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.logout, size: 18.sp, color: const Color(0xFFE53935)),
                            SizedBox(width: 6.w),
                            Text('Log Out', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFFE53935))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: child,
    );
  }

  Widget _buildStatCard(
      IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDivider() {
    return Container(width: 1, height: 40.h, color: Colors.grey[100]);
  }

  Widget _buildCategoryItem(IconData icon, String title, String? tag, Color? tagColor, {String? badge}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey[600]),
          SizedBox(width: 12.w),
          Expanded(child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87))),
          if (tag != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(color: tagColor?.withOpacity(0.1), borderRadius: BorderRadius.circular(20.r)),
              child: Text(tag, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: tagColor)),
            ),
          if (badge != null)
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(color: const Color(0xFFFFC107), borderRadius: BorderRadius.circular(6.r)),
              alignment: Alignment.center,
              child: Text(badge, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          SizedBox(width: 6.w),
          Icon(Icons.chevron_right, size: 18.sp, color: Colors.grey[400]),
        ],
      ),
    );
  }
}

Widget _buildReviewCard(ReviewModel r) {
  return Container(
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: r.avatarColor,
          child: Text(r.initials, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(r.name, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                  _buildStarRating(r.rating),
                ],
              ),
              SizedBox(height: 4.h),
              Text(r.comment, style: TextStyle(fontSize: 12.sp, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStarRating(double rating) {
  return Row(
    children: List.generate(5, (i) {
      return Icon(
        i < rating ? Icons.star : Icons.star_border,
        size: 13.sp,
        color: const Color(0xFFFFC107),
      );
    }),
  );
}
// ALL REVIEWS PAGE

class AllReviewsPage extends StatelessWidget {
  const AllReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new, size: 16.sp, color: Colors.black87),
                  ),
                  SizedBox(width: 12.w),
                  Text('Recent Reviews', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                itemCount: reviews.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => _buildReviewCard(reviews[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

}