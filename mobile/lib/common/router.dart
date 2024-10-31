import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_index_app/features/episodes/screens/episode_screen.dart';

import '../features/episodes/bloc/chat/chat_bloc.dart';
import '../features/episodes/bloc/image/image_bloc.dart';
import '../features/episodes/bloc/speech_to_text/speech_to_text_bloc.dart';
import '../features/episodes/bloc/summarize/summarize_bloc.dart';
import '../features/episodes/bloc/translation/translate_bloc.dart';
import '../features/podcast/screens/podcast_screen.dart';

/* * * * * * * * * * * *
*
* /home
* /pages
*     /pages/1
*     /pages/2
*     ...
*     /pages/test
*
* * * * * * * * * * * */

const String podcastsRoute = '/podcasts';
const String episodesRoute = '/episodes';

final globalNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'global');

//todo: disabled for MVP
// final _shellNavigatorFilesKey = GlobalKey<NavigatorState>(debugLabel: 'files');

final goRouter = GoRouter(
  navigatorKey: globalNavigationKey,
  initialLocation: podcastsRoute,
  routes: [
    GoRoute(
      path: podcastsRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const PodcastScreen(),
      ),
    ),
    GoRoute(
      path: episodesRoute,
      builder: (context, state) {
        final extra = state.extra! as Map<dynamic, dynamic>;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SummarizeBloc(),
            ),
            BlocProvider(
              create: (context) => SpeechToTextBloc(),
            ),
            BlocProvider(
              create: (context) => TranslateBloc(),
            ),
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
            BlocProvider(
              create: (context) => ChatBloc(),
            ),
          ],
          child: EpisodeScreen(
            item: extra['item'],
          ),
        );
      },
    ),
  ],
);

class _TransitionPage extends CustomTransitionPage<dynamic> {
  _TransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
