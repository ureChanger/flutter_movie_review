import 'dart:convert' as json;
import 'package:flutter/services.dart';
import 'package:movie_review/model/response/comments_response.dart';
import 'package:movie_review/model/response/movie_response.dart';
import 'package:movie_review/model/response/movies_response.dart';

@Deprecated("Asynchronous communication will use Server Communication Chapter")
Future<String> loadJsonStr(String assetPath) async {
  final jsonCrossword = await rootBundle.loadString(assetPath);
  return jsonCrossword;
}

@Deprecated("Asynchronous communication will use Server Communication Chapter")
Future<MoviesResponse> loadMoviesData(String assetPath) async {
  final jsonString = await loadJsonStr(assetPath);
  final Map userMap = json.jsonDecode(jsonString);
  final data = MoviesResponse.fromJson(userMap as Map<String, dynamic>);
  return data;
}

@Deprecated("Asynchronous communication will use Server Communication Chapter")
Future<MovieResponse> loadMovieData(String assetPath) async {
  final jsonString = await loadJsonStr(assetPath);
  final Map userMap = json.jsonDecode(jsonString);
  final data = MovieResponse.fromJson(userMap as Map<String, dynamic>);
  return data;
}

@Deprecated("Asynchronous communication will use Server Communication Chapter")
Future<CommentsResponse> loadCommentsData(String assetPath) async {
  final jsonString = await loadJsonStr(assetPath);
  final Map userMap = json.jsonDecode(jsonString);
  final data = CommentsResponse.fromJson(userMap as Map<String, dynamic>);
  return data;
}
