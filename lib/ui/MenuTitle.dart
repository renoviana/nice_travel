// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nice_travel/pages/AbsctractWidget.dart';

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
const _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A [menuTile] to display a [page].
class MenuTitle extends StatelessWidget {
  final WidgetPage page;
  final ValueChanged<WidgetPage> onTap;

  /// The [menuTile] shows the name and color of a [page] for unit
  /// conversions.
  ///
  /// Tapping on it brings you to the unit converter.
  const MenuTitle({
    Key key,
    @required this.page,
    this.onTap,
  })  : assert(page != null),
        super(key: key);

  /// Builds a custom widget that shows [page] information.
  ///
  /// This information includes the icon, name, and color for the [page].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Material(
      color:
          onTap == null ? Color.fromRGBO(50, 50, 50, 0.2) : Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: page.color['highlight'],
          splashColor: page.color['splash'],
          // We can use either the () => function() or the () { function(); }
          // syntax.
          onTap: onTap == null ? null : () => onTap(page),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // There are two ways to denote a list: `[]` and `List()`.
              // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
              // You can add the type argument if you'd like, i.e. <Widget>[].
              // See https://www.dartlang.org/guides/language/effective-dart/usage#do-use-collection-literals-when-possible
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Icon(page.iconLocation),
                ),
                Center(
                  child: Text(
                    page.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
