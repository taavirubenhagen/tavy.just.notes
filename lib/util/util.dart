String readableTitle(Map<String, dynamic>? data, {body = false, headline = true}) {
  if (body) {
    String body = data?["body"] ?? "text";
    if (body == "") return "[No Text]";
    return body;
  }
  String title = data?["title"] ?? "note";
  if (title == "") return headline ? "[No Title]" : "note";
  return title;
}