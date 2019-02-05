import '../models/item_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    newsApiProvider,
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source && item != null) {
        cache.addItem(item);
      }
    }

    return item;
  }

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<ItemModel> fetchItem(int id);

  Future<List<int>> fetchTopIds();
}

abstract class Cache {
  Future<int> addItem(ItemModel item);

  Future<int> clear();
}
