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
  

  send.onClick.listen((MouseEvent event) {
      String message = input.value;
      input.value = '';
      input.focus();
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
