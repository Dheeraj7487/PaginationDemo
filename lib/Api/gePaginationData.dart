import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;
import '../Exception/exception.dart';
import '../Helper/database_helper.dart';
import '../Model/model.dart';

class ApiData extends ChangeNotifier {

  final url = 'https://jsonplaceholder.typicode.com/posts';
  int page = 1;
  int limit = 10;
  List posts = [];
  List fetchPostData = [];

  getData() async {
    try {
      var response = await Http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit"));
      print("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit");
      if(response.statusCode == 200){
        DatabaseHelper.db.deletepost();
        posts = json.decode(response.body);
        postsFromJson(response.body).map((posts) {DatabaseHelper.db.insert(posts);}).toList();
        print(posts.length);
      }
      else{
        print("Something wrong");
      }
    }

    on SocketException catch(e){
      final fetchData  = await DatabaseHelper.db.fetchPostsData();
      posts = fetchData;
      notifyListeners();
      print(posts);
    }
    on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException("reegf");
    }
  }

  loadePage() async {
    page++;
    // var response = await Http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit"));
    // print("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit");
    // fetchPostData = json.decode(response.body);
    // posts.addAll(fetchPostData);
  }

}

