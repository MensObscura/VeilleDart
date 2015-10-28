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



void handleGetRequest(HttpRequest request){
String jsonString = getChannels();
print(jsonString);


HttpResponse res = request.response;
addCorsHeaders(res);   
res.write(jsonString);
res.close();
}

void handlePostRequest(HttpRequest request) async{
var jsonString = await request.transform(UTF8.decoder).join();
Map jsonData = JSON.decode(jsonString);

if(jsonData['pseudo'] != null && jsonData['pseudo'] != ''){

if(global == null && jsonData['channel'] == 'Hall' ){
global = await new Channel('Hall');

if(channels == null){
channels = await new List<Channels>();
}

channels.add(global);
}
global.addUser(new User(jsonData['pseudo']));
}


if(jsonData['nom'] != null && jsonData['nom'] != ''){

print(jsonString);

if(jsonData['action'] == 'add'){ 
addChannel(jsonData['nom'],jsonData['channel'],jsonData['user']);
}

if(jsonData['action'] == 'join'){
 
joinChannel(jsonData['nom'],jsonData['channel'],jsonData['user']);

}

}
}


void addChannel(String dest, String current, String user) {


channels.add(new Channel(dest));

}


void joinChannel(String dest, String current, String user) {

int index = findChannel(dest);
if(index < 0){
channels.add(new Channel(dest));
joinChannel(dest,current,user);
}else{
channels.elementAt(index).addUser(new User(user));
}

}


int findChannel(String name){
int i =0;
for (Channel channel in channels){

if( channel.name == name){
print('find');
return i;
}
i++;
}

print('nop ${name} ');
return -1;


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






