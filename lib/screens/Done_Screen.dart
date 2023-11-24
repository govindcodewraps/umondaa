import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presenter/home_presenter.dart';
import 'main.dart';

class DoneScreen extends StatefulWidget {
  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Dispose of HomePresenter
        Provider.of<HomePresenter>(context, listen: false).dispose();

        // Navigate to Main screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Main()),
              (newRoute) => false,
        );

        // Prevent going back from DoneScreen
        return false;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/donegif.gif",
                      height: 125.0,
                      width: 125.0,
                    ),
                    Text(
                      "Successfully order placed",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: WillPopScope(
        onWillPop: () async {
          // Dispose of HomePresenter
          Provider.of<HomePresenter>(context, listen: false).dispose();

          // Navigate to Main screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Main()),
                (newRoute) => false,
          );

          // Prevent going back from DoneScreen
          return false;
        },
        child: InkWell(
          onTap: () {
            // Dispose of HomePresenter
            Provider.of<HomePresenter>(context, listen: false).dispose();

            // Navigate to Main screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Main()),
                  (newRoute) => false,
            );
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      title: Row(
        children: [
          Spacer(),
          Image.asset(
            'assets/appbarlogo.png',
            width: 100,
            height: 80,
          ),
          Spacer(),
          Icon(Icons.notifications),
          Icon(Icons.notifications),
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../presenter/home_presenter.dart';
// import 'main.dart';
//
// class DoneScreen extends StatefulWidget {
//   @override
//   State<DoneScreen> createState() => _DoneScreenState();
// }
//
// class _DoneScreenState extends State<DoneScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Column(
//         children: [
//           // Add an Expanded widget to make the container take up all available space
//           Expanded(
//             child: Center(
//               // Center the text
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/donegif.gif",
//                     height: 125.0,
//                     width: 125.0,
//                   ),
//                   Text("Successfully order placed",style:TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 20),),
//                   SizedBox(height: 20,)
//
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       leading: InkWell(
//         onTap: () {
//           Provider.of<HomePresenter>(context, listen: false).dispose();
//
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) {
//               return Main();
//             }),
//                 (newRoute) => false,
//           );
//         },
//         child: Icon(Icons.arrow_back, color: Colors.black),
//       ),
//       title: Row(
//         children: [
//           Spacer(),
//           Image.asset(
//             'assets/appbarlogo.png',
//             width: 100,
//             height: 80,
//           ),
//           Spacer(),
//           Icon(Icons.notifications),
//           Icon(Icons.notifications),
//         ],
//       ),
//       elevation: 0.0,
//       titleSpacing: 0,
//     );
//   }
// }
