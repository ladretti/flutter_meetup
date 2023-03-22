import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets.dart';

class GuestBook extends StatefulWidget {
  const GuestBook({required this.addMessage, super.key});
  final FutureOr<void> Function(String message) addMessage;
  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Laissez un message',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Saisissez votre message pour continuer';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await widget.addMessage(_controller.text);
                  _controller.clear();
                }
              },
              child: Row(
                children: const [
                  Icon(Icons.send),
                  SizedBox(width: 4),
                  Text('Envoyer'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
