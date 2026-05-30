class AIService {
  static String generateTitle(String text) {
    final cleaned = text.trim();

    if (cleaned.isEmpty) {
      return "Untitled Document";
    }

    final words = cleaned.split(" ");

    if (words.length >= 4) {
      return words.take(4).join(" ");
    }

    return cleaned;
  }

  static String summarizeText(String text) {
    if (text.isEmpty) {
      return "";
    }

    final sentences = text.split(".");

    if (sentences.length <= 2) {
      return text;
    }

    return "${sentences[0]}. ${sentences[1]}.";
  }

  static String cleanOCRText(String text) {
    return text
        .replaceAll("|", "I")
        .replaceAll("0", "O")
        .replaceAll("  ", " ")
        .trim();
  }
}
