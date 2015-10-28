import 'dart:html';
import 'dart:convert' show UTF8, JSON;


void main() {

  DivElement output = querySelector('#output');
  TextAreaElement input = querySelector('#input');
  ButtonElement send = querySelector('#send');
  ButtonElement channels = querySelector('#channels');
  UListElement ulChannel =  querySelector('#ulchannels');

  WebSocket ws = new WebSocket('ws://localhost:9090');

  Storage localStorage = window.localStorage;
  String nickname =localStorage['username'];
  
  print ("hello");

  send.onClick.listen((MouseEvent event) {
      String message = input.value;
      input.value = '';
      input.focus();
      ws.send(nickname+" dit : ${message}");
  });
  
 
  
  channels.onClick.listen((MouseEvent event) {
  
  window.open("channels.html","lol","MsgWindows, width=640,height=480,top=100,left=100");
  
  });

  ws.addEventListener('message', (event) {
     String message = event.data;
     output.innerHtml += '<p>${message}</p>';
  }); 
  
  
  
  
}
