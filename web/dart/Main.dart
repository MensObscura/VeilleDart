import 'dart:io';
import 'dart:core';
import 'Channel.dart';



List<Channel> channels;

void main() async{
  
  channels = new List<Channels>();
  
 await chat();
 await test();
 
	
}

Future chat() async{

 Channel global= new Channel('Hall');
  
  channels.add(global);

}

Future test() async{
	var requestServer =
      await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print('listening on localhost, port ${requestServer.port}');

  await for (HttpRequest request in requestServer) {
    handleRequest(request);
  }

}


void handleRequest(HttpRequest request) {
  try {
    if (request.method == 'GET') {
		request.send(jsonData);
    } else {
	request.response..statusCode = HttpStatus.METHOD_NOT_ALLOWED
     	           ..write('Unsupported request: ${request.method}.')
     	           ..close();
    }
  } catch (e) {
    print('Exception in handleRequest: $e');
  }
  print('Request handled.');
}




