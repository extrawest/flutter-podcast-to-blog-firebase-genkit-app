import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../podcast/models/podcast_model.dart';
import '../bloc/image/image_bloc.dart';
import '../bloc/speech_to_text/speech_to_text_bloc.dart';
import 'audio_player_widget.dart';

class MainContentWidget extends StatefulWidget {
  final Item item;

  const MainContentWidget({
    super.key,
    required this.item,
  });

  @override
  MainContentWidgetState createState() => MainContentWidgetState();
}

class MainContentWidgetState extends State<MainContentWidget> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(UrlSource(widget.item.enclosureUrl ?? ''));
      await player.stop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEpisodeImage(),
            const SizedBox(
              height: 10,
            ),
            _buildContent(),
            _buildTextSection(context)
          ],
        ),
      ),
    );
  }

  Column _buildTextSection(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Text Version of Podcast'),
        ),
        BlocBuilder<SpeechToTextBloc, SpeechToTextState>(
          builder: (context, state) {
            if (state is SpeechToTextLoading) {
              return const CircularProgressIndicator();
            } else if (state is SpeechToTextLoaded) {
              return Text(state.text);
            } else if (state is SpeechToTextError) {
              return const Text('Failed to fetch subtitles');
            } else {
              return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }

  Column _buildContent() {
    return Column(
      children: [
        Text(
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          Bidi.stripHtmlIfNeeded(widget.item.description.toString()),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          'Listen to original podcast',
        ),
        PlayerWidget(player: player),
      ],
    );
  }

  Widget _buildEpisodeImage() {
    return SizedBox(
      height: 200,
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ImageLoaded) {
            return Image.memory(state.image);
          } else if (state is ImageError) {
            return const Text('Failed to fetch image');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
