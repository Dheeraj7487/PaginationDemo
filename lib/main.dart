import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Api/gePaginationData.dart';
import 'Api/getPosts.dart';
import 'Home1.dart';
import 'Homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider( providers: [
        ChangeNotifierProvider<ApiManager>(create: (_) => ApiManager(),),
        ChangeNotifierProvider<ApiData>(create: (_) => ApiData(),),
      ],
      child: MaterialApp(
        home: MyData(),
      ),
    );
  }
}

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
                Provider.of<ApiManager>(context, listen: false).page =1;
              },
              child: Text("Pagination1"),
            ),
          ),

          Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                // Provider.of<ApiData>(context, listen: false).page =1;
              },
              child: Text("Pagination2"),
            ),
          ),

        ],
      ),
    );
  }
}
