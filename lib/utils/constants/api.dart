// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  static final db = FirebaseFirestore.instance;
  static final users = db.collection('users');

  static const apiUrl = 'https://instagram-clone.devyzer.com/api';
  static const apikey = 'p@ssword123';

//auth
  x() {}
  static const SIGN_IN_URL = '/auth/user/login';
  static const SIGN_UP_URL = '/auth/user/register';
  static const MY_INFO = '/auth/user/info';
  static const LOGOUT_URL = '/auth/user/logout';
  static const FORGET_PASSWORD_URL = '/auth/user/password/code/send';
  static const CHECK_EMAIL_CODE_URL = '/auth/user/password/code/check';
  static const RESET_PASSWORD_URL = '/auth/user/password/reset';

//user
  static const USER_URL = '/user';

//post
  static const POST_URL = '/post';
  static const MARK_POST_AS_FAVORITE_URL = '/post/like';

  //saved
  static const SAVED_POSTS_URL = '/post/save';

//SAVE POST
  static const SAVE_POST_URL = '/post/save';

//comments
  static const COMMNETS_URL = '/comment';

//search
  static const SEARCH_URL = '/user/search';
  static const SEARCH_HISTORY_URL = '/search/history/';

//story
  static const STORY_URL = '/story';
  static const SET_STORY_AS_WATHCED_URL = '/story/view';

//profile
  static const PROFILE_PATH = '/profile';
  static const PROFILE_POSTS_URL = '/profile/posts';

//follow
  static const FOLLOWERS_PATH = '/followers';
  static const SEARCH_FOLLOWERS_PATH = '/followers/search';
  static const FOLLOWEING_PATH = '/following';
  static const SEARCH_FOLLOWEING_PATH = '/following/search';
  static const FOLLOW_USER_PATH = '/follow';

//search
  static const SEARCH_PATH = '/user/search';
}
