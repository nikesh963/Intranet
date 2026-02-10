extension CapitalizedString on String {
  /// Capitalize the first letter of a string
  String get capitalizeFirsted {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  // String get capitalizeFirst {
  //   if (isEmpty) return this;
  //   return this[0].toUpperCase() + substring(1);
  // }



  /// Capitalize the first letter of each word in a string
  String get capitalizeEachWord {
    if (isEmpty) return this;
    return split(' ')
        .map((word) =>
    word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '')
        .join(' ');
  }
}