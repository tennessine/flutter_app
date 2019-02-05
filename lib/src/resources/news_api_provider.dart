import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/item_model.dart';
import 'repository.dart';

class NewsApiProvider implements Source {
  Dio dio = Dio();

  NewsApiProvider() {
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.responseType = ResponseType.PLAIN;
    dio.onHttpClientCreate = (HttpClient client) {
      // config the http client
      client.findProxy = (uri) {
        return "PROXY 192.168.1.100:1087";
      };
    };
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await dio.get(
      'https://hacker-news.firebaseio.com/v0/item/$id.json',
    );
    final parsedJson = json.decode(response.data.toString());
    return ItemModel.fromJson(parsedJson);
  }

  Future<List<int>> fetchTopIds() async {
    final response =
        await dio.get('https://hacker-news.firebaseio.com/v0/topstories.json');
    final ids = json.decode(response.data.toString());
    return ids.cast<int>();
  }
}

final newsApiProvider = NewsApiProvider();
