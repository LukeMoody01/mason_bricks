// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

abstract class FlutterTypesUtils {
  static bool hasWidgetType(DartType type) =>
      (isWidgetOrSubclass(type) ||
          _isIterable(type) ||
          _isList(type) ||
          _isFuture(type)) &&
      !(_isMultiProvider(type) ||
          _isSubclassOfInheritedProvider(type) ||
          _isIterableInheritedProvider(type) ||
          _isListInheritedProvider(type) ||
          _isFutureInheritedProvider(type));

  static bool isWidgetOrSubclass(DartType? type) =>
      _isWidget(type) || _isSubclassOfWidget(type);

  static bool isRenderObjectOrSubclass(DartType? type) =>
      _isRenderObject(type) || _isSubclassOfRenderObject(type);

  static bool isRenderObjectWidgetOrSubclass(DartType? type) =>
      _isRenderObjectWidget(type) || _isSubclassOfRenderObjectWidget(type);

  static bool isRenderObjectElementOrSubclass(DartType? type) =>
      _isRenderObjectElement(type) || _isSubclassOfRenderObjectElement(type);

  static bool isWidgetStateOrSubclass(DartType? type) =>
      _isWidgetState(type) || _isSubclassOfWidgetState(type);

  static bool isSubclassOfListenable(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isListenable);

  static bool isListViewWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'ListView';

  static bool isSingleChildScrollViewWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'SingleChildScrollView';

  static bool isColumnWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'Column';

  static bool isRowWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'Row';

  static bool isPaddingWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'Padding';

  static bool isBuildContext(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'BuildContext';

  static bool isGameWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'GameWidget';

  static bool _isWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'Widget';

  static bool _isSubclassOfWidget(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isWidget);

// ignore: deprecated_member_use
  static bool _isWidgetState(DartType? type) =>
      type?.element?.displayName == 'State';

  static bool _isSubclassOfWidgetState(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isWidgetState);

  static bool _isIterable(DartType type) =>
      type.isDartCoreIterable &&
      type is InterfaceType &&
      isWidgetOrSubclass(type.typeArguments.firstOrNull);

  static bool _isList(DartType type) =>
      type.isDartCoreList &&
      type is InterfaceType &&
      isWidgetOrSubclass(type.typeArguments.firstOrNull);

  static bool _isFuture(DartType type) =>
      type.isDartAsyncFuture &&
      type is InterfaceType &&
      isWidgetOrSubclass(type.typeArguments.firstOrNull);

  static bool _isListenable(DartType type) =>
      type.getDisplayString(withNullability: false) == 'Listenable';

  static bool _isRenderObject(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'RenderObject';

  static bool _isSubclassOfRenderObject(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isRenderObject);

  static bool _isRenderObjectWidget(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'RenderObjectWidget';

  static bool _isSubclassOfRenderObjectWidget(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isRenderObjectWidget);

  static bool _isRenderObjectElement(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'RenderObjectElement';

  static bool _isSubclassOfRenderObjectElement(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isRenderObjectElement);

  static bool _isMultiProvider(DartType? type) =>
      type?.getDisplayString(withNullability: false) == 'MultiProvider';

  static bool _isSubclassOfInheritedProvider(DartType? type) =>
      type is InterfaceType && type.allSupertypes.any(_isInheritedProvider);

  static bool _isInheritedProvider(DartType? type) =>
      type != null &&
      type
          .getDisplayString(withNullability: false)
          .startsWith('InheritedProvider<');

  static bool _isIterableInheritedProvider(DartType type) =>
      type.isDartCoreIterable &&
      type is InterfaceType &&
      _isSubclassOfInheritedProvider(type.typeArguments.firstOrNull);

  static bool _isListInheritedProvider(DartType type) =>
      type.isDartCoreList &&
      type is InterfaceType &&
      _isSubclassOfInheritedProvider(type.typeArguments.firstOrNull);

  static bool _isFutureInheritedProvider(DartType type) =>
      type.isDartAsyncFuture &&
      type is InterfaceType &&
      _isSubclassOfInheritedProvider(type.typeArguments.firstOrNull);
}
