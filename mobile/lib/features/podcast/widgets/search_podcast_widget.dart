import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/post_index_search_service.dart';
import '../bloc/podcast_bloc.dart';

class SearchPodcastWidget extends StatefulWidget {
  const SearchPodcastWidget({super.key});

  @override
  SearchPodcastWidgetState createState() => SearchPodcastWidgetState();
}

class SearchPodcastWidgetState extends State<SearchPodcastWidget> {
  TextEditingController controller = TextEditingController();

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.horizontal(
      left: Radius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Search',
                border: border,
                errorBorder: border,
                disabledBorder: border,
                focusedBorder: border,
                focusedErrorBorder: border,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                  },
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
              ),
            ),
            child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () async {
                  final result = await searchPodcast(controller.text);
                  log('result $result');
                  context.read<PodcastBloc>().add(FetchPodcastEpisodes(id: result.toString()));
                }),
          )
        ],
      ),
    );
  }
}
