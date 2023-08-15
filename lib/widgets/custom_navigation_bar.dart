import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ui_provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      onTap: (int i ) => uiProvider.selectedMenuOpt = i,
      elevation: 5,
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.blur_on,color: Colors.green,size: 35,),
          label: 'Ingresos',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.blur_off_sharp,color: Colors.red,size: 35,),
          label: 'Denegaciones'
          )
      ],
    );
  }
}