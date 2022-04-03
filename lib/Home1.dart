import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Api/gePaginationData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ScrollController? controller;
    var providerData = Provider.of<ApiData>(context, listen: false);
    controller?.addListener((){
      providerData.getData();
    });
    if (controller?.position.pixels == controller?.position.maxScrollExtent) {
      providerData.loadePage();
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination"),
      ),
      body: Consumer<ApiData>(builder: (context, snapshot, child) {
        return FutureBuilder(
            future: snapshot.getData(),
            builder: (index,futureSnapshot){
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                        controller: controller,
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
              ]);
            });
      }),
    );
  }
}



