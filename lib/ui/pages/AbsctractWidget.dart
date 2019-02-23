// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// A [WidgetPage] keeps track of page.
class WidgetPage {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final Widget frontPanel;

  const WidgetPage({
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.frontPanel,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        assert(frontPanel != null);
}
