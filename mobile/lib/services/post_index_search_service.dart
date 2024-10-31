import 'package:podcast_search/podcast_search.dart';


Future<int?> searchPodcast(String query) async{
  final  search = Search();

  /// Search for podcasts with 'widgets' in the title.
  final  results =
      await search.search(query);

  return results.items[0].collectionId;


}