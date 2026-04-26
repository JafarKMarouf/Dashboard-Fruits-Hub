// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "dashboardTitle": MessageLookupByLibrary.simpleMessage("FruitHub Admin"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "genericError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again later.",
    ),
    "invalidCredential": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Invalid email address.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Sign In"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Signed in successfully",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage(
      "Admin Dashboard - Please sign in to continue",
    ),
    "networkRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Network connection failed. Please check your internet connection.",
    ),
    "notAuthorized": MessageLookupByLibrary.simpleMessage(
      "Not authorized to access",
    ),
    "orderListTitle": MessageLookupByLibrary.simpleMessage("Orders"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "requiredField": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
  };
}
