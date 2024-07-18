import 'package:meta/meta.dart';

import 'model.dart';

abstract class UserBase {
  final String _firstName;
  final String _lastName;
  String? _email;
  final List<OrderStatus> _permissions;

  UserBase({
    required List<OrderStatus> permissions,
    required String firstName,
    required String lastName,
    required String email,
  })  : _firstName = firstName,
        _lastName = lastName,
        _permissions = permissions {
    this.email = email;
  }

  set email(String value) {
    if (value.contains('@')) {
      _email = value;
    } else {
      _email = null;
    }
  }

  String get email => _email ?? 'default@gmail.com';

  String getFullName() => '$_firstName $_lastName';

  String get fullName => '$_firstName $_lastName';

  @mustCallSuper
  void signOut() {
    print("Sign out. $_firstName");
  }

}

// Admin class that extends UserBase
class Admin extends UserBase {
  final double specialAdminField;

  Admin({
    required String firstName,
    required String lastName,
    required String email,
    required this.specialAdminField,
    required List<OrderStatus> permissions,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    email: email,
    permissions: permissions,
  );

  @override
  void signOut() {
    print("Sign out from admin panel");
    super.signOut();
  }

  @override
  void notify(String message) {
    print("Admin notified: $message");
  }
}

// RegularUser class that extends UserBase
class Courier extends UserBase {
  Courier({
    required String firstName,
    required String lastName,
    required String email,
    required List<OrderStatus> permissions,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    email: email,
    permissions: permissions,
  );



}

// Chef class that extends UserBase
class Chef extends UserBase {
  Chef({
    required String firstName,
    required String lastName,
    required String email,
    required List<OrderStatus> permissions,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    email: email,
    permissions: permissions,
  );


}

