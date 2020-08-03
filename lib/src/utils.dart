import 'package:xml/xml.dart';

/// Finds the first child element of [parent] by its [name].
/// Returns null if the element could not be found.
XmlElement findFirstChildByName(XmlParent parent, String name) {
  try {
    return parent.findElements(name).first;
  } on StateError {
    return null;
  }
}

extension StringParsing on String {
  /// Converts a [String] to a [bool], returning null if the conversion fails.
  bool parseBool() {
    if (this == null) {
      return null;
    }

    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }

    return null;
  }

  /// Converts a [String] to an [int], returning null if the conversion fails.
  int parseInt() => this != null ? int.tryParse(this) : null;
}
