import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

abstract class TextfieldTagsNotifier<T> extends ChangeNotifier {
  late ObjIder<ScrollController>? _scrollController;
  late ObjIder<FocusNode>? _focusNode;
  late ObjIder<TextEditingController>? _textEditingController;

  late LetterCase? _letterCase;
  late Set<String>? _textSeparators;
  late List<T>? _tags;
  late Validator<T>? _validator;

  TextfieldTagsNotifier({
    List<T>? initialTags,
    Set<String>? textSeparators,
    LetterCase? letterCase,
    Validator<T>? validator,
    ObjIder<FocusNode>? focusNode,
    ObjIder<TextEditingController>? textEditingController,
    ObjIder<ScrollController>? scrollController,
  }) {
    _tags = initialTags;
    _textSeparators = textSeparators;
    _letterCase = letterCase;
    _validator = validator;

    _scrollController = scrollController;
    _textEditingController = textEditingController;
    _focusNode = focusNode;
  }

  bool? addTag(T tag) {
    if (_tags != null) {
      _tags!.add(tag);
      return true;
    }
    return null;
  }

  bool? removeTag(T tag) {
    if (_tags != null) {
      bool removed = _tags!.remove(tag);
      return removed;
    }
    return null;
  }

  bool? clearTags() {
    if (_tags != null) {
      _tags!.clear();
      return true;
    }
    return null;
  }

  bool? onTagChanged(T tag);
  bool? onTagSubmitted(T tag);
  bool? onTagRemoved(T tag);

  @override
  void dispose() {
    super.dispose();
    if (_textEditingController != null &&
        _textEditingController!.origin == true) {
      _textEditingController!.object.dispose();
    }
    if (_focusNode != null && _focusNode!.origin == true) {
      _focusNode!.object.dispose();
    }
    if (_scrollController != null && _scrollController!.origin == true) {
      _scrollController!.object.dispose();
    }
  }
}

abstract class TextfieldTagsController<T> extends TextfieldTagsNotifier<T> {
  late int _tagScrollAnimationSpeedInMs;
  late String? _error;

  TextfieldTagsController()
      : _tagScrollAnimationSpeedInMs = 300,
        _error = null,
        super();

  List<T>? get getTags => _tags?.toList();
  String? get getError => _error;
  int get getTagScrollAnimationSpeedInMs => _tagScrollAnimationSpeedInMs;
  LetterCase? get getLetterCase => _letterCase;
  Set<String>? get getTextSeparators => _textSeparators;
  Validator<T>? get getValidator => _validator;
  ScrollController? get getScrollController => _scrollController?.object;
  FocusNode? get getFocusNode => _focusNode?.object;
  TextEditingController? get getTextEditingController =>
      _textEditingController?.object;

  set setTagScrollAnimationSpeedInMs(int tsas) {
    _tagScrollAnimationSpeedInMs = tsas;
  }

  set setError(String? error) {
    _error = error;
  }

  void scrollTags() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController != null && _scrollController!.object.hasClients) {
        _scrollController!.object.animateTo(
          _scrollController!.object.position.maxScrollExtent,
          duration: Duration(milliseconds: _tagScrollAnimationSpeedInMs),
          curve: Curves.linear,
        );
      }
    });
  }

  void registerController(
    List<T>? initialTags,
    List<String>? textSeparators,
    LetterCase? letterCase,
    Validator<T>? validator,
    FocusNode? focusNode,
    TextEditingController? textEditingController,
    ScrollController? scrollController,
  ) {
    assert(
      (_tags == null &&
          _textSeparators == null &&
          _letterCase == null &&
          _validator == null),
      'You\'ve already registered a tag controller',
    );
    _tags = initialTags != null ? initialTags.toList() : [];
    _textSeparators = textSeparators != null ? textSeparators.toSet() : {};
    _letterCase = letterCase ?? LetterCase.normal;
    _validator = validator;
    _focusNode = focusNode != null
        ? ObjIder<FocusNode>(focusNode, false)
        : ObjIder<FocusNode>(FocusNode(), true);
    _textEditingController = textEditingController != null
        ? ObjIder<TextEditingController>(textEditingController, false)
        : ObjIder<TextEditingController>(TextEditingController(), true);
    _scrollController = scrollController != null
        ? ObjIder<ScrollController>(scrollController, false)
        : ObjIder<ScrollController>(ScrollController(), true);
  }

  @override
  bool? clearTags() {
    bool? clear = super.clearTags();
    if (clear == true) {
      _error = null;
      _textEditingController?.object.clear();
      _focusNode?.object.requestFocus();
      notifyListeners();
    }
    return clear;
  }

  @override
  bool? onTagChanged(T tag) => null;

  @override
  bool? onTagSubmitted(T tag) {
    bool? add = super.addTag(tag);
    if (add == true) {
      _error = null;
      _textEditingController?.object.clear();
      notifyListeners();
    }
    return add;
  }

  @override
  bool? onTagRemoved(T tag) {
    bool? remove = super.removeTag(tag);
    if (remove == true) {
      _error = null;
      notifyListeners();
    }
    return remove;
  }
}
