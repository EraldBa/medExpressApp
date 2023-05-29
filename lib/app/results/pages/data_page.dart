import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/text_bubble.dart';
import 'package:med_express/app/results/models/search_data.dart';
import 'package:med_express/app/results/pages/simple_data_page.dart';
import 'package:med_express/extensions/string_extension.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';
import 'package:med_express/services/search_service.dart';
import 'package:med_express/services/show_services.dart' as show;

class DataPage extends StatefulWidget {
  final SearchData data;

  const DataPage({super.key, required this.data});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> with AdaptiveScreenMixin {
  static const List<Color> _randomColors = [
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.lightBlue,
    Colors.green,
    Colors.deepPurple
  ];

  static const String _paragraphTerminator = '|';

  final ScrollController _scrollController = ScrollController();

  String? _pmcid;
  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 50.0) {
        setState(() {
          _isScrolled = true;
        });
      } else {
        setState(() {
          _isScrolled = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget? get pdfFloatingActionButton {
    return _pmcid != null
        ? FloatingActionButton.extended(
            isExtended: _isScrolled,
            onPressed: () {
              show.loadingScreen(context);
              SearchService.requestPDF(pmcid: _pmcid!).then((pdfText) {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  SimpleDataPage.customRoute('PDF', pdfText),
                );
              });
            },
            label: const Text('Get PDF'),
            icon: const Icon(Icons.picture_as_pdf_rounded),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final columnBody = <Widget>[];

    int i = 0;
    widget.data.toMap.forEach((name, value) {
      final color = _randomColors[i++];

      late final Widget textBubble;

      if (value is List<String>) {
        textBubble = TextBubble.fromListOfStrings(
          value,
          title: name,
          color: color,
        );
      } else if (value is String) {
        if (name == 'pmcid') {
          _pmcid = value.isNotEmpty ? value : null;
        }

        value = value
            .formatWith('\n', step: isSmallScreen(context) ? 50 : 80)
            .replaceAll(_paragraphTerminator, '\n\n');

        textBubble = TextBubble(
          value,
          title: name,
          color: color,
        );
      } else {
        return;
      }

      columnBody.add(textBubble);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnBody,
          ),
        ),
      ),
      floatingActionButton: pdfFloatingActionButton,
    );
  }
}
