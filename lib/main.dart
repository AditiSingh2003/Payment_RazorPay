import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var amountController = TextEditingController();
  var _razorpay = Razorpay();

  @override
  void initState(){
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
  // Do something when payment succeeds
}

void _handlePaymentError(PaymentFailureResponse response) {
  // Do something when payment fails
}

void _handleExternalWallet(ExternalWalletResponse response) {
  // Do something when an external wallet is selected
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: TextField(
              controller: amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Pay Now'),
            onPressed: () {
                var options = {
                'key': "rzp_test_QrjoZd5gG0uVkb",
                'amount': (int.parse(amountController.text)*100).toString(),
                'name': 'Aditi Singh',
                'description': 'testing paisa',
                'timeout': 300, 
                'prefill': {
                  'contact': '9795677012', //dommy number can be given
                  'email': 'aditisinghrawal@gmail.com' //dommy id can be given
                }
              };
              _razorpay.open(options);
            },
          ),
        ]
      ),
      );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
