import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/controllers/auth_controller.dart';
import 'package:helia/app/controllers/page_index_controller.dart';
import 'package:helia/app/views/views/loading_view.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(MyApp());
  final pageController = Get.put(PageIndexController(), permanent: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: ThemeData.light().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: ColorSelect.green,
            ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

// class MyApp extends StatelessWidget {
//   final AuthController authController = Get.put(AuthController(), permanent: true);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: authController.streamAuthStatus,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           return GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: "Application",
//             // theme: ThemeData(scaffoldBackgroundColor: const Color(0xf0f3eef2)),
//             theme: ThemeData.light().copyWith(
//               colorScheme: ThemeData().colorScheme.copyWith(
//                     primary: ColorSelect.green,
//                     // spas: ColorSelect.greenSoft,
//                   ),
//             ),
//             initialRoute:
//                 snapshot.data != null && snapshot.data!.emailVerified == true ? AppPages.INITIAL : Routes.LOGIN,
//             // initialRoute: AppPages.INITIAL,
//             getPages: AppPages.routes,
//           );
//         }
//         return const Loading();
//       },
//     );
//   }
// }
