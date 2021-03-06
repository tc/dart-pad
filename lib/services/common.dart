// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dart_pad.common;

// The endpoint running dart-services.
const serverUrl = 'https://v1.api.dartpad.dev/';

// Used when null safety is enabled in the UI.
const nullSafetyServerUrl = 'https://nullsafety.api.dartpad.dev/';

// A URL to use while debugging.
// final serverUrl = 'http://127.0.0.1:8082/';
// const nullSafetyServerUrl = 'http://127.0.0.1:8082/';

const Duration serviceCallTimeout = Duration(seconds: 10);
const Duration longServiceCallTimeout = Duration(seconds: 60);

class StringTextProvider {
  final String _text;

  StringTextProvider(this._text);

  String getText() => _text;
}

class Lines {
  final _starts = <int>[];

  Lines(String source) {
    var units = source.codeUnits;
    var nextIsEol = true;
    for (var i = 0; i < units.length; i++) {
      if (nextIsEol) {
        nextIsEol = false;
        _starts.add(i);
      }
      if (units[i] == 10) nextIsEol = true;
    }
  }

  /// Return the 0-based line number.
  int getLineForOffset(int offset) {
    if (_starts.isEmpty) return 0;
    for (var i = 1; i < _starts.length; i++) {
      if (offset < _starts[i]) return i - 1;
    }
    return _starts.length - 1;
  }

  int offsetForLine(int line) {
    assert(line >= 0);
    if (_starts.isEmpty) return 0;
    if (line >= _starts.length) line = _starts.length - 1;
    return _starts[line];
  }
}
