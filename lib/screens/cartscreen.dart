import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/models/product.dart';
import 'package:ecommer_app/provider/cart_provider.dart';
import 'package:ecommer_app/provider/product_provider.dart';
import 'package:ecommer_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  final List<ProductMeta> value;

  const CartScreen({super.key, required this.value});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful : ${response.paymentId}")),
    );
    context.read<CartProvider>().clearCart();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed : ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet : ${response.walletName}")),
    );
  }

  void _openCheckOut(double totalPrice) {
    var options = {
      'key': 'rzp_test_TYX1Y5HkIoFcsP',
      'amount': (totalPrice * 100).toInt(), // Razorpay expects amount in subunits (paise/cents)
      'name': 'My E-Commerce App',
      'description': 'Order Payment',
      'prefill': {'contact': '9999999999', 'email': 'customer@example.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartprv = context.watch<CartProvider>();
    final prtprv = context.watch<ProductProvider>();
    final cartItems = cartprv.cartItems;

    List<Product> cartProducts = prtprv.products
        .where((product) => cartItems.containsKey(product.id))
        .toList();
    final totalPrice = cartprv.getTotalPrice(prtprv.products);
    double taxCharge = 5.0;
    double tax = (totalPrice * taxCharge) / 100;
    double deliveryCharge = (totalPrice > 50 || totalPrice == 0) ? 0 : 5;
    double finalAmount = totalPrice + deliveryCharge + tax;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: cartProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/cart_logo.png", height: 180, errorBuilder: (context, error, stackTrace) => Icon(Icons.shopping_cart, size: 100, color: Colors.grey)),
                  Text(
                    "Your Cart Is Empty \nAdd something from the Products",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 10,
                      ),
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    },
                    child: Text(
                      "Shop",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = cartProducts[index];
                      // Find the metadata using the original product index to avoid range errors
                      int originalIndex = prtprv.products.indexOf(product);
                      final val = (originalIndex >= 0 && originalIndex < widget.value.length) 
                          ? widget.value[originalIndex] 
                          : widget.value[0]; 

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        elevation: 2,
                        shadowColor: Colors.orange,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  product.thumbnail,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 100),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.brand,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        product.rating.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      Text(" (${val.review})"),
                                    ],
                                  ),
                                  Text(
                                    "\$${product.price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18 ,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<CartProvider>().removeItem(product);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.orange),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.read<CartProvider>().removeOne(product);
                                      },
                                      icon: Icon(Icons.remove_circle_outline, color: Colors.orange),
                                    ),
                                    Text(
                                      "${cartItems[product.id]}",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.read<CartProvider>().addToCart(product);
                                      },
                                      icon: Icon(Icons.add_circle_outline, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Card(
                    color: Colors.black,
                    margin: EdgeInsets.all(10),
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildPriceRow("Sub Total", "\$${totalPrice.toStringAsFixed(2)}"),
                          SizedBox(height: 5),
                          _buildPriceRow("Delivery Charge", deliveryCharge == 0 ? "Free" : "\$${deliveryCharge.toStringAsFixed(2)}"),
                          SizedBox(height: 5),
                          _buildPriceRow("Tax (5%)", "\$${tax.toStringAsFixed(2)}"),
                          Divider(color: Colors.grey, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                  Text("\$${finalAmount.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                ),
                                onPressed: () => _openCheckOut(finalAmount),
                                child: Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 18)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPriceRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
