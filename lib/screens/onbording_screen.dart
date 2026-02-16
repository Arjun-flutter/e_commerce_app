
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';

// class OnbordingScreen extends StatelessWidget {
//   final introKey = GlobalKey<IntroductionScreenState>();

//   @override
//   Widget build(BuildContext context) {
//     final pageDecoration = PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
//       bodyTextStyle: TextStyle(fontSize: 20),
//       bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.zero,
//     );
//     // TODO: implement build
//     return IntroductionScreen(
    
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       pages: [
//         PageViewModel(
//           title: "shop now",
//           body:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
//           image: Image.asset("images/image1.png", width: 200),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Big Discount",
//           body:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
//           image: Image.asset("images/image1.png", width: 200),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Free Delivery",
//           body:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
//           image: Image.asset("images/image1.png", width: 200),
//           decoration: pageDecoration,
//         ),
//       ],
//       showSkipButton: false,
//       showDoneButton: false,
//       showBackButton: true,
      
      
//       back: Text("Back", style: TextStyle(color: Colors.black),
//       ),
//       next: Text("Next", style: TextStyle(color: Colors.red),),
//       onDone: () {},
//       onSkip: () {},
//       dotsDecorator : DotsDecorator(
//         size: Size.square(10),
//         activeSize: Size(20, 10),
//         activeColor: Color(0xFFEF6969),
//         color: Colors.black26,
//         spacing: EdgeInsets.symmetric(horizontal: 3),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//       ),
//     );
//   }
// }
