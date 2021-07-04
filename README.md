# opml

[![Pub](https://img.shields.io/pub/v/opml.svg)](https://pub.dartlang.org/packages/opml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A Dart package for parsing and building [OPML](http://dev.opml.org/spec2.html) documents.

## Installing

Import the package into your Dart code using:

```dart
import 'package:opml/opml.dart';
```

## Examples

### Parsing XML

To parse XML input, use the `OpmlDocument.parse(String xmlString)` factory:

```dart
final xmlString = """
<?xml version='1.0' encoding='UTF-8' ?>
<opml version="1.0">
  <head>
    <title>Example OPML Export</title>
  </head>
  <body>
    <outline text="World" title="World">
      <outline type="rss" text="BBC News - World" xmlUrl="http://feeds.bbci.co.uk/..." />
      <outline type="rss" text="World news | The Guardian" xmlUrl="http://feeds.guardian.co.uk/..." />
    </outline>
    <outline text="Uncategorized" title="Uncategorized" />
  </body>
</opml>
""";

final opml = OpmlDocument.parse(xmlString);
```

### Converting to XML

You can convert an `OpmlDocument` object into XML by calling `toXmlString()` on it.

```dart
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
    title: 'Example OPML Export',
  ),
  body: body,
);

final xml = opml.toXmlString(
  pretty: true,
);

print(xml);
```

## License

MIT
