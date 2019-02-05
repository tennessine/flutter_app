import 'package:flutter/material.dart';

import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}
