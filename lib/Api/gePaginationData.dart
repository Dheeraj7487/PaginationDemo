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
  int limit = 5;
  List posts = [];
  List fetchApiData = [];
  bool isLoadMoreRunning = false;
  ScrollController controller = ScrollController();

  getData() async {
    try {
      var response = await Http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=$page"));
      if(response.statusCode == 200){
        DatabaseHelper.db.deletepost();
        fetchApiData = json.decode(response.body);

        if(controller.position.extentAfter < 300){
          posts.addAll(fetchApiData);
          isLoadMoreRunning = true;
          loadPage();
          postsFromJson(response.body).map((posts) {DatabaseHelper.db.insert(posts);}).toList();
          notifyListeners();
        }
        isLoadMoreRunning = false;
        print(posts.length);
        notifyListeners();
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

  loadPage(){
    page++;
  }

}
