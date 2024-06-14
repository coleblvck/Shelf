import 'package:flutter/material.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';

FloatingActionButton fab(context, {String object="visualizer"}) => FloatingActionButton(
  onPressed: actionButtonActions(context)[object]!["function"],
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  tooltip: 'Music',
  backgroundColor: ShelfTheme.of(context).colors.primary,
  child: actionButtonActions(context)[object]!["widget"],
);
