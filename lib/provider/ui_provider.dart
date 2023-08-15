import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{
  int _selectecMenuOpt = 0;

  int get selectedMenuOpt {
    return _selectecMenuOpt;
  }
  set selectedMenuOpt (int i){
    _selectecMenuOpt = i;
    notifyListeners();
  }

}