import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

import 'data_types.dart';
import 'exceptions.dart';
import 'property.dart';
import 'string_extensions.dart';

abstract class ModelService {
  /// Verifies if the seeded properties / config is acceptable
  static void verifySeededProperties(
    List<dynamic> seededProperties,
    Logger logger,
  ) {
    for (final property in seededProperties) {
      try {
        // This will throw an exception if we cannot decode the json
        Property.fromJson(jsonEncode(property));
      } catch (e) {
        logger.err('''
Could not parse property: $property
Please check the variable names of your properties. It should be along the lines of:
{ "name": "firstName", "type": "String" }
''');
        exit(0);
      }
    }
  }

  /// Adds properties to the model until the user escapes by entering `e`.
  static void addProperties(
    Logger logger,
    List<Map<String, dynamic>> properties,
  ) {
    logger
      ..info(lightYellow.wrap('enter `e` to exit adding properties'))
      ..info(
        lightYellow
            .wrap('Format: dataType propertyName e.g, String myProperty:'),
      );

    while (true) {
      final property =
          logger.prompt(':').replaceAll(RegExp(r'\s+'), ' ').trim();
      if (property.toLowerCase() == 'e') {
        break;
      }

      if (!property.contains(' ')) {
        logger.alert(
          'That was not a valid format -> dataType propertyName e.g, String myProperty',
        );
        continue;
      }

      if ((property.contains('<') && !property.contains('>')) ||
          (property.contains('>') && !property.contains('<'))) {
        logger.alert(
          'It seems you are missing a < or >, please retype this property',
        );
        continue;
      }

      final splitProperty = property.split(' ');
      final propertyType = splitProperty[0];
      final propertyName = splitProperty[1];
      addProperty(
        properties,
        Property(
          name: propertyName,
          type: propertyType,
          isNullable: propertyType.endsWith('?'),
        ),
      );
    }
  }

  /// Adds a [property] to the [properties] list.
  static void addProperty(
    List<Map<String, dynamic>> properties,
    Property property,
  ) {
    final hasSpecial = property.type.toLowerCase().contains('<') ||
        property.type.toLowerCase().contains('>');
    final listProperties = getCustomListProperties(hasSpecial, property.type);
    final isCustomDataType =
        !DataTypes.values.contains(property.type.cleaned) && !hasSpecial;
    properties
      ..forEach((e) => e['isLastProperty'] = false)
      ..add({
        'name': property.name,
        'type': property.type,
        'isNullable': property.isNullable,
        'hasSpecial': hasSpecial,
        'isCustomDataType': isCustomDataType,
        'isLastProperty': true,
        ...listProperties,
      });
  }

  /// Checks to see if the current output directory is in the lib folder.
  /// Adds the fullPath to the current working directory
  static Future<void> validateDirectory(HookContext context) async {
    final logger = context.logger;
    final directory = Directory.current.path;

    try {
      List<String> folders;

      if (Platform.isWindows) {
        folders = directory.split(r'\').toList();
      } else {
        folders = directory.split('/').toList();
      }
      final libIndex = folders.indexWhere((folder) => folder == 'lib');
      final modelPath = folders.sublist(libIndex + 1, folders.length).join('/');
      final pubSpecFile =
          File('${folders.sublist(0, libIndex).join('/')}/pubspec.yaml');
      final content = await pubSpecFile.readAsString();
      final yamlMap = loadYaml(content);
      final packageName = yamlMap['name'] as String;
      context.vars = {
        ...context.vars,
        'fullPath': '$packageName/$modelPath/'.replaceAll('//', '/'),
      };
    } on RangeError catch (_) {
      logger
        ..alert(
          red.wrap(
            'Could not find lib folder in $directory',
          ),
        )
        ..alert(
          red.wrap(
            'Re-run this brick inside your lib folder',
          ),
        );
      throw Exception();
    } on FileSystemException catch (_) {
      logger.alert(
        red.wrap(
          'Could not find pubspec.yaml folder in ${directory.replaceAll(r'\lib', '')}',
        ),
      );

      throw Exception();
    } on PubspecNameException catch (_) {
      logger
        ..alert(
          red.wrap(
            'Could not read package name in pubspec.yaml',
          ),
        )
        ..alert(
          red.wrap(
            'Does your pubspec have a name ?',
          ),
        );
      throw Exception();
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// Checks to see if the property type is special.
  ///
  /// This check is required due to the mustache syntax:
  /// All variables are HTML escaped by default. If you want
  /// to return unescaped HTML, use the triple mustache: {{{name}}}.
  ///
  /// returns a [Map<String, dynamic>] containing the properties variables
  static Map<String, dynamic> getCustomListProperties(
    bool hasSpecial,
    String propertyType,
  ) {
    if (!hasSpecial || !propertyType.contains('List')) {
      return {
        'isCustomList': false,
      };
    }
    final startIndex = propertyType.indexOf('<');
    final endIndex = propertyType.indexOf('>');
    final listType = propertyType.substring(startIndex + 1, endIndex).trim();
    if (DataTypes.values.contains(listType.cleaned)) {
      return {
        'isCustomList': false,
      };
    }
    return {
      'isCustomList': true,
      'customListType': listType,
    };
  }
}
