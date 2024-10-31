import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../podcast/models/podcast_model.dart';
import '../bloc/summarize/summarize_bloc.dart';
import '../bloc/translation/translate_bloc.dart';
import 'audio_player_widget.dart';

class MoreWidget extends StatefulWidget {
  final Item item;

  const MoreWidget({
    super.key,
    required this.item,
  });

  @override
  MoreWidgetState createState() => MoreWidgetState();
}

class MoreWidgetState extends State<MoreWidget> {
  late AudioPlayer player = AudioPlayer();
  bool isTranslateEnabled = false;

  @override
  void initState() {
    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.stop();
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Here you can get a short text and audio sumary of the podcast',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () {
                context.read<SummarizeBloc>().add(FetchSummary(id: widget.item.id.toString()));
              },
              child: const Text('Show Summary'),
            ),
          ),
          BlocConsumer<SummarizeBloc, SummarizeState>(
            listener: (context, state) {
              if (state is AudioLoaded && state.audioPath.isNotEmpty) {
                player.setSource(DeviceFileSource(state.audioPath));
              }
            },
            builder: (context, state) {
              if (state is SummarizeLoading) {
                return const CircularProgressIndicator();
              } else if (state is SummarizeLoaded || state is AudioLoaded) {
                String summary = '';
                if (state is SummarizeLoaded) {
                  summary = state.summary;
                } else if (state is AudioLoaded) {
                  summary = state.summary;
                }
                return Column(
                  children: [
                    if (state is AudioLoaded) PlayerWidget(player: player),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<TranslateBloc, TranslateState>(
                          builder: (context, translationState) {
                            log('translationState: $translationState');
                            if (translationState is TranslateLoading) {
                              return const CircularProgressIndicator();
                            } else if (translationState is TranslateLoaded && isTranslateEnabled) {
                              return Text(translationState.text);
                            } else if (translationState is TranslateError) {
                              return Text('Error: ${translationState.message}');
                            } else {
                              return Text(summary);
                            }
                          },
                        )),
                    FilledButton(
                      onPressed: () {
                        if (isTranslateEnabled == false) {
                          context.read<TranslateBloc>().add(FetchTranslation(text: summary));
                        }

                        setState(() {
                          isTranslateEnabled = !isTranslateEnabled;
                        });
                      },
                      child: const Text('Translate to French'),
                    ),
                  ],
                );
              } else if (state is SummarizeError) {
                return Text('Error: ${state.message}');
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
