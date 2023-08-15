import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscann/pages/direcciones_page.dart';
import 'package:qrscann/pages/page_2.dart';
import 'package:qrscann/provider/scan_list_provider.dart';
import 'package:qrscann/provider/ui_provider.dart';
import 'package:qrscann/widgets/custom_navigation_bar.dart';
import 'package:qrscann/widgets/scann_button.dart';

class HomePage extends StatelessWidget {
const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        title: const Center(
          child:  Text('Validación de Visitas', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        ) ,
        actions: [
          IconButton(
            onPressed: ()=>scanListProvider.borrarTodos(), 
            icon: const Icon(Icons.delete_forever,color: Colors.black,size: 35,),
            )
        ],
      ),
      body:  _HomePageBody(),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: const ScannButton() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final  currentIndex = uiProvider.selectedMenuOpt;

    //Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);

    switch(currentIndex){
      case 0: 
      scanListProvider.cargarScansPorTipo('aceptado');
      return const DireccionesPage();
      case 1: 
      scanListProvider.cargarScansPorTipo('denegado'); 
      return const SecondPage();

      default: return const DireccionesPage();
    }

  }
}