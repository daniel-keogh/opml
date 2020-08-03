import 'package:opml/opml.dart';

// Creates an OpmlDocument object and prints it to the screen as XML.
void main() {
  final body = <OpmlOutline>[
    OpmlOutline(
      text: 'World',
      title: 'World',
      children: [
        OpmlOutline(
          type: 'rss',
          text: 'BBC News - World',
          title: 'BBC News - World',
          xmlUrl: 'http://feeds.bbci.co.uk/news/world/rss.xml',
        ),
        OpmlOutline(
          type: 'rss',
          text: 'World news | The Guardian',
          title: 'World news | The Guardian',
          xmlUrl: 'http://feeds.guardian.co.uk/theguardian/world/rss',
        ),
      ],
    ),
    OpmlOutline(
      text: 'Uncategorized',
      title: 'Uncategorized',
    ),
  ];

  final opml = OpmlDocument(
    head: OpmlHead(
      title: 'Example Export',
    ),
    body: body,
  );

  final xml = opml.toXmlString(
    pretty: true,
  );

  print(xml);
}
