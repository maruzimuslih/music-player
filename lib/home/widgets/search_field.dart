import 'package:flutter/material.dart';
import 'package:music_player/home/bloc.dart';
import 'package:music_player/service_locator.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final _searchBloc = serviceLocator<SearchBloc>();
  final _searchQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchQuery,
        onSubmitted: (string) async {
          _searchBloc.clearSearchResultsStream();
          await _searchBloc.getSongs(query: _searchQuery.text);
        },
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          fillColor: const Color(0xFFE4E4E4),
          filled: true,
          contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(80.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(80.0)),
          hintText: 'Search songs',
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          suffixIcon: GestureDetector(
            onTap: () async {
              _searchBloc.clearSearchResultsStream();
              await _searchBloc.getSongs(query: _searchQuery.text);
            },
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
