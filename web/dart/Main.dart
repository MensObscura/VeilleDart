import 'dart:io';
import 'dart:core';
import 'Channel.dart';
import 'dart:convert';
import 'User.dart';


List<Channel> channels;
Channel global;

void main() async{
  
  
  

  rest();
 
	
}


Future rest() async{
	
	var requestServer =
      await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print('listening on localhost, port ${requestServer.port}');

  await for (HttpRequest request in requestServer) {
    handleRequest(request);
  }

}


void handleRequest(HttpRequest request) async{
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
	request.response..statusCode = HttpStatus.METHOD_NOT_ALLOWED
     	           ..write('Unsupported request: ${request.method}.')
     	           ..close();
    }
  } catch (e) {
    print('Exception in handleRequest: $e');
  }
  print('Request handled.');
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






