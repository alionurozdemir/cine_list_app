import 'package:cine_list_app/models/movie.dart';
import 'package:cine_list_app/viewmodels/movie_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({super.key});

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  static const _pageSize = 20;

  var viewModel = MovieListViewModel();
  final PagingController<int, Results> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await viewModel.fetchMovie(pageKey: pageKey);
      print(newItems.length);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1; // Sayfa numarasını doğrudan artır
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: Column(
          children: [
            Observer(
              builder: (_) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                      child: PagedListView<int, Results>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Results>(
                      itemBuilder: (context, item, index) => ListTile(
                        leading: Image.network("https://image.tmdb.org/t/p/w500${item.posterPath}"),
                        title: Text(item.title!),
                        subtitle: Text(item.overview!),
                      ),
                    ),
                  ));
                }
              },
            ),
          ],
        ));
  }
}
