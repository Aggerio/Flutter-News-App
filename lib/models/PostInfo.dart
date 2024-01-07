import 'package:flutter/foundation.dart';

class PostInfo with ChangeNotifier, DiagnosticableTreeMixin {
  bool _bookmarked = false;

  bool get bookmarker => _bookmarked;

  void _bookmarkpost() {
    _bookmarked = true;
    notifyListeners();
  }

  void _unbookmarkpost() {
    _bookmarked = false;
    notifyListeners();
  }
}
