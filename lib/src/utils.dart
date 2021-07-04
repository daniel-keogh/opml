import 'package:xml/xml.dart';

/// Finds the first child element of [parent] by its [name].
/// Returns null if the element could not be found.
XmlElement? findFirstChildByName(XmlNode node, String name) {
  try {
    return node.findElements(name).first;
  } on StateError {
    return null;
  }
}

extension StringParsing on String? {
  /// Converts a [String] to a [bool], returning null if the conversion fails.
  bool? parseBool() {
    if (this == null) {
      return null;
    }

    if (this!.toLowerCase() == 'true') {
      return true;
    } else if (this!.toLowerCase() == 'false') {
      return false;
    }

    return null;
  }

  /// Converts a [String] to an [int], returning null if the conversion fails.
  int? parseInt() => this != null ? int.tryParse(this!) : null;
}
