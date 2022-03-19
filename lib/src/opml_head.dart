import 'package:xml/xml.dart';

import 'package:opml/src/builder.dart';
import 'package:opml/src/mappable.dart';
import 'package:opml/src/extensions.dart';

/// Represents the head element of an OPML document, containing the document's
/// metadata. All fields are optional.
class OpmlHead implements Mappable {
  /// The title of the document.
  final String? title;

  /// A date-time, indicating when the document was created.
  final String? dateCreated;

  /// A date-time, indicating when the document was last modified.
  final String? dateModified;

  /// The owner of the document.
  final String? ownerName;

  /// The email address of the document's owner.
  final String? ownerEmail;

  /// A link to the website of the document's owner. It also may be used to
  /// identify the author.
  final String? ownerId;

  /// A link to documentation about the format used in the OPML file.
  final String? docs;

  /// A comma-separated list of line numbers that are expanded. The line numbers
  /// tell you which headlines to expand.
  final String? expansionState;

  /// A number indicating which line of the outline is displayed on the top line
  /// of the window.
  final int? vertScrollState;

  /// The pixel location of the top edge of the window.
  final int? windowTop;

  /// The pixel location of the left edge of the window.
  final int? windowLeft;

  /// The pixel location of the bottom edge of the window.
  final int? windowBottom;

  /// The pixel location of the right edge of the window.
  final int? windowRight;

  OpmlHead({
    this.title,
    this.dateCreated,
    this.dateModified,
    this.ownerName,
    this.ownerEmail,
    this.ownerId,
    this.docs,
    this.expansionState,
    this.vertScrollState,
    this.windowTop,
    this.windowLeft,
    this.windowRight,
    this.windowBottom,
  });

  OpmlHead._build(OpmlHeadBuilder builder)
      : title = builder._title,
        dateCreated = builder._dateCreated,
        dateModified = builder._dateModified,
        ownerName = builder._ownerName,
        ownerEmail = builder._ownerEmail,
        ownerId = builder._ownerId,
        docs = builder._docs,
        expansionState = builder._expansionState,
        vertScrollState = builder._vertScrollState,
        windowTop = builder._windowTop,
        windowLeft = builder._windowLeft,
        windowRight = builder._windowRight,
        windowBottom = builder._windowBottom;

  factory OpmlHead.parse(XmlElement head) {
    final title = head.findFirstChildByName('title')?.text;
    final dateCreated = head.findFirstChildByName('dateCreated')?.text;
    final dateModified = head.findFirstChildByName('dateModified')?.text;
    final ownerName = head.findFirstChildByName('ownerName')?.text;
    final ownerEmail = head.findFirstChildByName('ownerEmail')?.text;
    final ownerId = head.findFirstChildByName('ownerId')?.text;
    final docs = head.findFirstChildByName('docs')?.text;
    final expansionState = head.findFirstChildByName('expansionState')?.text;
    final vertScrollState = head.findFirstChildByName('vertScrollState')?.text;
    final windowTop = head.findFirstChildByName('windowTop')?.text;
    final windowLeft = head.findFirstChildByName('windowLeft')?.text;
    final windowRight = head.findFirstChildByName('windowRight')?.text;
    final windowBottom = head.findFirstChildByName('windowBottom')?.text;

    return OpmlHead(
      title: title,
      dateCreated: dateCreated,
      dateModified: dateModified,
      ownerName: ownerName,
      ownerEmail: ownerEmail,
      ownerId: ownerId,
      docs: docs,
      expansionState: expansionState,
      vertScrollState: vertScrollState.parseInt(),
      windowTop: windowTop.parseInt(),
      windowLeft: windowLeft.parseInt(),
      windowRight: windowRight.parseInt(),
      windowBottom: windowBottom.parseInt(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'dateCreated': dateCreated,
      'dateModified': dateModified,
      'ownerName': ownerName,
      'ownerEmail': ownerEmail,
      'ownerId': ownerId,
      'docs': docs,
      'expansionState': expansionState,
      'vertScrollState': vertScrollState,
      'windowTop': windowTop,
      'windowLeft': windowLeft,
      'windowRight': windowRight,
      'windowBottom': windowBottom,
    };
  }
}

class OpmlHeadBuilder implements Builder<OpmlHead> {
  String? _title;
  String? _dateCreated;
  String? _dateModified;
  String? _ownerName;
  String? _ownerEmail;
  String? _ownerId;
  String? _docs;
  String? _expansionState;
  int? _vertScrollState;
  int? _windowTop;
  int? _windowLeft;
  int? _windowBottom;
  int? _windowRight;

  @override
  OpmlHead build() => OpmlHead._build(this);

  OpmlHeadBuilder title(String title) {
    _title = title;
    return this;
  }

  OpmlHeadBuilder dateCreated(String dateCreated) {
    _dateCreated = dateCreated;
    return this;
  }

  OpmlHeadBuilder dateModified(String dateModified) {
    _dateModified = dateModified;
    return this;
  }

  OpmlHeadBuilder ownerName(String ownerName) {
    _ownerName = ownerName;
    return this;
  }

  OpmlHeadBuilder ownerEmail(String ownerEmail) {
    _ownerEmail = ownerEmail;
    return this;
  }

  OpmlHeadBuilder ownerId(String ownerId) {
    _ownerId = ownerId;
    return this;
  }

  OpmlHeadBuilder docs(String docs) {
    _docs = docs;
    return this;
  }

  OpmlHeadBuilder expansionState(String expansionState) {
    _expansionState = expansionState;
    return this;
  }

  OpmlHeadBuilder vertScrollState(int vertScrollState) {
    _vertScrollState = vertScrollState;
    return this;
  }

  OpmlHeadBuilder windowTop(int windowTop) {
    _windowTop = windowTop;
    return this;
  }

  OpmlHeadBuilder windowLeft(int windowLeft) {
    _windowLeft = windowLeft;
    return this;
  }

  OpmlHeadBuilder windowRight(int windowRight) {
    _windowRight = windowRight;
    return this;
  }

  OpmlHeadBuilder windowBottom(int windowBottom) {
    _windowBottom = windowBottom;
    return this;
  }
}
