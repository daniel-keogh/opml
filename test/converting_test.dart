import 'package:test/test.dart';
import 'package:opml/opml.dart';

void main() {
  group('converting to XML', () {
    test('should convert an OpmlDocument to an XML string', () {
      final head = OpmlHeadBuilder().title('Example Export').build();
      final body = <OpmlOutline>[];

      body.add(OpmlOutlineBuilder()
          .text('World')
          .addChild(OpmlOutlineBuilder()
              .type('rss')
              .text('BBC News')
              .xmlUrl('http://feeds.bbci.co.uk/...')
              .build())
          .build());

      final opml = OpmlDocument(
        head: head,
        body: body,
      );

      expect(
        opml.toXmlString(),
        '<?xml version="1.0" encoding="UTF-8"?><opml version="2.0"><head><title>Example Export</title></head><body><outline text="World"><outline text="BBC News" type="rss" xmlUrl="http://feeds.bbci.co.uk/..."/></outline></body></opml>',
      );
    });

    test('should convert an empty document without errors', () {
      final opml = OpmlDocument(
        head: OpmlHead(),
        body: [],
      );

      expect(
        opml.toXmlString(),
        '<?xml version="1.0" encoding="UTF-8"?><opml version="2.0"><head></head><body></body></opml>',
      );
    });
  });
}
