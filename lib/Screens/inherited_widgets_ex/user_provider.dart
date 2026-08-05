import 'package:flutter/material.dart';

class UserProvider extends InheritedWidget {
  final String userName;
  final String email;

  //   const UserProvider({
  //     super.key,
  //     required this.userName,
  //     required this.email,
  //     required Widget child,
  //   }) : super(child: child);
  // }

  const UserProvider({
    super.key,
    required this.userName,
    required this.email,
    required super.child,
  });

  static UserProvider of(BuildContext context) {
    final UserProvider? result = context
        .dependOnInheritedWidgetOfExactType<UserProvider>();

    assert(result != null, "No UserProvider found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return userName != oldWidget.userName || email != oldWidget.email;
  }
}