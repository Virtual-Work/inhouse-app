

import 'package:flutter/foundation.dart';

class ListOfProjects with ChangeNotifier{
  String title;
  String supervisor;
  String status;

  ListOfProjects({this.title, this.supervisor, this.status});

  ListOfProjects.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    supervisor = json['supervisor'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['supervisor'] = this.supervisor;
    data['status'] = this.status;
    return data;
  }
}
