import 'dart:io';

import 'package:test/test.dart';
import 'package:opml/opml.dart';

void main() {
  group('parsing XML', () {
    test("should parse a valid OPML document's head", () {
      final xmlString = File('test/xml/valid.xml').readAsStringSync();

      final doc = OpmlDocument.parse(xmlString);

      expect(doc.head.title, 'OPML Export');
      expect(doc.head.dateCreated, 'Mon, 03 Aug 2020 13:35:00 GMT');
      expect(doc.head.dateModified, 'Mon, 03 Aug 2020 21:12:00 GMT');
      expect(doc.head.ownerName, 'John Smith');
      expect(doc.head.ownerEmail, 'jsmith@example.com');
      expect(doc.head.ownerId, 'http://somewebsite.com');
      expect(doc.head.docs, 'http://dev.opml.org/spec2.html');
      expect(doc.head.expansionState, '1,2,3,4,5');
      expect(doc.head.vertScrollState, 1);
      expect(doc.head.windowTop, 1);
      expect(doc.head.windowLeft, 2);
      expect(doc.head.windowBottom, 3);
      expect(doc.head.windowRight, 4);
    });

    test("should parse a valid OPML document's body", () {
      final xmlString = File('test/xml/valid.xml').readAsStringSync();

      final doc = OpmlDocument.parse(xmlString);

      expect(doc.body.length, 2);

      final outlines = doc.body.toList();
      expect(outlines[0].text, 'Technology');
      expect(outlines[0].title, 'Technology');
      expect(outlines[0].type, null);
      expect(outlines[0].isComment, null);
      expect(outlines[0].isBreakpoint, null);
      expect(outlines[0].created, null);
      expect(outlines[0].category, null);
      expect(outlines[0].description, null);
      expect(outlines[0].language, null);
      expect(outlines[0].htmlUrl, null);
      expect(outlines[0].xmlUrl, null);
      expect(outlines[0].version, null);
      expect(outlines[0].children!.length, 1);

      expect(outlines[1].text, 'Some Category');
      expect(outlines[1].title, null);
      expect(outlines[1].type, null);
      expect(outlines[1].isComment, null);
      expect(outlines[1].isBreakpoint, null);
      expect(outlines[1].created, null);
      expect(outlines[1].category, null);
      expect(outlines[1].description, null);
      expect(outlines[1].language, null);
      expect(outlines[1].htmlUrl, null);
      expect(outlines[1].xmlUrl, null);
      expect(outlines[1].version, null);
      expect(outlines[1].children!.length, 0);

      final children = outlines[0].children!.toList();
      expect(children[0].text, 'Technology | The Guardian');
      expect(children[0].title, 'Technology | The Guardian');
      expect(children[0].type, 'rss');
      expect(children[0].isComment, null);
      expect(children[0].isBreakpoint, null);
      expect(children[0].created, null);
      expect(children[0].category, null);
      expect(children[0].description, null);
      expect(children[0].language, null);
      expect(children[0].htmlUrl, 'https://www.theguardian.com/us/technology');
      expect(children[0].xmlUrl, 'http://www.theguardian.com/technology/rss');
      expect(children[0].version, null);
      expect(children[0].children!.length, 0);
    });

    test('should throw a FormatException if the document has no head', () {
      final xmlString = File('test/xml/no_head.xml').readAsStringSync();
      expect(() => OpmlDocument.parse(xmlString), throwsFormatException);
    });

    test('should throw a FormatException if the document has no body', () {
      final xmlString = File('test/xml/no_body.xml').readAsStringSync();
      expect(() => OpmlDocument.parse(xmlString), throwsFormatException);
    });

    test('should throw a FormatException if given an empty string', () {
      expect(() => OpmlDocument.parse(''), throwsFormatException);
    });
  });
}
