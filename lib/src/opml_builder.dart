import 'package:xml/xml.dart';

import 'package:opml/src/opml_document.dart';
import 'package:opml/src/opml_head.dart';
import 'package:opml/src/opml_outline.dart';

/// Helper class that handles the conversion of an [OpmlDocument] to an [XmlNode].
class OpmlBuilder {
  static XmlBuilder _builder;

  OpmlBuilder._();

  /// Converts an [OpmlDocument] object to an [XmlNode].
  static XmlNode build(OpmlDocument document) {
    _builder = XmlBuilder();
    _builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    _builder.element('opml', nest: () {
      _builder.attribute('version', '2.0');
      _buildHead(document.head);
      _buildBody(document.body);
    });

    return _builder.build();
  }

  static void _buildHead(OpmlHead head) {
    final elements = head.toMap();

    // Remove null values so no empty elements are included.
    elements.removeWhere((key, value) => value == null);

    _builder.element(
      'head',
      isSelfClosing: false,
      nest: () {
        elements.forEach((name, value) {
          _builder.element(name, nest: () => _builder.text(value));
        });
      },
    );
  }

  static void _buildBody(Iterable<OpmlOutline> body) {
    _builder.element(
      'body',
      isSelfClosing: false,
      nest: () => _buildOutlines(body),
    );
  }

  static void _buildOutlines(Iterable<OpmlOutline> outlines) {
    outlines.forEach((outline) {
      final elements = outline.toMap();

      // Remove null values so no empty attributes are included.
      elements.removeWhere((key, value) => value == null);

      _builder.element('outline', nest: () {
        elements.forEach((name, value) => _builder.attribute(name, value));

        if (outline.children != null && outline.children.isNotEmpty) {
          // Build this outline's sub-elements.
          _buildOutlines(outline.children);
        }
      });
    });
  }
}
