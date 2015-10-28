import 'dart:html';
import 'dart:convert' show UTF8, JSON;

ButtonElement go = querySelector('#send');
InputElement nickname = querySelector('#pseudo');
DivElement error = querySelector('#error');

Storage localStorage = window.localStorage;

void main() async {

  go.onClick.listen((MouseEvent event) {
    String nick = nickname.value;
    nick.trim();

    if(nick != '') {
      post();

      localStorage['username'] = nickname.value;
       localStorage['channel'] = 'Hall';
      window.location.assign('chat.html');

    } else {
      error.innerHtml = '<p>Le champ doit etre rempli</p>';
    }
  });


}

Future post() async{
	var url = 'http://localhost:8080';
    var data = {'pseudo':'${nickname.value}','channel':'Hall'};
    var request = new HttpRequest()..open('POST', url)
    				                       ..send(JSON.encode(data));

}


