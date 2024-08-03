import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Remote/firebase_services.dart';

class StatusProvider extends ChangeNotifier {
  String _selectedType = "";
  bool _isAdmin = false;

  void typeUpdater(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void checkUserIsAdmin(String uId) async {
    FirebaseServices service = FirebaseServices();
    bool isUserAdmin = await service.checkUserRole(uId);
    _isAdmin = isUserAdmin;
    notifyListeners();
  }

  void resetRole() {
    _isAdmin = false;
    notifyListeners();
  }

  String get selectedCategory => _selectedType;
  bool get isUserAdmin => _isAdmin;
}
