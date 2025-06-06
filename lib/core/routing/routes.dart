abstract class Routes {
  static const String test = '/';

  //인증 관련 경로
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  // 메인 탭 경로
  static const String home = '/home';
  static const String savedRecipes = '/saved-recipes';
  static const String notifications = '/notifications';
  static const String profile = '/profile';

  static const String search = '/search';

  // 파라미터가 필요한 경로
  static const String ingredient = '/ingredient/:recipeId';
}
