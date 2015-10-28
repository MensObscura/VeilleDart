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
  
  requestComplete(HttpRequest request) {
    ulChannel.innerHtml='';
    if (request.status == 200) {
      List<String> channelList = JSON.decode(request.responseText);
      for (int i = 0; i < channelList.length; i++) {
        ulChannel.children.add(new LIElement()..text = channelList[i]);
      }
    } else {
 
      ulChannel.children.add(new LIElement()..text = 'Request failed, status=${request.status}');
    }
  }
  
  channels.onClick.listen((MouseEvent event) {
  
    var url = 'http://localhost:8080';
    print(url);
    var request = new HttpRequest();
    request..open('GET', url)
     		   ..onLoadEnd.listen((e) => requestComplete(request))
      		 ..send('');
  });

  ws.addEventListener('message', (event) {
     String message = event.data;
     output.innerHtml += '<p>${message}</p>';
  }); 
  
}
