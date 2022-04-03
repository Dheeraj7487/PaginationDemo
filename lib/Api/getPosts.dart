import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;
import '../Exception/exception.dart';
import '../Helper/database_helper.dart';
import '../Model/model.dart';

class ApiManager extends ChangeNotifier {

  final url = 'https://jsonplaceholder.typicode.com/posts';

  int page = 1;
  int limit = 10;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List posts = [];
  List fetchedPosts = [];
  ScrollController? controller;

  firstLoad() async {
    isFirstLoadRunning = true;
    try {
      var response = await Http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit"));
      print("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit");
      if(response.statusCode == 200){
        DatabaseHelper.db.deletepost();
        print('Data Found');
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
    isFirstLoadRunning = false;
    notifyListeners();
  }

  loadMore() async {
    if (hasNextPage == true && isFirstLoadRunning == false &&
        isLoadMoreRunning == false && controller!.position.extentAfter < 300) {

      isLoadMoreRunning = true;
      page++;
      try {
        final response = await Http.get(Uri.parse("$url?_page=$page&_limit=$limit"));
        fetchedPosts = json.decode(response.body);
        if (fetchedPosts.length >= 0) {
          posts.addAll(fetchedPosts);
          print("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit");
          print("Loaded Data ${posts.length}");
          postsFromJson(response.body).map((posts) {DatabaseHelper.db.insert(posts);}).toList();
          print(fetchedPosts.length);
          notifyListeners();
        }
        else {
          hasNextPage = false;
          page = 1;
          // notifyListeners();
        }
        // page = 1;
      }
      catch (err) {
        print('Something went wrong!');
        notifyListeners();
      }
      isLoadMoreRunning = false;
      notifyListeners();
    }
  }
}

