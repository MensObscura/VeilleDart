import 'dart:html';
import 'dart:convert' show UTF8, JSON;

main() async {
  
  HttpClientResponse response = await request.close();
  await for (var contents in response.transform(UTF8.decoder)) {
    print(contents);
  }
}
