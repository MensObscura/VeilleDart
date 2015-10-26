import 'dart:html';

void main() {
  InputElement nickname = querySelector('#nickname');
  DivElement output = querySelector('#output');
  TextAreaElement input = querySelector('#input');
  ButtonElement send = querySelector('#send');
  ButtonElement savenickname = querySelector('#savenickname');
  WebSocket ws = new WebSocket('ws://localhost:9090');

  savenickname.onClick.listen((MouseEvent event) {
    if (nickname.value != '') {
      nickname.readOnly = true;
    }
  });

  send.onClick.listen((MouseEvent event) {
    if (nickname.value != '' && nickname.readOnly) {
      String message = input.value;
      input.value = '';
      input.focus();
      ws.send("${nickname.value}: ${message}");
    }
  });

  ws.addEventListener('message', (event) {
     String message = event.data;
     output.innerHtml += '<p>${message}</p>';
  });
}