import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mood_log/screens/home_page.dart';
import 'package:mood_log/screens/settings.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mood Log'),
          bottom: const TabBar(  
            tabs: [  
              Tab(icon: Icon(Icons.add_reaction)),  
              Tab(icon: Icon(Icons.settings)),  
            ],  
          ),
        ),
        body: const TabBarView(  
          children: [  
            HomePage(),  
            Settings(),  
          ],  
        ),
      ),
    );
  }
}