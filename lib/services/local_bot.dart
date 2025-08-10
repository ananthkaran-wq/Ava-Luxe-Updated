class LocalBot {
  // Tiny rule-based responder to avoid API keys.
  Future<String> reply(String user) async {
    final q = user.toLowerCase().trim();

    await Future<void>.delayed(const Duration(milliseconds: 350));

    if (q.contains('hello') || q.contains('hi')) {
      return 'Hey! I’m Ava 🤖 — how can I help you today?';
    }
    if (q.contains('dress') || q.contains('outfit') || q.contains('wardrobe')) {
      return 'Try opening the Wardrobe tab to tweak your avatar style 👗🧥';
    }
    if (q.contains('theme')) {
      return 'Theme lives under Settings → Dark mode.';
    }
    if (q.contains('help')) {
      return 'You can chat with me, change settings, or build your look in Wardrobe.';
    }
    if (q.isEmpty) {
      return 'Say something and I’ll respond! 🙂';
    }
    return 'Got it: “$user”. (This is a local demo bot — we can wire a real API next.)';
  }
}
