import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination/Api/getAttendeeData.dart';
import 'package:provider/provider.dart';
import 'Api/gePaginationData.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {

  @override
  void initState() {
    var providerData = Provider.of<AttendeeApiData>(context, listen: false);
    providerData.getDataAttendee();
    providerData.controller.addListener(() {
      if (providerData.controller.position.pixels == providerData.controller.position.maxScrollExtent) {
        providerData.loadePageAttendee();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    Provider.of<AttendeeApiData>(context, listen: false).controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // var providerData = Provider.of<AttendeeApiData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination"),
      ),
      body: Consumer<AttendeeApiData>(builder: (context, snapshot, child) {
        return FutureBuilder(
            future: snapshot.getDataAttendee(),
            builder: (index,futureSnapshot){
              // if(futureSnapshot.connectionState == ConnectionState.done){
                return ListView.builder(
                    controller: snapshot.controller,
                    // itemCount: snapshot.posts.length,
                    itemCount: snapshot.posts?.data?.attendeeList?.length,
                    itemBuilder: (_, index){
                      return Card(
                        child: ListTile(
                          trailing: Text('${snapshot.posts?.data?.attendeeList![index].isFavorites}'),
                          leading: Text('${snapshot.posts?.data?.attendeeList![index].id}'),
                          title: Text('${snapshot.posts?.data?.attendeeList![index].firstname}'),
                          subtitle: Text('${snapshot.posts?.data?.attendeeList![index].lastname}'),
                        ),
                      );
                    }
                );
              // }
              // else{
              //   return CircularProgressIndicator();
              // }
            });
      }),
    );
  }

}
