library {{package_name.snakeCase()}};
{{#hasModels}}
export 'src/models/models.dart';{{/hasModels}}
export 'src/{{package_name.snakeCase()}}.dart';