import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServices{
  searchByName({String searchfield}){
    var query = Firestore.instance.collection('Staffs');
    query.where('SearchKey', isEqualTo: searchfield.substring(0, 1).toUpperCase());
  //  query.where('PSearchKey', isEqualTo: searchfield.substring(0, 2).toUpperCase());

    return query.getDocuments();
  }
}