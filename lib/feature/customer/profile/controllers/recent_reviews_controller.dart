import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewModel {
  final String initials;
  final Color color;
  final String name;
  final int stars;
  final String comment;

  const ReviewModel({
    required this.initials,
    required this.color,
    required this.name,
    required this.stars,
    required this.comment,
  });
}

class RecentReviewsController extends GetxController {
  final reviews = <ReviewModel>[
    const ReviewModel(
      initials: 'DC',
      color: Color(0xFFF8C106),
      name: 'David Cohen',
      stars: 4,
      comment: 'Excellent work, very professional!',
    ),
    const ReviewModel(
      initials: 'SL',
      color: Color(0xFFE53935),
      name: 'Sarah Levi',
      stars: 4,
      comment: 'Fixed the issue quickly. Highly recommend!',
    ),
    const ReviewModel(
      initials: 'DC',
      color: Color(0xFFF8C106),
      name: 'David Cohen',
      stars: 4,
      comment: 'Excellent work, very professional!',
    ),
    const ReviewModel(
      initials: 'SL',
      color: Color(0xFFE53935),
      name: 'Sarah Levi',
      stars: 4,
      comment: 'Fixed the issue quickly. Highly recommend!',
    ),
    const ReviewModel(
      initials: 'DC',
      color: Color(0xFFF8C106),
      name: 'David Cohen',
      stars: 4,
      comment: 'Excellent work, very professional!',
    ),
    const ReviewModel(
      initials: 'SL',
      color: Color(0xFFE53935),
      name: 'Sarah Levi',
      stars: 4,
      comment: 'Fixed the issue quickly. Highly recommend!',
    ),
    const ReviewModel(
      initials: 'DC',
      color: Color(0xFFF8C106),
      name: 'David Cohen',
      stars: 4,
      comment: 'Excellent work, very professional!',
    ),
    const ReviewModel(
      initials: 'SL',
      color: Color(0xFFE53935),
      name: 'Sarah Levi',
      stars: 4,
      comment: 'Fixed the issue quickly. Highly recommend!',
    ),
  ].obs;
}