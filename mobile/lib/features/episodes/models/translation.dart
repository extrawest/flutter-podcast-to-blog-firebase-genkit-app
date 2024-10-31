class TranslationResponse {
  final String? translationText;

  TranslationResponse({required this.translationText});

  factory TranslationResponse.fromJson(Map<String, dynamic> json) {
    return TranslationResponse(
      translationText: json['translation_text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translation_text': translationText,
    };
  }

  @override
  String toString() {
    return 'TranslationResponse{translationText: $translationText}';
  }
}