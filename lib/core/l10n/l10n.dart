// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Admin Dashboard - Please sign in to continue`
  String get loginTitle {
    return Intl.message(
      'Admin Dashboard - Please sign in to continue',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get login {
    return Intl.message('Sign In', name: 'login', desc: '', args: []);
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get genericError {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Network connection failed. Please check your internet connection.`
  String get networkRequestFailed {
    return Intl.message(
      'Network connection failed. Please check your internet connection.',
      name: 'networkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address.`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get invalidCredential {
    return Intl.message(
      'Incorrect email or password.',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `Not authorized to access`
  String get notAuthorized {
    return Intl.message(
      'Not authorized to access',
      name: 'notAuthorized',
      desc: '',
      args: [],
    );
  }

  /// `Signed in successfully`
  String get loginSuccess {
    return Intl.message(
      'Signed in successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `FruitHub Admin`
  String get dashboardTitle {
    return Intl.message(
      'FruitHub Admin',
      name: 'dashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orderListTitle {
    return Intl.message('Orders', name: 'orderListTitle', desc: '', args: []);
  }

  /// `moments ago`
  String get timeAgoMoments {
    return Intl.message(
      'moments ago',
      name: 'timeAgoMoments',
      desc: '',
      args: [],
    );
  }

  /// `1 minute ago`
  String get timeAgoMinuteOne {
    return Intl.message(
      '1 minute ago',
      name: 'timeAgoMinuteOne',
      desc: '',
      args: [],
    );
  }

  /// `2 minutes ago`
  String get timeAgoMinuteTwo {
    return Intl.message(
      '2 minutes ago',
      name: 'timeAgoMinuteTwo',
      desc: '',
      args: [],
    );
  }

  /// `minutes ago`
  String get timeAgoMinutePlural {
    return Intl.message(
      'minutes ago',
      name: 'timeAgoMinutePlural',
      desc: '',
      args: [],
    );
  }

  /// `1 hour ago`
  String get timeAgoHourOne {
    return Intl.message(
      '1 hour ago',
      name: 'timeAgoHourOne',
      desc: '',
      args: [],
    );
  }

  /// `2 hours ago`
  String get timeAgoHourTwo {
    return Intl.message(
      '2 hours ago',
      name: 'timeAgoHourTwo',
      desc: '',
      args: [],
    );
  }

  /// `hours ago`
  String get timeAgoHourPlural {
    return Intl.message(
      'hours ago',
      name: 'timeAgoHourPlural',
      desc: '',
      args: [],
    );
  }

  /// `1 day ago`
  String get timeAgoDayOne {
    return Intl.message('1 day ago', name: 'timeAgoDayOne', desc: '', args: []);
  }

  /// `2 days ago`
  String get timeAgoDayTwo {
    return Intl.message(
      '2 days ago',
      name: 'timeAgoDayTwo',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get timeAgoDayPlural {
    return Intl.message(
      'days ago',
      name: 'timeAgoDayPlural',
      desc: '',
      args: [],
    );
  }

  /// `1 month ago`
  String get timeAgoMonthOne {
    return Intl.message(
      '1 month ago',
      name: 'timeAgoMonthOne',
      desc: '',
      args: [],
    );
  }

  /// `2 months ago`
  String get timeAgoMonthTwo {
    return Intl.message(
      '2 months ago',
      name: 'timeAgoMonthTwo',
      desc: '',
      args: [],
    );
  }

  /// `months ago`
  String get timeAgoMonthPlural {
    return Intl.message(
      'months ago',
      name: 'timeAgoMonthPlural',
      desc: '',
      args: [],
    );
  }

  /// `1 year ago`
  String get timeAgoYearOne {
    return Intl.message(
      '1 year ago',
      name: 'timeAgoYearOne',
      desc: '',
      args: [],
    );
  }

  /// `2 years ago`
  String get timeAgoYearTwo {
    return Intl.message(
      '2 years ago',
      name: 'timeAgoYearTwo',
      desc: '',
      args: [],
    );
  }

  /// `years ago`
  String get timeAgoYearPlural {
    return Intl.message(
      'years ago',
      name: 'timeAgoYearPlural',
      desc: '',
      args: [],
    );
  }

  /// `cancelled since`
  String get statusCancelled {
    return Intl.message(
      'cancelled since',
      name: 'statusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `delivered since`
  String get statusDelivered {
    return Intl.message(
      'delivered since',
      name: 'statusDelivered',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
