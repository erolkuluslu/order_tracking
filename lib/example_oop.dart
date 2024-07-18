import 'package:flutter/cupertino.dart';

void main(List<String> arguments) {
  UserBase user;

  user = Admin(firstName: 'Jack', lastName: 'Smith', email: 'admin@domain.com', specialAdminField: 1.0);
  user.signOut(); // Prints "Sign out from admin panel"

  user = RegularUser(firstName: 'Jane', lastName: 'Doe', email: 'jane@domain.com');
  user.signOut(); // Prints "Sign out. Jane"

  // Creating an instance of the Admin class with sample data
  final admin = Admin(firstName: 'Erol', lastName: 'Kuluslu', email: 'admin@domain.com', specialAdminField: 1.0);
  // Admin can use the signOut method (inherited from UserBase class)
  admin.signOut(); // Prints "Sign out from admin panel"

  // Calling the getFullName method (inherited from UserBase class)
  print(admin.getFullName());  // Prints "Erol Kuluslu"

  // Accessing the fullName property (inherited from UserBase class)
  print(admin.fullName);  // Prints "Erol Kuluslu"

  // Admin can access email as a property (inherited from UserBase class)
  print(admin.email);  // Prints "admin@domain.com"

}

// Abstract class UserBase
/*
An abstract class in Dart can have method implementations and can contain fields.
Abstract classes are used when you want to provide a common base class for other classes to extend.
An abstract class can have constructors.
You cannot create an instance of an abstract class.
 */
abstract class UserBase {
  final String _firstName;
  final String _lastName;
  String? _email;

  UserBase({
    required String firstName,
    required String lastName,
    required String email,
  })  : _firstName = firstName,
        _lastName = lastName {
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

// Notifiable interface
/*
Dart does not have a special syntax for interfaces. Instead, all classes implicitly define an interface.
Any class can be used as an interface by implementing it.
Interfaces in Dart are used to define a contract that implementing classes must follow. They only contain method signatures and no implementations.
A class can implement multiple interfaces, allowing for more flexible design.
 */
class Notifiable {
  void notify(String message) {
    // TODO: implement notify
  }
}

// Admin class that extends UserBase and implements Notifiable
class Admin extends UserBase implements Notifiable {
  final double specialAdminField;

  Admin({
    required String firstName,
    required String lastName,
    required String email,
    required this.specialAdminField,
  }) : super(firstName: firstName, lastName: lastName, email: email);

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
/*
Why Use Inheritance in This Example?
Code Reusability:
By creating an Admin class that inherits from the User class, we avoid duplicating code.
The Admin class automatically gains all the properties and methods of the User class.
Logical Organization:
Inheritance helps in organizing the code logically. Admin is a specialized type of User, so it makes sense to define Admin as a subclass of User.
This hierarchical relationship reflects the real-world relationship between the concepts, making the code easier to understand and maintain.
Extension of Functionality:
The Admin class can add its own properties and methods in addition to those inherited from the User class.
For example, we might want to add additional administrative methods or properties that are specific to Admin users,
while still retaining all the functionality of a regular User.
Maintainability:
Changes to the common properties and methods can be made in the User class and automatically pass to the Admin class.
 */
class RegularUser extends UserBase {
  RegularUser({
    required String firstName,
    required String lastName,
    required String email,
  }) : super(firstName: firstName, lastName: lastName, email: email);

  @override
  void signOut() {
    super.signOut();
  }
}

// ChatBot class that also uses ElevatedClient mixin
class ChatBot with ElevatedClient implements Notifiable {
  final String id;

  ChatBot(this.id);

  @override
  void notify(String message) {
    print("ChatBot notified: $message");
  }
}

// Mixin to provide common functionality
mixin ElevatedClient {
  void sendElevatedMessage(String txt) {
    print('Sending an elevated message: $txt');
  }
}

// Abstract class defining a generic DataReader
abstract class DataReader<T> {
  T readData();
}

// Implementation of DataReader that returns an integer
class IntegerDataReader implements DataReader<int> {
  @override
  int readData() {
    return 1234;
  }
}

// Implementation of DataReader that returns a string
class StringDataReader implements DataReader<String> {
  @override
  String readData() {
    return "String Data Reader is performing";
  }
}

// Extension on BuildContext to provide responsive size methods
extension SizeExtension on BuildContext {
  // Method to get responsive width based on percentage of screen width
  double responsiveWidth(double percentage) {
    final screenWidth = MediaQuery.of(this).size.width;
    return screenWidth * percentage;
  }

  // Method to get responsive height based on percentage of screen height
  double responsiveHeight(double percentage) {
    final screenHeight = MediaQuery.of(this).size.height;
    return screenHeight * percentage;
  }
}
/*
Abstract Class (UserBase):

UserBase is an abstract class that provides common behavior and properties for all user types.
It can have concrete method implementations and fields.
Both Admin and RegularUser classes extend UserBase, inheriting its properties and methods.
Interface (Notifiable):

Notifiable is a class used as an interface to define a contract with the method notify.
Both Admin and ChatBot classes implement Notifiable, meaning they must provide an implementation of the notify method.
Polymorphism:

The UserBase reference in main can point to either Admin or RegularUser objects, demonstrating polymorphism.
The notify method is polymorphic as well, as different classes (Admin and ChatBot) implement it in their own way.
 */