import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Api/gePaginationData.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose() {
    super.dispose();
    // Provider.of<ApiData>(context, listen: false).controller.dispose();
  }
  @override
  Widget build(BuildContext context) {

    var providerData = Provider.of<ApiData>(context, listen: false);

    providerData.controller.addListener(() {
      if (providerData.controller.position.pixels == providerData.controller.position.maxScrollExtent) {
        // providerData.loadePage();
        providerData.getData();
      }
    });
    // var providerData = Provider.of<ApiData>(context, listen: false);
    print("jdjd ${providerData.posts.length}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination"),
        leading: IconButton(onPressed: (){
          providerData.page = 1;
          providerData.posts.clear();
          // print(providerData.posts.length);
          // print("I am Back");
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Consumer<ApiData>(builder: (context, snapshot, child) {
        return FutureBuilder(
            future: snapshot.getData(),
            builder: (index,futureSnapshot){
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                        controller: providerData.controller,
                        itemCount: snapshot.posts.length,
                        itemBuilder: (_, index){
                            return Card(
                              child: ListTile(
                                trailing: Text('${snapshot.posts[index]['userId']}'),
                                leading: Text('${snapshot.posts[index]['id']}'),
                                title: Text('${snapshot.posts[index]['title']}'),
                                subtitle: Text('${snapshot.posts[index]['body']}'),
                              ),
                            );
                        }
                    )
                ),
                if (snapshot.isLoadMoreRunning)
                // if (snapshot.controller.keepScrollOffset)
                  Center(child: CircularProgressIndicator(),),

              ]);
            });
      }),
    );
  }

}