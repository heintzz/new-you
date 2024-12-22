import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final List<String> categories = [
    "Task",
    "Quit bad habit",
    "Study",
    "Exercise",
    "Read",
    "Meditate",
    "Work",
    "Relax",
    "Travel",
    "Meditate"
  ];

  final Function(String) onCategorySelected;

  CategoryGrid({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.maxFinite,
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
          children: categories.map((category) {
            return InkWell(
                onTap: () {
                  onCategorySelected(category);
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.category,
                          color: Colors.white,
                          size: 24.0,
                          semanticLabel: category,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        // style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ));
          }).toList(),
        ));
  }
}
