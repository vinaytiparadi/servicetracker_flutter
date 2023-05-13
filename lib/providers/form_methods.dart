
import 'package:flutter/foundation.dart';

class FormProvider with ChangeNotifier{
  bool _savingData =false;
  bool get loading => _savingData;

  setSaving(bool value){
    _savingData = value;
    notifyListeners();
  }

}