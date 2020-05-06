import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Category'),
//      ),
      body: GridView(
        padding: EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map((catData) => CategoryItem(
                  catData.title,
                  catData.color,
                  catData.id,
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}
