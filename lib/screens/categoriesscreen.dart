import 'package:ecommer_app/models/category.dart';
import 'package:ecommer_app/provider/product_provider.dart';
import 'package:ecommer_app/screens/categorieslistscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Shop By Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        itemCount: categoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (context, index) {
          final category = categoryList[index];
          return GestureDetector(
            onTap: () {
              context.read<ProductProvider>().filterByCategory(
                category.apiCategory,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      Categorieslistscreen(categoryName: category.name),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7.0,
                  vertical: 7,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 13,
                      left: 10,
                      child: Text(
                        category.name,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ),

                    Positioned(
                      bottom: -10,
                      right: -1,
                      child: Image.asset(
                        category.image,
                        height: 110,
                        width: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
