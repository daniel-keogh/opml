import 'package:xml/xml.dart';

extension XMLExtensions on XmlNode {
  /// Finds the first child element of a node by its [name].
  /// Returns null if the element could not be found.
  XmlElement? findFirstChildByName(String name) {
    try {
      return findElements(name).first;
    } on StateError {
      return null;
    }
  }
}

extension StringParsing on String? {
  /// Converts a [String] to a [bool], returning null if the conversion fails.
  bool? parseBool() {
    if (this == null) {
      return null;
    }

    switch (this!.toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return null;
    }
  }

  /// Converts a [String] to an [int], returning null if the conversion fails.
  int? parseInt() => this != null ? int.tryParse(this!) : null;
}
