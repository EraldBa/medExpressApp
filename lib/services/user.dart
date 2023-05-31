import 'package:flutter/material.dart';
import 'package:med_express/app/app.dart';
import 'package:med_express/app/enter/pages/enter_page.dart';
import 'package:pocketbase/pocketbase.dart';

class User {
  static final User _user = User._internal();

  final PocketBase _pb = PocketBase('${App.serverIP}:8090');

  List<String> _sitePreferences = [];
  List<String> _searchHistory = [];
  String _id = '';
  String _username = '';
  String _email = '';

  User._internal();

  static User get current => _user;
  bool get isLoggedIn => _pb.authStore.isValid;
  String get id => _id;
  String get username => _username;
  String get email => _email;
  List<String> get sitePreferences => _sitePreferences;
  List<String> get searchHistory => _searchHistory;

  set _userInfo(Map<String, dynamic> info) {
    _user._id = _pb.authStore.model.id.toString();

    _user._username = info['username'].toString();

    _user._email = info['email'].toString();

    _user._sitePreferences =
        List<String>.from(info['site_preferences']['sites']);

    _user._searchHistory =
        List<String>.from(info['search_history']['keywords']);
  }

  void _clearUserData() {
    _id = _username = _email = '';
    _sitePreferences.clear();
    _searchHistory.clear();
  }

  /// logIn logs in the user and potentially returns an error as bool
  static Future<bool> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final user = await _user._pb
          .collection('users')
          .authWithPassword(username.trim(), password.trim());
      _user._userInfo = user.record!.data;
    } catch (_) {
      return true;
    }

    return false;
  }

  /// signUp creates a user and potentially returns an error as bool
  static Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    const defaultSites = {
      'sites': [
        'wiki',
        'pubmed',
        'nhs',
      ]
    };

    const defaultSearchHistory = {
      'keywords': [],
    };

    try {
      await _user._pb.collection('users').create(body: {
        'username': username.trim(),
        'email': email.trim(),
        'password': password.trim(),
        'passwordConfirm': password,
        'site_preferences': defaultSites,
        'search_history': defaultSearchHistory,
      });
    } catch (_) {
      return true;
    }

    return false;
  }

  /// Updates given user data
  /// throws [Exception]
  Future<void> updateUser({
    String? username,
    String? email,
    String? password,
    String? keyword,
    Set<String>? sitePreferences,
  }) async {
    final body = <String, dynamic>{};

    if (username != null) {
      body['username'] = username;
    }
    if (email != null) {
      body['email'] = email;
    }

    if (password != null) {
      body.addAll({'password': password, 'passwordConfirm': password});
    }

    if (sitePreferences != null) {
      body['site_preferences'] = {
        'sites': sitePreferences,
      };
    }

    if (keyword != null) {
      _searchHistory.insert(0, keyword);

      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }

      body['search_history'] = {
        'keywords': _searchHistory,
      };
    }

    if (body.isEmpty) {
      return;
    }

    final user = await _pb.collection('users').update(id, body: body);

    _userInfo = user.data;
  }

  void logOut(BuildContext context) {
    _pb.authStore.clear();
    _clearUserData();
    Navigator.popAndPushNamed(context, EnterPage.route);
  }

  Future<void> deleteUser(BuildContext context) async {
    _pb.collection('users').delete(id);
    logOut(context);
  }

  Future<void> clearHistory() async {
    _searchHistory = [];
    await updateUser(keyword: '');
  }
}
