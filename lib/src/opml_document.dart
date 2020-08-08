import 'package:xml/xml.dart';

import 'package:meta/meta.dart';

import 'package:opml/src/opml_head.dart';
import 'package:opml/src/opml_outline.dart';
import 'package:opml/src/utils.dart';

/// An object representing an XML document in the OPML
/// (Outline Processor Markup Language) file format.
class OpmlDocument {
  /// The document's head element.
  final OpmlHead head;

  /// The document's body element.
  /// It is represented as an [Iterable] of [OpmlOutline] objects.
  final Iterable<OpmlOutline> body;

  OpmlDocument({
    @required this.head,
    @required this.body,
  })  : assert(head != null),
        assert(body != null);

  /// Parses an [xmlString] as OPML.
  ///
  /// Throws a [FormatException] if the input is invalid.
  factory OpmlDocument.parse(String xmlString) {
    XmlDocument document;

    try {
      document = parse(xmlString);
    } on XmlParserException catch (e) {
      throw FormatException('Invalid XML input', e.source, e.position);
    }

    final opmlElement = findFirstChildByName(document, 'opml');
    final headElement = findFirstChildByName(opmlElement, 'head');
    final bodyElement = findFirstChildByName(opmlElement, 'body');

    if (opmlElement == null) throw FormatException('<opml> element not found');
    if (headElement == null) throw FormatException('<head> element not found');
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

  /// Returns this object as XML.
  ///
  /// If [pretty] is set to true the output is nicely formatted, otherwise the
  /// tree is emitted verbatim. The option [indent] is only used when [pretty]
  /// is true, and allows for customizing the indention. By default, nodes are
  /// indented with 2 spaces.
  String toXmlString({String indent = '  ', bool pretty = false}) {
    final builder = XmlBuilder();

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('opml', nest: () {
      builder.attribute('version', '2.0');
      _buildHead(builder);
      _buildBody(builder);
    });

    final xmlNode = builder.build();

    return xmlNode.toXmlString(
      indent: indent,
      pretty: pretty,
    );
  }

  void _buildHead(XmlBuilder builder) {
    final elements = head.toMap();

    // Remove null values so no empty elements are included.
    elements.removeWhere((name, value) => value == null);

    builder.element(
      'head',
      isSelfClosing: false,
      nest: () {
        elements.forEach((name, value) {
          builder.element(name, nest: () => builder.text(value));
        });
      },
    );
  }

  void _buildBody(XmlBuilder builder) {
    builder.element(
      'body',
      isSelfClosing: false,
      nest: () => _buildOutlines(builder, body),
    );
  }

  void _buildOutlines(XmlBuilder builder, Iterable<OpmlOutline> outlines) {
    outlines.forEach((outline) {
      final elements = outline.toMap();

      // Remove null values so no empty attributes are included.
      elements.removeWhere((name, value) => value == null);

      builder.element('outline', nest: () {
        elements.forEach((name, value) => builder.attribute(name, value));

        if (outline.children != null && outline.children.isNotEmpty) {
          _buildOutlines(builder, outline.children);
        }
      });
    });
  }
}
