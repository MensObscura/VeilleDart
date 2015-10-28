import 'dart:html';
import 'dart:convert' show UTF8, JSON;

 ButtonElement go = querySelector('#send');
 InputElement nickname = querySelector('#pseudo');
 DivElement error = querySelector('#error');

void main() async{


  go.onClick.listen((MouseEvent event) {
  String nick = nickname.value ;
  nick.trim();
  if (nick != '') {
   post();
   Storage localStorage = window.localStorage;
   localStorage['username'] = nickname.value;
  
   window.location.assign('chat.html');
   }else{
    error.innerHtml = '<p>Le champ doit etre remplit</p>';
   }
  });


}

Future post() async{
	var url = 'http://localhost:8080';
    var data = {'pseudo':'${nickname.value}'};
    var request = new HttpRequest()
    				..open('POST', url)
    				..send(JSON.encode(data));

}


