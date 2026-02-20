import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/models/category.dart';
import 'package:ecommer_app/provider/cart_provider.dart';
import 'package:ecommer_app/provider/favorite_provider.dart';
import 'package:ecommer_app/provider/product_provider.dart';
import 'package:ecommer_app/screens/cartscreen.dart';
import 'package:ecommer_app/screens/categorieslistscreen.dart';
import 'package:ecommer_app/screens/detailed_page.dart';
import 'package:ecommer_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHomescreen extends StatefulWidget {
  final List<ProductMeta> ecommerceApp;

  const AppHomescreen({super.key, required this.ecommerceApp});

  @override
  State<AppHomescreen> createState() => _AppHomescreenState();
}

class _AppHomescreenState extends State<AppHomescreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>();
    final cartprv = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'Shop',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: 'ora',
                style: TextStyle(
                  color: Color(0xFFFF6A00),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartScreen(value: widget.ecommerceApp),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                ),

                if (cartprv.cartItems.isNotEmpty)
                  Positioned(
                    right: 7,
                    top: 7,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("${cartprv.cartItems.length}")),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: product.isLoading
          ? Center(
          child: CircularProgressIndicator()
      )
          : SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen(values: widget.ecommerceApp),
                        ),
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(7),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundImage: AssetImage("assets/images/logo.jpg"),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        final category = categoryList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<ProductProvider>()
                                      .filterByCategory(category.apiCategory);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CategoriesListScreen(
                                        categoryName: category.name,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    image: DecorationImage(
                                      image: AssetImage(category.image),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(category.name),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                    ),
                  ),

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Text(
                      "Featured Products",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: product.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      final p = product.products[index];
                      final appData = ecommerceApp[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedPage(itemss: p, app: appData),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 100,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Hero(
                                        tag: p.id,
                                        child: Image.network(
                                          p.images[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Consumer<FavoriteProvider>(
                                        builder: (context, value, child) {
                                          final isFav = value.isFavorite(p);

                                          return GestureDetector(
                                            onTap: () {
                                              value.toggleFavorite(p);
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  isFav
                                                      ? Icons.favorite
                                                      : Icons.favorite_outline,
                                                  size: 18,
                                                  color: isFav
                                                      ? Colors.red
                                                      : Colors.orange,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 2,
                                      left: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withValues(
                                            alpha: 0.5,
                                            blue: 0.8,
                                          ),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0,
                                          ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  p.rating.toStringAsFixed(1),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width: 3),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.green,
                                                  size: 13,
                                                ),
                                                Divider(),
                                                Text("(${appData.review})"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  p.brand,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  p.title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Text(p.description)
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$${p.price.toInt()}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFFF6A00),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "\$${p.discountPercentage}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  p.description,
                                  style: TextStyle(
                                    color: Colors.grey.shade900,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ),
    );
  }
}
