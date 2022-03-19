# opml

[![Pub](https://img.shields.io/pub/v/opml.svg)](https://pub.dartlang.org/packages/opml)
[![Build Status](https://github.com/daniel-keogh/opml/actions/workflows/dart.yml/badge.svg?branch=master)](https://github.com/daniel-keogh/opml/actions/workflows/dart.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A Dart package for parsing and building [OPML](http://opml.org/spec2.opml) documents.

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

You can convert an `OpmlDocument` object to XML by first constructing the object and then calling `toXmlString()` on it.

```dart
  final head = OpmlHeadBuilder().title('Example Export').build();
  final body = <OpmlOutline>[];

  body.add(OpmlOutlineBuilder()
      .text('World')
      .title('World')
      .addChild(OpmlOutlineBuilder()
          .type('rss')
          .text('BBC News - World')
          .title('BBC News - World')
          .xmlUrl('http://feeds.bbci.co.uk/news/world/rss.xml')
          .build())
      .addChild(OpmlOutlineBuilder()
          .type('rss')
          .text('World news | The Guardian')
          .title('World news | The Guardian')
          .xmlUrl('http://feeds.guardian.co.uk/theguardian/world/rss')
          .build())
      .build());

  body.add(OpmlOutlineBuilder()
      .text('Uncategorized')
      .title('Uncategorized')
      .build());

  final opml = OpmlDocument(
    head: head,
    body: body,
  );

  final xml = opml.toXmlString(pretty: true);

  print(xml);
```

## License

MIT
