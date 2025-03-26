import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:objectbox_dart_sandbox/not_found.dart';
import 'package:objectbox_dart_sandbox/screens/testing.dart';
import 'package:objectbox_dart_sandbox/screens/user_details.dart';
import 'package:objectbox_dart_sandbox/widgets/layout_wrapper.dart';

class RoutesConsts {
  static const root = '/';
  static const testing = '/testing';
  static const userDetails = '/userDetails';
}

Route<dynamic> generateRoute({required RouteSettings settings}) => switch (settings.name) {
  RoutesConsts.testing => GetPageRoute(
    settings: const RouteSettings(name: RoutesConsts.testing),
    page: () => LayoutWrapper(childWidget: Testing()),
  ),
  RoutesConsts.userDetails => GetPageRoute(
    settings: const RouteSettings(name: RoutesConsts.userDetails),
    page: () => LayoutWrapper(childWidget: UserDetails(userId: settings.arguments as int)),
  ),
  _ => GetPageRoute(settings: const RouteSettings(name: RoutesConsts.root), page: () => const NotFound()),
};
