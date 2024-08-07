import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Remote/firebase_services.dart';

class StatusProvider extends ChangeNotifier {
  // verialble for store states
  String _selectedType = "";
  bool _isAdmin = false;
  late String _uid;

  // for store user selected category (note,slide....)
  void typeUpdater(String type) {
    _selectedType = type;
    notifyListeners();
  }

  // check and store user role
  void checkUserIsAdmin(String uId) async {
    FirebaseServices service = FirebaseServices();
    bool isUserAdmin = await service.checkUserRole(uId);
    _isAdmin = isUserAdmin;
    _uid = uId;
    notifyListeners();
  }

  // clear user role state when login
  void resetRole() {
    _isAdmin = false;
    notifyListeners();
  }

  // getters
  String get selectedCategory => _selectedType;
  String get uid => _uid;
  bool get isUserAdmin => _isAdmin;
}
