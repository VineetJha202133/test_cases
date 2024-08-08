import 'package:flutter/material.dart';

class MultipleTabs extends StatefulWidget {
  const MultipleTabs({super.key});

  @override
  State<MultipleTabs> createState() => _MultipleTabsState();
}

class _MultipleTabsState extends State<MultipleTabs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1), 
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              
            },
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text('data', style: TextStyle(color: Colors.white, fontSize: 16),),
            
            ),
          );
        },),
      ),
    );
  }
}