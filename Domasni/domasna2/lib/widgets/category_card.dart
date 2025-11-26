import 'package:flutter/material.dart';
import '../models/category.dart';


class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;


  const CategoryCard({required this.category, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                category.strCategoryThumb,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.strCategory,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                category.strCategoryDescription.length > 80
                    ? category.strCategoryDescription.substring(0, 80) + '...'
                    : category.strCategoryDescription,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}