// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:med_express/app/results/pages/simple_data_page.dart';
import 'package:med_express/services/search_service.dart';
import 'package:med_express/services/show_services.dart' as show;

class TextBubble extends StatelessWidget {
  static const _maxWordsForSnackBar = 600;
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
        onPressed: () async {
          final messenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);

          final nlpProcess =
              await show.nlpProcessOptionsModalButtomSheet(context);

          final processedText =
              await SearchService.processTextWithNLP(text, nlpProcess);

          if (processedText.length > _maxWordsForSnackBar) {
            navigator.push(SimpleDataPage.customRoute(title, processedText));
            return;
          }

          messenger.showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.pink,
              content: Text(processedText),
              actions: [
                MaterialButton(
                  onPressed: () => messenger.removeCurrentMaterialBanner(),
                  child: const Text('Exit'),
                )
              ],
              onVisible: () async {
                await Future.delayed(const Duration(seconds: 3));
                messenger.removeCurrentMaterialBanner();
              },
            ),
          );
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
