import 'package:flutter/foundation.dart';

class StaffDetailsClicked with ChangeNotifier{
  int _indexClicked = 0;

int get getindexClicked => _indexClicked;

set setIndexClicked(int index){
  _indexClicked = index;
 notifyListeners();
}

}