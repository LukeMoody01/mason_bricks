// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

abstract class DartTypesUtils {
  static bool isIterableOrSubclass(DartType? type) =>
      _checkSelfOrSupertypes(type, (t) => t?.isDartCoreIterable ?? false);

  static bool isListOrSubclass(DartType? type) =>
      _checkSelfOrSupertypes(type, (t) => t?.isDartCoreList ?? false);

  static bool isMapOrSubclass(DartType? type) =>
      _checkSelfOrSupertypes(type, (t) => t?.isDartCoreMap ?? false);

  static bool isNullableType(DartType? type) =>
      type?.nullabilitySuffix == NullabilitySuffix.question;

  static DartType? getSupertypeIterable(DartType? type) =>
      _getSelfOrSupertypes(type, (t) => t?.isDartCoreIterable ?? false);

  static DartType? getSupertypeList(DartType? type) =>
      _getSelfOrSupertypes(type, (t) => t?.isDartCoreList ?? false);

  static DartType? getSupertypeSet(DartType? type) =>
      _getSelfOrSupertypes(type, (t) => t?.isDartCoreSet ?? false);

  static DartType? getSupertypeMap(DartType? type) =>
      _getSelfOrSupertypes(type, (t) => t?.isDartCoreMap ?? false);

  static bool _checkSelfOrSupertypes(
    DartType? type,
    bool Function(DartType?) predicate,
  ) =>
      predicate(type) ||
      (type is InterfaceType && type.allSupertypes.any(predicate));

  static DartType? _getSelfOrSupertypes(
    DartType? type,
    bool Function(DartType?) predicate,
  ) {
    if (predicate(type)) {
      return type;
    }
    if (type is InterfaceType) {
      return type.allSupertypes.firstWhereOrNull(predicate);
    }

    return null;
  }
}
