import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginbc/pages/chat_screen.dart';
import 'package:flutter_loginbc/pages/google_sign_in.dart';
import 'package:flutter_loginbc/pages/login_p.dart';
import 'package:flutter_loginbc/pages/register_p.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_loginbc/controller/global_controller.dart';
import 'package:flutter_loginbc/pages/navbar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalController globalController = Get.put(GlobalController(),permanent: true);
  @override 
  Widget build(BuildContext context) {
     return Scaffold(
     body: SafeArea(
      child: Obx(() => globalController.checkLoading().isTrue ? const Center(
        child: CircularProgressIndicator(),
      ): ChatScreen()
      ), 
      ),
     );
  }
}