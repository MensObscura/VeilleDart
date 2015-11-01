import 'dart:html';
import 'dart:convert' show UTF8, JSON;

class ClientChannel {


ClientChannel(){

}

void run(){

  DivElement output = querySelector('#output');
  TextAreaElement input = querySelector('#input');
  ButtonElement send = querySelector('#send');
  ButtonElement channels = querySelector('#channels');
  UListElement ulChannel =  querySelector('#ulchannels');
  Storage localStorage = window.localStorage;
  String nickname =localStorage['username'];
  String channel =localStorage['channel'];
  String address ="ws://localhost:9090/${channel}";
  bool  reconnectScheduled = false;
 
 print(address);
  WebSocket ws = new WebSocket(address);


  

  send.onClick.listen((MouseEvent event) {
      String message = input.value;
      input.value = '';      
      input.focus();
      print(nickname+" dit : ${message}");
      ws.send(nickname+" dit : ${message}");
  });
  
 
  
  channels.onClick.listen((MouseEvent event) {
  

  
  ws.close();
  window.location.assign('channels.html');
  
  });

  ws.addEventListener('message', (event) {
     String message = event.data;
     
     output.innerHtml += '<p>${message}</p>';
  }); 
  
  }



}
