import 'dart:html';
import 'dart:convert' show UTF8, JSON;

class ClientChannel {

 String channel;
 String nickname;
 DivElement output;
  TextAreaElement input;
  ButtonElement send ;
  ButtonElement channels;
  UListElement ulUser ;
  DivElement title;
  Storage localStorage ;
 WebSocket ws ;
  String address;


ClientChannel(){

 output = querySelector('#output');
   input = querySelector('#input');
  send = querySelector('#send');
   channels = querySelector('#channels');
   ulUser =  querySelector('#users');
   localStorage = window.localStorage;
	title = querySelector('#title');
  nickname =localStorage['username'];
  channel =localStorage['channel'];
  address ="ws://172.28.1.153:9090/${channel}";

 title.innerHtml ="<h1 class='text-center'>${channel}</h1>" ;

}

void run(){

 
 
 print(address);
  ws = new WebSocket(address);

  

  send.onClick.listen((MouseEvent event) {
     sendMessage();
  });
  
 input.onKeyPress.listen((KeyboardEvent event) {
	
	if (new KeyEvent.wrap(event).keyCode == KeyCode.ENTER) 
	sendMessage();
});

  channels.onClick.listen((MouseEvent event) {
  

  
  ws.close();
  window.location.assign('channels.html');
  
  });
  

  ws.addEventListener('message', (event) {
     String message = event.data;
     
     if(message.substring(0,3) == "***")
      getUsers();
     
     output.innerHtml += '<p>${message}</p>';
    output.scrollTop = output.scrollHeight;
  }); 
  
  }



void requestComplete(request){
  ulUser.innerHtml='';
   
      var jsonString = request;
  	 Map jsonData = JSON.decode(jsonString);
      List<String> userList = jsonData['users'];
      for (int i = 0; i < userList.length; i++) {
        ulUser.innerHtml+= "<li>${userList[i]}</li>";
      }
   
 
    
    

}

void sendMessage(){
 String message = input.value;
 

    message = message.trim();

    if(message != '') {
     
      input.value = '';      
      input.focus();
      print(nickname+" dit : ${message}");
      ws.send(nickname+" dit : ${message}");
      }
}

void getUsers(){


var url = 'http://172.28.1.153:8080';
    print(url);
    var data = {'channel':'${channel}'};
    Uri uri = new Uri(path: url, queryParameters : data);
   HttpRequest.getString(uri.toString()).then((req){
   
    requestComplete(req);
   
   }) .catchError((Error error) {
   
   	  ulUser.innerHtml= "<li>Request failed</li>";
   	  print(error.toString());
    });


}

}
