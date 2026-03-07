import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/provider/cart_provider.dart';
import 'package:ecommer_app/provider/favorite_provider.dart';
import 'package:ecommer_app/provider/product_provider.dart';
import 'package:ecommer_app/screens/cartscreen.dart';
import 'package:ecommer_app/screens/detailed_page.dart';
import 'package:ecommer_app/screens/search_screen.dart';
import 'package:ecommer_app/widgets/home_banner.dart';
import 'package:ecommer_app/widgets/home_categories.dart';
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
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;

    // Responsive grid configuration
    int crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);
    double childAspectRatio = screenWidth > 400 ? 0.65 : 0.6;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
            children: [
              const TextSpan(text: 'Shop', style: TextStyle(fontStyle: FontStyle.italic)),
              TextSpan(
                text: 'ora',
                style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              alignment: Alignment.center,
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
                  icon: const Icon(Icons.shopping_cart_outlined, size: 28, color: Colors.black),
                ),
                if (cartProvider.cartItems.isNotEmpty)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        "${cartProvider.cartItems.length}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen(values: widget.ecommerceApp),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 12),
                            Text("Search Products...", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Promotional Banner
                  const HomeBanner(),

                  const SizedBox(height: 10),

                  // Categories Section (Separated into a Widget)
                  const HomeCategories(),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Text(
                      "Featured Products",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productProvider.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final p = productProvider.products[index];
                      final appData = widget
                          .ecommerceApp[index % widget.ecommerceApp.length];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailedPage(itemss: p, app: appData),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      child: Hero(
                                        tag: p.id,
                                        child: Image.network(
                                          p.thumbnail,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Consumer<FavoriteProvider>(
                                        builder: (context, fav, _) {
                                          final isFav = fav.isFavorite(p);
                                          return GestureDetector(
                                            onTap: () => fav.toggleFavorite(p),
                                            child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.8),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                isFav ? Icons.favorite : Icons.favorite_border,
                                                size: 18,
                                                color: isFav ? Colors.red : Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.brand,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      p.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 14),
                                        Text(
                                          " ${p.rating.toStringAsFixed(1)}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "\$${p.price.toInt()}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
