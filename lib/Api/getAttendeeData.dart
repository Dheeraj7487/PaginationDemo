import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pagination/Model/attendeeModel.dart';
import '../Exception/exception.dart';
import '../Helper/database_helper.dart';
import '../Model/model.dart';

class AttendeeApiData extends ChangeNotifier {

  int page = 1;
  int limit = 10;
  AttendeeModel? posts;
  List apiData = [];
  // List posts = [];
  ScrollController controller = ScrollController();

  getDataAttendee() async {

    final String url = 'https://www.allintheloop.net/native_single_fcm_v2/attendee/attendee_list_v5?_page=$page&_limit=$limit';

    final response = await http.post(
        Uri.parse(url), body: {
      'advance_filter': '',
      'lang_id': '3453',
      'page_no': '$page',
      'time_zone': 'Asia/Kolkata',
      'token': '0f0380459a5c2d45797c10ae79b4657ad4b39283',
      'event_id': '3687',
      'event_type': '4',
      'category_id': '',
      'user_id': '668817',
      'filter_type': '',
      'keyword': '',
      'is_company': '1',
      'filter_keywords': '',
      'jagdish': '1',
    });

    if (response.statusCode == 200) {
      posts = AttendeeModel.fromJson(jsonDecode(response.body));
      apiData.add(posts);
    }
    else{
      print("error");
    }
    return posts!;
  }

    // print("page => $page");
    // try {
    //   Response response = await http.post(
    //       Uri.parse('https://www.allintheloop.net/native_single_fcm_v2/attendee/attendee_list_v5'),
    //       // Uri.parse('https://www.allintheloop.net/native_single_fcm_v2/attendee/attendee_list_v5?_page=$page&_limit=$limit'),
    //     body: {
    //       'advance_filter': '',
    //       'lang_id': '3453',
    //       'page_no': '1',
    //       'time_zone': 'Asia/Kolkata',
    //       'token': '0f0380459a5c2d45797c10ae79b4657ad4b39283',
    //       'event_id': '3687',
    //       'event_type': '4',
    //       'category_id': '',
    //       'user_id': '668817',
    //       'filter_type': '',
    //       'keyword': '',
    //       'is_company': '1',
    //       'filter_keywords': '',
    //       'jagdish': '1',
    //     }
    //   );
    //   print('https://www.allintheloop.net/native_single_fcm_v2/attendee/attendee_list_v5?_page=$page&_limit=$limit');
    //   if(response.statusCode == 200){
    //     posts = AttendeeModel.fromJson(json.decode(response.body)) as List;
    //     // print(posts?.data?.attendeeList?.length);
    //     notifyListeners();
    //     return AttendeeModel.fromJson(json.decode(response.body));
    //   }
    //   else{
    //     print("Something wrong");
    //   }
    // }
    //
    // on SocketException catch(e){
    //   throw SocketException('Internet Not Found');
    // }
    // catch (e) {
    //   throw UnknownException("reegf");
    // }

  loadePageAttendee(){
    page++;
    notifyListeners();
  }
}

