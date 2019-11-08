import '../pages/GalleryPage.dart';
import '../pages/HomePage.dart';
import '../pages/SearchPage.dart';
import '../pages/InfoPage.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomePage>(() => HomePage());
    register<GalleryPage>(() => GalleryPage());
    register<SearchPage>(() => SearchPage());
    register<InfoPage>(() => InfoPage());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
