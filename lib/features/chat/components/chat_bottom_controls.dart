import 'package:flutter/material.dart';

class ChatBottomControls extends StatefulWidget {
  const ChatBottomControls({
    Key? key,
    required this.onSendPressed,
    required this.onPhotoSendPressed,
    required this.onMediaSendPressed,
  }) : super(key: key);

  final ValueChanged<String> onSendPressed;
  final VoidCallback onPhotoSendPressed;
  final VoidCallback onMediaSendPressed;

  @override
  State<ChatBottomControls> createState() => _ChatBottomControlsState();
}

class _ChatBottomControlsState extends State<ChatBottomControls> {
  String inputText = '';

  final TextEditingController controller = TextEditingController();
  final FocusNode inputFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
             onPressed: () {
              widget.onPhotoSendPressed();
              _resetInputText();
            },
            icon: const Icon(Icons.photo_camera),
          ),
          IconButton(
            onPressed: () {
              widget.onMediaSendPressed();
              _resetInputText();
            },
            icon: const Icon(Icons.audiotrack),
          ),
          Expanded(
            child: _ChatInputTextField(
              focusNode: inputFocusNode,
              controller: controller,
              onChanged: (value) {
                setState(() {
                  inputText = value;
                });
              },
            ),
          ),
          if (inputText.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (inputText.isNotEmpty) {
                  widget.onSendPressed(inputText);
                }
                _resetInputText();
              },
            ),
        ],
      ),
    );
  }

  void _resetInputText() {
    setState(
      () {
        inputText = '';
        controller.text = inputText;
      },
    );
  }
}

class _ChatInputTextField extends StatelessWidget {
  const _ChatInputTextField({Key? key, required this.onChanged, this.controller, this.focusNode}) : super(key: key);

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Type your message',
        filled: true,
        fillColor: Colors.grey[100],
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
