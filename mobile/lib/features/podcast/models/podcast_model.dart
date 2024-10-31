import 'dart:convert';

class PodcastModel {
  final String? status;
  final List<Item>? items;
  final int? count;
  final String? query;
  final String? description;

  PodcastModel({
    required this.status,
    required this.items,
    required this.count,
    required this.query,
    required this.description,
  });

  PodcastModel copyWith({
    String? status,
    List<Item>? items,
    int? count,
    String? query,
    String? description,
  }) =>
      PodcastModel(
        status: status ?? this.status,
        items: items ?? this.items,
        count: count ?? this.count,
        query: query ?? this.query,
        description: description ?? this.description,
      );

  factory PodcastModel.fromJson(String str) => PodcastModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PodcastModel.fromMap(Map<String, dynamic> json) => PodcastModel(
        status: json["status"],
        items: json["items"] != null ? List<Item>.from(json["items"].map((x) => Item.fromMap(x))) : null,
        count: json["count"],
        query: json["query"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "items": items != null ? List<dynamic>.from(items!.map((x) => x.toMap())) : null,
        "count": count,
        "query": query,
        "description": description,
      };
}

class Item {
  final int? id;
  final String? title;
  final String? link;
  final String? description;
  final String? guid;
  final int? datePublished;
  final String? datePublishedPretty;
  final int? dateCrawled;
  final String? enclosureUrl;
  final EnclosureType? enclosureType;
  final int? enclosureLength;
  final int? duration;
  final int? explicit;
  final dynamic episode;
  final EpisodeType? episodeType;
  final int? season;
  final String? image;
  final int? feedItunesId;
  final String? feedImage;
  final int? feedId;
  final FeedLanguage? feedLanguage;
  final int? feedDead;
  final dynamic feedDuplicateOf;
  final String? chaptersUrl;
  final dynamic transcriptUrl;
  final Value? value;

  Item({
    required this.id,
    required this.title,
    required this.link,
    required this.description,
    required this.guid,
    required this.datePublished,
    required this.datePublishedPretty,
    required this.dateCrawled,
    required this.enclosureUrl,
    required this.enclosureType,
    required this.enclosureLength,
    required this.duration,
    required this.explicit,
    required this.episode,
    required this.episodeType,
    required this.season,
    required this.image,
    required this.feedItunesId,
    required this.feedImage,
    required this.feedId,
    required this.feedLanguage,
    required this.feedDead,
    required this.feedDuplicateOf,
    required this.chaptersUrl,
    required this.transcriptUrl,
    required this.value,
  });

  Item copyWith({
    int? id,
    String? title,
    String? link,
    String? description,
    String? guid,
    int? datePublished,
    String? datePublishedPretty,
    int? dateCrawled,
    String? enclosureUrl,
    EnclosureType? enclosureType,
    int? enclosureLength,
    int? duration,
    int? explicit,
    dynamic episode,
    EpisodeType? episodeType,
    int? season,
    String? image,
    int? feedItunesId,
    String? feedImage,
    int? feedId,
    FeedLanguage? feedLanguage,
    int? feedDead,
    dynamic feedDuplicateOf,
    String? chaptersUrl,
    dynamic transcriptUrl,
    Value? value,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
        description: description ?? this.description,
        guid: guid ?? this.guid,
        datePublished: datePublished ?? this.datePublished,
        datePublishedPretty: datePublishedPretty ?? this.datePublishedPretty,
        dateCrawled: dateCrawled ?? this.dateCrawled,
        enclosureUrl: enclosureUrl ?? this.enclosureUrl,
        enclosureType: enclosureType ?? this.enclosureType,
        enclosureLength: enclosureLength ?? this.enclosureLength,
        duration: duration ?? this.duration,
        explicit: explicit ?? this.explicit,
        episode: episode ?? this.episode,
        episodeType: episodeType ?? this.episodeType,
        season: season ?? this.season,
        image: image ?? this.image,
        feedItunesId: feedItunesId ?? this.feedItunesId,
        feedImage: feedImage ?? this.feedImage,
        feedId: feedId ?? this.feedId,
        feedLanguage: feedLanguage ?? this.feedLanguage,
        feedDead: feedDead ?? this.feedDead,
        feedDuplicateOf: feedDuplicateOf ?? this.feedDuplicateOf,
        chaptersUrl: chaptersUrl ?? this.chaptersUrl,
        transcriptUrl: transcriptUrl ?? this.transcriptUrl,
        value: value ?? this.value,
      );

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        description: json["description"],
        guid: json["guid"],
        datePublished: json["datePublished"],
        datePublishedPretty: json["datePublishedPretty"],
        dateCrawled: json["dateCrawled"],
        enclosureUrl: json["enclosureUrl"],
        enclosureType: json["enclosureType"] != null ? enclosureTypeValues.map[json["enclosureType"]] : null,
        enclosureLength: json["enclosureLength"],
        duration: json["duration"],
        explicit: json["explicit"],
        episode: json["episode"],
        episodeType: json["episodeType"] != null ? episodeTypeValues.map[json["episodeType"]] : null,
        season: json["season"],
        image: json["image"],
        feedItunesId: json["feedItunesId"],
        feedImage: json["feedImage"],
        feedId: json["feedId"],
        feedLanguage: json["feedLanguage"] != null ? feedLanguageValues.map[json["feedLanguage"]] : null,
        feedDead: json["feedDead"],
        feedDuplicateOf: json["feedDuplicateOf"],
        chaptersUrl: json["chaptersUrl"],
        transcriptUrl: json["transcriptUrl"],
        value: json["value"] != null ? Value.fromMap(json["value"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "description": description,
        "guid": guid,
        "datePublished": datePublished,
        "datePublishedPretty": datePublishedPretty,
        "dateCrawled": dateCrawled,
        "enclosureUrl": enclosureUrl,
        "enclosureType": enclosureType != null ? enclosureTypeValues.reverse[enclosureType] : null,
        "enclosureLength": enclosureLength,
        "duration": duration,
        "explicit": explicit,
        "episode": episode,
        "episodeType": episodeType != null ? episodeTypeValues.reverse[episodeType] : null,
        "season": season,
        "image": image,
        "feedItunesId": feedItunesId,
        "feedImage": feedImage,
        "feedId": feedId,
        "feedLanguage": feedLanguage != null ? feedLanguageValues.reverse[feedLanguage] : null,
        "feedDead": feedDead,
        "feedDuplicateOf": feedDuplicateOf,
        "chaptersUrl": chaptersUrl,
        "transcriptUrl": transcriptUrl,
        "value": value != null ? value!.toMap() : null,
      };

  @override
  String toString() {
    return 'Item{id: $id, title: $title, link: $link, description: $description, guid: $guid, datePublished: $datePublished, datePublishedPretty: $datePublishedPretty, dateCrawled: $dateCrawled, enclosureUrl: $enclosureUrl, enclosureType: $enclosureType, enclosureLength: $enclosureLength, duration: $duration, explicit: $explicit, episode: $episode, episodeType: $episodeType, season: $season, image: $image, feedItunesId: $feedItunesId, feedImage: $feedImage, feedId: $feedId, feedLanguage: $feedLanguage, feedDead: $feedDead, feedDuplicateOf: $feedDuplicateOf, chaptersUrl: $chaptersUrl, transcriptUrl: $transcriptUrl, value: $value}';
  }
}

enum EnclosureType { AUDIO_MPEG }

final enclosureTypeValues = EnumValues({"audio/mpeg": EnclosureType.AUDIO_MPEG});

enum EpisodeType { FULL, TRAILER }

final episodeTypeValues = EnumValues({"full": EpisodeType.FULL, "trailer": EpisodeType.TRAILER});

enum FeedLanguage { EN }

final feedLanguageValues = EnumValues({"en": FeedLanguage.EN});

class Value {
  final Model? model; // Make nullable
  final List<Destination>? destinations; // Make nullable

  Value({
    this.model,
    this.destinations,
  });

  factory Value.fromMap(Map<String, dynamic> json) => Value(
        model: json["model"] != null ? Model.fromMap(json["model"]) : null,
        destinations: json["destinations"] != null ? List<Destination>.from(json["destinations"].map((x) => Destination.fromMap(x))) : null,
      );

  Map<String, dynamic> toMap() => {
        "model": model?.toMap(),
        "destinations": destinations != null ? List<dynamic>.from(destinations!.map((x) => x.toMap())) : null,
      };
}

class Destination {
  final Name? name; // Make nullable
  final DestinationType? type; // Make nullable
  final String? address; // Make nullable
  final int? split; // Make nullable
  final String? customKey; // Make nullable
  final CustomValue? customValue; // Make nullable
  final bool? fee; // Make nullable

  Destination({
    this.name,
    this.type,
    this.address,
    this.split,
    this.customKey,
    this.customValue,
    this.fee,
  });

  factory Destination.fromMap(Map<String, dynamic> json) => Destination(
        name: json["name"] != null ? nameValues.map[json["name"]] : null,
        type: json["type"] != null ? destinationTypeValues.map[json["type"]] : null,
        address: json["address"],
        split: json["split"],
        customKey: json["customKey"],
        customValue: json["customValue"] != null ? customValueValues.map[json["customValue"]] : null,
        fee: json["fee"],
      );

  Map<String, dynamic> toMap() => {
        "name": name != null ? nameValues.reverse[name] : null,
        "type": type != null ? destinationTypeValues.reverse[type] : null,
        "address": address,
        "split": split,
        "customKey": customKey,
        "customValue": customValue != null ? customValueValues.reverse[customValue] : null,
        "fee": fee,
      };
}

enum CustomValue { J_NH_G48_K_DP_K6_UH6_AJMHH_J, THE_01_IM_QKT4_B_FZ_AI_SYNXC_Q_QQD, X3_VX_ZTBCF_IBVLI_UQZ_WKV }

final customValueValues = EnumValues({
  "JNhG48KDpK6UH6AjmhhJ": CustomValue.J_NH_G48_K_DP_K6_UH6_AJMHH_J,
  "01IMQkt4BFzAiSynxcQQqd": CustomValue.THE_01_IM_QKT4_B_FZ_AI_SYNXC_Q_QQD,
  "x3VXZtbcfIBVLIUqzWKV": CustomValue.X3_VX_ZTBCF_IBVLI_UQZ_WKV
});

enum Name { BOOSTBOT_FOUNTAIN_FM, JOHNS_CREEK_STUDIOS, OP3_AND_REFLEX_LIVEWIRE_IO, PODCASTINDEX_ORG, RANDY_BLACK, RSS_BLUE }

final nameValues = EnumValues({
  "boostbot@fountain.fm": Name.BOOSTBOT_FOUNTAIN_FM,
  "Johns Creek Studios": Name.JOHNS_CREEK_STUDIOS,
  "OP3 and reflex.livewire.io": Name.OP3_AND_REFLEX_LIVEWIRE_IO,
  "Podcastindex.org": Name.PODCASTINDEX_ORG,
  "Randy Black": Name.RANDY_BLACK,
  "RSS Blue": Name.RSS_BLUE
});

enum DestinationType { NODE }

final destinationTypeValues = EnumValues({"node": DestinationType.NODE});

class Model {
  final ModelType? type; // Make nullable
  final Method? method; // Make nullable

  Model({
    this.type,
    this.method,
  });

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        type: json["type"] != null ? modelTypeValues.map[json["type"]] : null,
        method: json["method"] != null ? methodValues.map[json["method"]] : null,
      );

  Map<String, dynamic> toMap() => {
        "type": type != null ? modelTypeValues.reverse[type] : null,
        "method": method != null ? methodValues.reverse[method] : null,
      };
}

enum Method { KEYSEND }

final methodValues = EnumValues({"keysend": Method.KEYSEND});

enum ModelType { LIGHTNING }

final modelTypeValues = EnumValues({"lightning": ModelType.LIGHTNING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
