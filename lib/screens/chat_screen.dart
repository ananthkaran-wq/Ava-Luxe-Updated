import 'package:flutter/material.dart';
import '../services/local_bot.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _bot = LocalBot();
  final _c = TextEditingController();
  final _messages = <_Msg>[];

  Future<void> _send() async {
    final text = _c.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(text, true));
      _c.clear();
    });
    final r = await _bot.reply(text);
    setState(() => _messages.add(_Msg(r, false)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (_, i) {
              final m = _messages[i];
              final align = m.me ? CrossAxisAlignment.end : CrossAxisAlignment.start;
              final color  = m.me ? Theme.of(context).colorScheme.primary : Colors.grey.shade300;
              final textColor = m.me ? Colors.white : Colors.black87;
              return Column(
                crossAxisAlignment: align,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 320),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
                    child: Text(m.text, style: TextStyle(color: textColor)),
                  ),
                ],
              );
            },
          ),
        ),
        SafeArea(
          top: false,
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _c,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                  decoration: const InputDecoration(
                    hintText: 'Message Ava...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _send,
                icon: const Icon(Icons.send),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}

class _Msg {
  final String text;
  final bool me;
  _Msg(this.text, this.me);
}
