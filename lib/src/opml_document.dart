import 'package:xml/xml.dart';

import 'package:opml/src/opml_builder.dart';
import 'package:opml/src/opml_head.dart';
import 'package:opml/src/opml_outline.dart';
import 'package:opml/src/extensions.dart';

/// An object representing an XML document in the OPML
/// (Outline Processor Markup Language) file format.
class OpmlDocument {
  /// The document's head element.
  final OpmlHead head;

  /// The document's body element.
  /// It is represented as an [Iterable] of [OpmlOutline] objects.
  final Iterable<OpmlOutline> body;

  OpmlDocument({
    required this.head,
    required this.body,
  });

  /// Parses an [xmlString] as OPML.
  ///
  /// Throws a [FormatException] if the input is invalid.
  factory OpmlDocument.parse(String xmlString) {
    XmlDocument document;

    try {
      document = XmlDocument.parse(xmlString);
    } on XmlParserException catch (e) {
      throw FormatException('Invalid XML input', e.source, e.position);
    }

    final opmlElement = document.findFirstChildByName('opml');
    if (opmlElement == null) throw FormatException('<opml> element not found');

    final headElement = opmlElement.findFirstChildByName('head');
    if (headElement == null) throw FormatException('<head> element not found');

    final bodyElement = opmlElement.findFirstChildByName('body');
    if (bodyElement == null) throw FormatException('<body> element not found');

    // Parse the body
    final body = <OpmlOutline>[];
    bodyElement
        .findElements('outline')
        .forEach((e) => body.add(OpmlOutline.parse(e)));

    return OpmlDocument(
      head: OpmlHead.parse(headElement),
      body: body,
    );
  }

  /// Returns this object as an XML String.
  ///
  /// If [pretty] is set to true the output is nicely formatted, otherwise the
  /// tree is emitted verbatim. The option [indent] is only used when [pretty]
  /// is true, and allows for customizing the indention. By default, nodes are
  /// indented with 2 spaces.
  String toXmlString({String indent = '  ', bool pretty = false}) {
    final xmlNode = OpmlBuilder.build(this);

    return xmlNode.toXmlString(
      indent: indent,
      pretty: pretty,
    );
  }

  @override
  String toString() => toXmlString();
}
