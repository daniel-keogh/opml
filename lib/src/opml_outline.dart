import 'package:xml/xml.dart';

import 'package:opml/src/utils.dart';

/// Represents an outline element of an OPML document. Each outline element may
/// contain zero or more outline child-elements.
class OpmlOutline {
  /// The element's text attribute.
  final String text;

  /// [title] is probably the same as [text], it should not be omitted. [title]
  /// contains the top-level title element from the feed.
  final String title;

  /// A String indicating how the other attributes of the outline are interpreted.
  final String type;

  /// A boolean indicating whether the outline is commented or not.
  final bool isComment;

  /// A boolean indicating whether or not a breakpoint is set on this outline.
  final bool isBreakpoint;

  /// The date-time the outline was created.
  final String created;

  /// A string of comma-separated slash-delimited category strings, in the
  /// format defined by the RSS 2.0 category element.
  final String category;

  /// The top-level description element from the feed.
  final String description;

  /// The value of the top-level language element.
  final String language;

  /// The top-level link element of the feed.
  final String htmlUrl;

  /// The HTTP address of the feed.
  final String xmlUrl;

  /// The version of RSS that's being supplied.
  final String version;

  /// An [Iterable] of this object's child elements. If [children] is empty, then
  /// this element has no outline sub-elements.
  final Iterable<OpmlOutline> children;

  OpmlOutline({
    this.text,
    this.title,
    this.type,
    this.isComment,
    this.isBreakpoint,
    this.created,
    this.category,
    this.description,
    this.language,
    this.htmlUrl,
    this.xmlUrl,
    this.version,
    this.children,
  });

  factory OpmlOutline.parse(XmlElement element) {
    if (element == null) {
      throw ArgumentError('element should not be null');
    }

    final text = element.getAttribute('text');
    final title = element.getAttribute('title');
    final type = element.getAttribute('type');
    final isComment = element.getAttribute('isComment');
    final isBreakpoint = element.getAttribute('isBreakpoint');
    final created = element.getAttribute('created');
    final category = element.getAttribute('category');
    final description = element.getAttribute('description');
    final language = element.getAttribute('language');
    final htmlUrl = element.getAttribute('htmlUrl');
    final xmlUrl = element.getAttribute('xmlUrl');
    final version = element.getAttribute('version');

    // Recursively parse this element's children
    final children = <OpmlOutline>[];

    element.findElements('outline').forEach((child) {
      children.add(
        OpmlOutline.parse(child),
      );
    });

    return OpmlOutline(
      text: text,
      title: title,
      type: type,
      isComment: isComment.parseBool(),
      isBreakpoint: isBreakpoint.parseBool(),
      created: created,
      category: category,
      description: description,
      language: language,
      htmlUrl: htmlUrl,
      xmlUrl: xmlUrl,
      version: version,
      children: children,
    );
  }

  /// Converts this object to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'title': title,
      'type': type,
      'isComment': isComment,
      'isBreakpoint': isBreakpoint,
      'created': created,
      'category': category,
      'description': description,
      'language': language,
      'htmlUrl': htmlUrl,
      'xmlUrl': xmlUrl,
      'version': version,
    };
  }
}
