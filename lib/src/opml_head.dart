import 'package:xml/xml.dart';

import 'package:opml/src/utils.dart';

/// Represents the head element of an OPML document, containing the document's
/// metadata. All fields are optional.
class OpmlHead {
  /// The title of the document.
  final String title;

  /// When the document was created.
  final String dateCreated;

  /// When the document was last modified.
  final String dateModified;

  /// The owner of the document.
  final String ownerName;

  /// The email address of the document's owner.
  final String ownerEmail;

  /// A link to the website of the document's owner. It also may be used to
  /// identify the author.
  final String ownerId;

  /// A link to documentation about the format used in the OPML file.
  final String docs;

  /// A comma-separated list of line numbers that are expanded. The line numbers
  /// tell you which headlines to expand.
  final String expansionState;

  /// A number indicating which line of the outline is displayed on the top line
  /// of the window.
  final int vertScrollState;

  /// The pixel location of the top edge of the window.
  final int windowTop;

  /// The pixel location of the left edge of the window.
  final int windowLeft;

  /// The pixel location of the bottom edge of the window.
  final int windowBottom;

  /// The pixel location of the right edge of the window.
  final int windowRight;

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

  factory OpmlHead.parse(XmlElement head) {
    if (head == null) {
      return null;
    }

    final title = findFirstChildByName(head, 'title')?.text;
    final dateCreated = findFirstChildByName(head, 'dateCreated')?.text;
    final dateModified = findFirstChildByName(head, 'dateModified')?.text;
    final ownerName = findFirstChildByName(head, 'ownerName')?.text;
    final ownerEmail = findFirstChildByName(head, 'ownerEmail')?.text;
    final ownerId = findFirstChildByName(head, 'ownerId')?.text;
    final docs = findFirstChildByName(head, 'docs')?.text;
    final expansionState = findFirstChildByName(head, 'expansionState')?.text;
    final vertScrollState = findFirstChildByName(head, 'vertScrollState')?.text;
    final windowTop = findFirstChildByName(head, 'windowTop')?.text;
    final windowLeft = findFirstChildByName(head, 'windowLeft')?.text;
    final windowRight = findFirstChildByName(head, 'windowRight')?.text;
    final windowBottom = findFirstChildByName(head, 'windowBottom')?.text;

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

  /// Converts this object to a [Map].
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
