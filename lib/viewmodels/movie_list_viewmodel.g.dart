// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieListViewModel on _MovieListViewModelBase, Store {
  late final _$resultsAtom =
      Atom(name: '_MovieListViewModelBase.results', context: context);

  @override
  List<Results>? get results {
    _$resultsAtom.reportRead();
    return super.results;
  }

  @override
  set results(List<Results>? value) {
    _$resultsAtom.reportWrite(value, super.results, () {
      super.results = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MovieListViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchMovieAsyncAction =
      AsyncAction('_MovieListViewModelBase.fetchMovie', context: context);

  @override
  Future<dynamic> fetchMovie({required int pageKey}) {
    return _$fetchMovieAsyncAction
        .run(() => super.fetchMovie(pageKey: pageKey));
  }

  @override
  String toString() {
    return '''
results: ${results},
isLoading: ${isLoading}
    ''';
  }
}
