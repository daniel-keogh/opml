import 'package:test/test.dart';
import 'package:opml/opml.dart';

void main() {
  test('convert OpmlDocument to XML', () {
    final opml = OpmlDocument(
      head: OpmlHead(
        title: 'Example Export',
      ),
      body: <OpmlOutline>[
        OpmlOutline(
          text: 'World',
          children: [
            OpmlOutline(
              type: 'rss',
              text: 'BBC News',
              xmlUrl: 'http://feeds.bbci.co.uk/...',
            ),
          ],
        ),
      ],
    );

    expect(
      opml.toXmlString(),
      '<?xml version="1.0" encoding="UTF-8"?><opml version="2.0"><head><title>Example Export</title></head><body><outline text="World"><outline text="BBC News" type="rss" xmlUrl="http://feeds.bbci.co.uk/..."/></outline></body></opml>',
    );
  });

  test('convert empty', () {
    final opml = OpmlDocument(
      head: OpmlHead(),
      body: [],
    );

    expect(
      opml.toXmlString(),
      '<?xml version="1.0" encoding="UTF-8"?><opml version="2.0"><head></head><body></body></opml>',
    );
  });
}
