import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Api/getPosts.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var providerData = Provider.of<ApiManager>(context, listen: false);
    providerData.firstLoad();
    providerData.controller = ScrollController()..addListener(providerData.loadMore);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination"),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
          Navigator.pop(context);
          providerData.page == 1;
          print("sdgsd");
          },
        ),
      ),
      body: Consumer<ApiManager>(builder: (context, snapshot, child) {
        return snapshot.isFirstLoadRunning ? CircularProgressIndicator()
            :
        FutureBuilder(
            future: snapshot.loadMore(),
            builder: (index,futureSnapshot){
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                        controller: snapshot.controller,
                        itemCount: snapshot.posts.length,
                        itemBuilder: (_, index){
                          if(index<snapshot.posts.length){
                            return Card(
                              child: ListTile(
                                trailing: Text('${snapshot.posts[index]['userId']}'),
                                leading: Text('${snapshot.posts[index]['id']}'),
                                title: Text('${snapshot.posts[index]['title']}'),
                                subtitle: Text('${snapshot.posts[index]['body']}'),
                              ),
                            );
                          }
                          else if(snapshot.posts.length == 0){
                            return snapshot.firstLoad();
                          }
                          else{
                            return snapshot.loadMore();
                          }
                        }
                    )
                ),

                if (snapshot.isLoadMoreRunning)
                  Center(child: CircularProgressIndicator(),),

                if (snapshot.hasNextPage == false)
                  Center(child: Text('Fetch All Data'),),
              ]);
            });
      }),
    );
  }
}


