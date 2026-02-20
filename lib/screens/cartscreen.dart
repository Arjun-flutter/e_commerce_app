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

  void _handlePaymentError(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed : ${response.orderId}")),
    );
  }

  void _handleExternalWallet(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet : ${response.signature}")),
    );
  }

  void _openCheckOut(double totalPrice) {
    var options = {
      'key': 'rzp_test_TYX1Y5HkIoFcsP',
      'amount': (totalPrice * 10000).toInt(),
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
    double deliveryCharge = totalPrice > 50 ? 0 : 5;
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
                  Image.asset("assets/images/cart_logo.png", height: 180),
                  Text(
                    "Your Cart Is Empty \nAdd something from the Products",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: ElevatedButton(
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
                      final val = widget.value[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        elevation: 2,
                        shadowColor: Colors.orange,
                        child: Row(
                          children: [
                            Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: Image.network(
                                height: 120,
                                product.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.brand,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 0),
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
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
                                      Divider(),
                                      Text("(${val.review})"),
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
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.read<CartProvider>().removeItem(
                                        product,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<CartProvider>()
                                              .removeOne(product);
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Text(
                                        "${cartprv.cartItems[product.id]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<CartProvider>()
                                              .addToCart(product);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  elevation: 7,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Details",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${totalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Charge",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              deliveryCharge == 0
                                  ? "Free"
                                  : "\$${deliveryCharge.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${tax.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(thickness: 2),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${finalAmount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 1),
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () {
                                  _openCheckOut(finalAmount);
                                },
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
