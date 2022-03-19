import 'package:xml/xml.dart';

import 'package:opml/src/builder.dart';
import 'package:opml/src/mappable.dart';
import 'package:opml/src/extensions.dart';

/// Represents an outline element of an OPML document. Each outline element may
/// contain zero or more outline child-elements.
class OpmlOutline implements Mappable {
  /// The element's text attribute.
  final String? text;

  /// [title] is probably the same as [text], it should not be omitted. [title]
  /// contains the top-level title element from the feed.
  final String? title;

  /// A String indicating how the other attributes of the outline are interpreted.
  final String? type;

  /// A boolean indicating whether the outline is commented or not.
  final bool? isComment;

  /// A boolean indicating whether or not a breakpoint is set on this outline.
  final bool? isBreakpoint;

  /// The date-time the outline was created.
  final String? created;

  /// A string of comma-separated slash-delimited category strings, in the
  /// format defined by the RSS 2.0 category element.
  final String? category;

  /// The top-level description element from the feed.
  final String? description;

  /// The value of the top-level language element.
  final String? language;

  /// The top-level link element of the feed.
  final String? htmlUrl;

  /// The HTTP address of the feed.
  final String? xmlUrl;

  /// The version of RSS that's being supplied.
  final String? version;

  /// An [Iterable] of this object's child elements. If [children] is empty, then
  /// this element has no outline sub-elements.
  final Iterable<OpmlOutline>? children;

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

  OpmlOutline._build(OpmlOutlineBuilder builder)
      : text = builder._text,
        title = builder._title,
        type = builder._type,
        isComment = builder._isComment,
        isBreakpoint = builder._isBreakpoint,
        created = builder._created,
        category = builder._category,
        description = builder._description,
        language = builder._language,
        htmlUrl = builder._htmlUrl,
        xmlUrl = builder._xmlUrl,
        version = builder._version,
        children = builder._children;

  factory OpmlOutline.parse(XmlElement element) {
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

  @override
  Map<String, dynamic> toMap() {
    return {
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

class OpmlOutlineBuilder implements Builder<OpmlOutline> {
  String? _text;
  String? _title;
  String? _type;
  bool? _isComment;
  bool? _isBreakpoint;
  String? _created;
  String? _category;
  String? _description;
  String? _language;
  String? _htmlUrl;
  String? _xmlUrl;
  String? _version;
  List<OpmlOutline>? _children;

  @override
  OpmlOutline build() => OpmlOutline._build(this);

  OpmlOutlineBuilder text(String text) {
    _text = text;
    return this;
  }

  OpmlOutlineBuilder title(String title) {
    _title = title;
    return this;
  }

  OpmlOutlineBuilder type(String type) {
    _type = type;
    return this;
  }

  OpmlOutlineBuilder isComment(bool isComment) {
    _isComment = isComment;
    return this;
  }

  OpmlOutlineBuilder isBreakpoint(bool isBreakpoint) {
    _isBreakpoint = isBreakpoint;
    return this;
  }

  OpmlOutlineBuilder created(String created) {
    _created = created;
    return this;
  }

  OpmlOutlineBuilder category(String category) {
    _category = category;
    return this;
  }

  OpmlOutlineBuilder description(String description) {
    _description = description;
    return this;
  }

  OpmlOutlineBuilder language(String language) {
    _language = language;
    return this;
  }

  OpmlOutlineBuilder htmlUrl(String htmlUrl) {
    _htmlUrl = htmlUrl;
    return this;
  }

  OpmlOutlineBuilder xmlUrl(String xmlUrl) {
    _xmlUrl = xmlUrl;
    return this;
  }

  OpmlOutlineBuilder version(String version) {
    _version = version;
    return this;
  }

  OpmlOutlineBuilder addChild(OpmlOutline outline) {
    _children ??= <OpmlOutline>[];
    _children!.add(outline);
    return this;
  }
}
