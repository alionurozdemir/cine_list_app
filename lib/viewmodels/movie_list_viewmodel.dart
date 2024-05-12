import 'dart:developer';

import 'package:cine_list_app/models/movie.dart';
import 'package:cine_list_app/services/network_service.dart';
import 'package:cine_list_app/services/request_model.dart';
import 'package:cine_list_app/services/request_response_model.dart';
import 'package:mobx/mobx.dart';

part 'movie_list_viewmodel.g.dart';

class MovieListViewModel = _MovieListViewModelBase with _$MovieListViewModel;

abstract class _MovieListViewModelBase with Store {
  init() async {}

  @observable
  List<Results>? results = [];

  @observable
  bool isLoading = false;

  @action
  Future fetchMovie({required int pageKey}) async {
    isLoading = true;
    try {
      var response = await NetworkService().send<MovieResponseModel, MovieResponseModel>(
          RequestModel<MovieResponseModel>(
              endPoint: "3/movie/popular",
              type: RequestTypes.GET,
              queryParameters: {"page": pageKey},
              parseModel: MovieResponseModel()));

      if (response.status == ResponseEnum.success) {
        results = response.data!.results;

        return response.data?.results;
      } else {
        log(response.error.toString());
      }
    } catch (e) {
      log('Error fetching movies: $e');
    } finally {
      isLoading = false;
    }
  }
}
