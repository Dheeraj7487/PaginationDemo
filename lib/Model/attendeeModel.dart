class AttendeeModel {
  bool? success;
  Data? data;

  AttendeeModel({this.success, this.data});

  AttendeeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<AttendeeList>? attendeeList;
  int? listTotalPages;

  Data({this.attendeeList, this.listTotalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['attendee_list'] != null) {
      attendeeList = <AttendeeList>[];
      json['attendee_list'].forEach((v) {
        attendeeList!.add(new AttendeeList.fromJson(v));
      });
    }
    listTotalPages = json['list_total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendeeList != null) {
      data['attendee_list'] =
          this.attendeeList!.map((v) => v.toJson()).toList();
    }
    data['list_total_pages'] = this.listTotalPages;
    return data;
  }
}

class AttendeeList {
  String? id;
  String? firstname;
  String? lastname;
  String? companyName;
  String? title;
  String? email;
  String? logo;
  String? isFavorites;

  AttendeeList(
      {this.id,
        this.firstname,
        this.lastname,
        this.companyName,
        this.title,
        this.email,
        this.logo,
        this.isFavorites});

  AttendeeList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    firstname = json['Firstname'];
    lastname = json['Lastname'];
    companyName = json['Company_name'];
    title = json['Title'];
    email = json['Email'];
    logo = json['Logo'];
    isFavorites = json['is_favorites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Firstname'] = this.firstname;
    data['Lastname'] = this.lastname;
    data['Company_name'] = this.companyName;
    data['Title'] = this.title;
    data['Email'] = this.email;
    data['Logo'] = this.logo;
    data['is_favorites'] = this.isFavorites;
    return data;
  }
}
