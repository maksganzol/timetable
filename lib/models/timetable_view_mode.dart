import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ViewMode {
  calendar,
  list,
}

extension ViewModeInverted on ViewMode {
  ViewMode get inverted {
    switch (this) {
      case ViewMode.list:
        return ViewMode.calendar;
      case ViewMode.calendar:
        return ViewMode.list;
    }
  }
}

extension ViewModeIcon on ViewMode {
  Icon get icon {
    switch (this) {
      case ViewMode.list:
        return const Icon(
          CupertinoIcons.list_bullet,
          color: CupertinoColors.systemBlue,
        );
      case ViewMode.calendar:
        return const Icon(
          CupertinoIcons.calendar_circle,
          color: CupertinoColors.systemBlue,
        );
    }
  }
}
