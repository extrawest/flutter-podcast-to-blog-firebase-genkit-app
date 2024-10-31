import 'package:flutter/material.dart';

import '../widgets/podcast_episoddes_list.dart';
// final result = await searchPodcast('EdTech Shorts');

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast Screen'),
      ),
      body: const PodcastEpisoddesList(),
    );
  }
}
