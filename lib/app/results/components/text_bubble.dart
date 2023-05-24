// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:med_express/services/search_service.dart';
import 'package:med_express/services/show_services.dart' as show;

class TextBubble extends StatelessWidget {
  final String text, title;
  final Color color;
  final VoidCallback? onTap;

  const TextBubble(
    this.text, {
    super.key,
    required this.title,
    required this.color,
    this.onTap,
  });

  TextBubble.fromListOfStrings(
    List<String> text, {
    super.key,
    this.onTap,
    required this.title,
    required this.color,
  }) : this.text = text.join(', ');

  Widget _contextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final text = editableTextState.textEditingValue.text;
    final buttonItems = editableTextState.contextMenuButtonItems;

    buttonItems.add(
      ContextMenuButtonItem(
        label: 'Process text with NLP...',
        onPressed: () {
          final messenger = ScaffoldMessenger.of(context);

          show.nlpProcessOptionsModalButtomSheet(context).then((nlpProcess) {
            SearchService.processTextWithNLP(text, nlpProcess)
                .then((processedText) {
              messenger.showMaterialBanner(
                MaterialBanner(
                  content: Text(processedText),
                  actions: const [Text('exit')],
                ),
              );
            });
          });
        },
      ),
    );

    return AdaptiveTextSelectionToolbar.buttonItems(
      buttonItems: buttonItems,
      anchors: editableTextState.contextMenuAnchors,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        elevation: 20.0,
        margin: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SelectableText.rich(
            contextMenuBuilder: _contextMenuBuilder,
            onTap: onTap,
            TextSpan(
              children: [
                TextSpan(
                  text: '${title.toUpperCase()}\n',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: text,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
