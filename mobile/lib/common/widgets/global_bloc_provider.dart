import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/episodes/bloc/summarize/summarize_bloc.dart';
import '../../features/podcast/bloc/podcast_bloc.dart';

class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PodcastBloc(),
        ),
        BlocProvider(
          create: (context) => SummarizeBloc(),
        ),
      ],
      child: child,
    );
  }
}
