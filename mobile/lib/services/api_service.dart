import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../features/podcast/models/podcast_model.dart';

const String baseUrl = 'http://localhost:3000/api';

class ApiService {
  Future<PodcastModel> getPodcastEpisodes({
    required String id,
  }) async {
    dynamic result = [];
    final response = await http.post(
      Uri.parse('$baseUrl/episodes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'searchTerm': id,
      }),
    );

    if (response.statusCode == 200) {
      result = PodcastModel.fromJson(response.body);
    } else {
      result = 'Failed to fetch summary';
    }
    return result;
  }

  Future<String> getEpisodeSummary({
    required String id,
  }) async {
    dynamic result = [];
    final response = await http.post(
      Uri.parse('$baseUrl/episode_summary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'searchTerm': id,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      result = jsonResponse;
    } else {
      result = 'Failed to fetch summary';
    }
    return result;
  }

  Future<String> getSpeechToText({
    required String id,
  }) async {
    dynamic result = [];
    final response = await http.post(
      Uri.parse('$baseUrl/episode_speech_to_text'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'searchTerm': id,
      }),
    );

    if (response.statusCode == 200) {
      result = response.body;
    } else {
      result = 'Failed to fetch summary';
    }
    return result;
  }

  Future<List<int>> getAudio({required String summary}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/audio_summary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'summaryText': summary,
      }),
    );

    if (response.statusCode == 200) {
      log('Response Content-Type: ${response.headers['content-type']}');
      log('Response body length: ${response.bodyBytes.length}');

      if (response.headers['content-type'] != 'audio/mpeg') {
        throw Exception('Unexpected content type: ${response.headers['content-type']}');
      }

      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch audio: ${response.statusCode}');
    }
  }

  Future<String> saveRawResponse(List<int> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/raw_response.mp3');
    await file.writeAsBytes(data);
    log('Raw response saved to: ${file.path}');
    return file.path;
  }

  Future<String> getTranslation({
    required String text,
  }) async {
    dynamic result = [];
    final response = await http.post(
      Uri.parse('$baseUrl/summary_translation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );

    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    } else {
      result = 'Failed to fetch summary';
    }
    return result;
  }

  Future<Uint8List> getImage({
    required String text,
  }) async {
    dynamic result;
    final response = await http.post(
      Uri.parse('$baseUrl/image'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final base64String = jsonResponse['image'];

      if (jsonResponse['image'] != null) {
        Uint8List bytes = base64Decode(base64String);

        result = bytes;
      } else {
        result = 'Failed to fetch image';
      }
    } else {
      result = 'Failed to fetch image';
    }
    return result;
  }

  Future<String> startChat({required String message, required String context}) async {
    dynamic result;
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"message": message, "context": context}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Parse the response string as JSON
      final responseJson = jsonDecode(jsonResponse['response']);

      result = responseJson['result'].toString();
    } else {
      result = 'Failed to fetch chat';
    }
    return result;
  }
}
