import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/models/product.dart';
import 'package:ecommer_app/provider/cart_provider.dart';
import 'package:ecommer_app/provider/favorite_provider.dart';
import 'package:ecommer_app/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedPage extends StatefulWidget {
  final Product itemss;
  final ProductMeta app;
  const DetailedPage({super.key, required this.itemss, required this.app});

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  int currentIndex = 0;
  int selectedcolorIndex = 1;
  int selectedsizeIndex = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartprv = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Product",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Cartscreen()),
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
      body: ListView(
        children: [
          Container(
            color: Colors.grey.shade100,
            height: size.height * 0.40,
            width: double.infinity,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: widget.itemss.images[0].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.itemss.id,
                      child: Image.network(
                        widget.itemss.images[0],
                        fit: BoxFit.contain,
                        height: size.height * 0.36,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          margin: EdgeInsets.only(right: 7),
                          width: 5,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.itemss.brand,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Consumer<FavoriteProvider>(
                      builder: (context, value, child) {
                        final isFav = value.isFavorite(widget.itemss);

                        return GestureDetector(
                          onTap: () {
                            value.toggleFavorite(widget.itemss);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_outline,
                                size: 18,
                                color: isFav ? Colors.red : Colors.orange,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  widget.itemss.title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Text(
                            widget.itemss.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.star, color: Colors.green, size: 13),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("(${widget.app.review})"),
                  ],
                ),
                // Text(p.description)
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\$${widget.itemss.price.toInt()}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "\$${widget.itemss.discountPercentage + 50}",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  widget.itemss.description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    letterSpacing: -.5,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: size.width / 2.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Color",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: widget.app.fcolor.asMap().entries.map((
                                entery,
                              ) {
                                final int index = entery.key;
                                final color = entery.value;
                                return Padding(
                                  padding: EdgeInsets.only(top: 10, right: 10),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: color,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedcolorIndex = index;
                                        });
                                      },
                                      child: Icon(
                                        Icons.check,
                                        size: 15,
                                        color: selectedcolorIndex == index
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width / 2.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: widget.app.sizes
                                        .asMap()
                                        .entries
                                        .map((entery) {
                                          final int index = entery.key;
                                          final String size = entery.value;
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedsizeIndex = index;
                                              });
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              margin: EdgeInsets.only(
                                                top: 10,
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    selectedsizeIndex == index
                                                    ? Colors.black
                                                    : Colors.white,
                                                border: Border.all(
                                                  color:
                                                      selectedsizeIndex == index
                                                      ? Colors.black
                                                      : Colors.black12,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  size,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        selectedsizeIndex ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<CartProvider>().addToCart(widget.itemss);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(" Successfully Add to cart"),
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const Cartscreen()));
        },
        elevation: 0,
        backgroundColor: Colors.white,
        label: SizedBox(
          width: size.width * 0.82,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag),
                        SizedBox(width: 5),
                        Text(
                          "ADD TO CART",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "BUY NOW",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
