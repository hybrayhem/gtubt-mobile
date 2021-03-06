import 'package:GTUBT/service/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GTUBT/models/event.dart';
import 'package:http/http.dart';

void main() {
  test('Update Event with an ID', () async {
    Event event = await EventService().get("JlhujcKnR5wpwbgTJRYe");
    expect(event == null, false);

    event.title = "title";
    
    Response response = await EventService().patch(event);
    expect(response == null, false);
    expect(response.statusCode, 200);

    event = await EventService().get("JlhujcKnR5wpwbgTJRYe");
    expect(event == null, false);
    expect(event.title, "Title");
  });
  test('Get Event with an ID', () async {
    Event event = await EventService().get("JlhujcKnR5wpwbgTJRYe");
    expect(event == null, false);
    expect(event.title, "Title");
  });
}
