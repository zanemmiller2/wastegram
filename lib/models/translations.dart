import 'dart:ui';

class Translations {
  Locale locale;
  Translations({required this.locale});

  final labels = {
    'en' : {
      'quantityFieldHint': 'Number of Wasted Items'
    }
  };

  String? get quantityFieldHint => labels[locale.languageCode]!['quantityFieldHint'];
}
