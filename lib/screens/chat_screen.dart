import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<_Msg> _msgs = [];
  bool _sending = false;

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() {
      _msgs.add(_Msg(role: 'user', text: text));
      _sending = true;
      _controller.clear();
    });

    final apiKey = const String.fromEnvironment('OPENROUTER_API_KEY', defaultValue: '');
    if (apiKey.isEmpty) {
      setState(() {
        _msgs.add(_Msg(role: 'assistant', text: 'OpenRouter key missing. Add it as a GitHub secret named OPENROUTER_API_KEY.'));
        _sending = false;
      });
      return;
    }

    try {
      final resp = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "openai/gpt-4o-mini",
          "messages": [
            {"role": "system", "content": "You are Ava, a helpful fashion/lifestyle assistant."},
            ..._msgs.map((m)=>{"role": m.role, "content": m.text}).toList(),
          ],
        }),
      );

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final reply = data['choices'][0]['message']['content'] as String? ?? '(empty)';
        setState(() {
          _msgs.add(_Msg(role: 'assistant', text: reply));
          _sending = false;
        });
      } else {
        setState(() {
          _msgs.add(_Msg(role: 'assistant', text: 'API error: ${resp.statusCode} ${resp.body}'));
          _sending = false;
        });
      }
    } catch (e) {
      setState(() {
        _msgs.add(_Msg(role: 'assistant', text: 'Network error: $e'));
        _sending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _msgs.length,
              itemBuilder: (c, i) {
                final m = _msgs[i];
                final isUser = m.role == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 520),
                    decoration: BoxDecoration(
                      color: isUser ? Theme.of(context).colorScheme.primaryContainer
                                     : Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(m.text),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _send(),
                      decoration: const InputDecoration(
                        hintText: 'Ask Ava…',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilledButton(
                    onPressed: _sending ? null : _send,
                    child: _sending ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                    : const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Msg {
  final String role;
  final String text;
  _Msg({required this.role, required this.text});
}
