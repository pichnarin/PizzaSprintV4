import 'package:flutter/cupertino.dart';

class AddressProvider with ChangeNotifier{
  final Map<int, String> _address = {};

  Map<int, String> get address => _address;

  void addAddress(int addressId, String address){
    _address[addressId] = address;
    notifyListeners();
  }

  void removeAddress(int addressId){
    _address.remove(addressId);
    notifyListeners();
  }

  void clearAddress(){
    _address.clear();
    notifyListeners();
  }

  List<Map<String, dynamic>> getAddressData(){
    return _address.entries
        .map((entry) => {
      'address_id': entry.key,
      'address': entry.value,
    }).toList();
  }

}