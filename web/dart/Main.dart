import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'Channel.dart';
import 'User.dart';


List<Channel> channels;
Channel global;

void main() async {

  rest();

}


Future rest() async {
	
	var requestServer = await HttpServer.bind("0.0.0.0", 8080);

  print('listening on localhost, port ${requestServer.port}');

  await for (HttpRequest request in requestServer) {
    switch(request.method){
      case 'GET':
        handleGetRequest(request);
        break;
      case 'POST':
        handlePostRequest(request);
        break;
      default:
        handleDefaultRequest(request);
    }
  }

}

/*
void handleRequest(HttpRequest request) async {

  try {
    if (request.method == 'GET') {
      String jsonString = getChannels();
      print(jsonString);
      Map jsonData = JSON.decode(jsonString);
      HttpResponse res = request.response;
      res.write('${jsonString }');
      res.close();

    } else  if (request.method == 'POST') {
      var jsonString = await request.transform(UTF8.decoder).join();
      Map jsonData = JSON.decode(jsonString);

      if(global == null){
        global = await new Channel('Hall');

        if(channels == null){
          channels = await new List<Channels>();
        }

        channels.add(global);
      }

      global.addUser(new User(jsonData['pseudo']));

    } else {
     request.response
     ..statusCode = HttpStatus.METHOD_NOT_ALLOWED
     ..write('Unsupported request: ${request.method}.')
     ..close();
   }
  } catch (e) {
    print('Exception in handleRequest: $e');
  }
    print('Request handled.');
}
*/

void handleGetRequest(HttpRequest request){
    String jsonString = getChannels();
    print(jsonString);
    Map jsonData = JSON.decode(jsonString);

    HttpResponse res = request.response;
    addCorsHeaders(res);   
    res.write('${jsonString }');
    res.close();
}

void handlePostRequest(HttpRequest request) async{
  var jsonString = await request.transform(UTF8.decoder).join();
  Map jsonData = JSON.decode(jsonString);

  if(global == null){
    global = await new Channel('Hall');

    if(channels == null){
      channels = await new List<Channels>();
    }

    channels.add(global);
  }
  global.addUser(new User(jsonData['pseudo']));

}

void handleDefaultRequest(HttpRequest request){
  request.response
     ..statusCode = HttpStatus.METHOD_NOT_ALLOWED
     ..write('Unsupported request: ${request.method}.')
     ..close();
}

void addCorsHeaders(HttpResponse res) {
  res.headers.add("Access-Control-Allow-Origin", "*");
  res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}


String getChannels(){

  String list ='''{"channels":[''';

    if(channels != null){

     for(Channel channel in channels){
      list += '''"${channel.name}",''';
    }

  }

  list = list.substring(0,list.length-1);
  list+=''']}''';

  return list;
}






