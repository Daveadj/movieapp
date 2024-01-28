import 'package:movieapp/domain/entities/language_entity.dart';

class Languages {
  const Languages._();
  static final languages = [
    LanguageEntity(code: 'en', value: 'English'),
    LanguageEntity(code: 'es', value: 'Spanish'),

  ];
}
