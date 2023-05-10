import 'package:flutter/material.dart';

import 'package:med_express/extensions/string_extension.dart';
import 'package:med_express/app/results/models/pubmed_data.dart';
import 'package:med_express/app/results/pages/pubmed_page.dart';

class PubMedResultsPage extends StatefulWidget {
  final List<PubMedData> data;
  final String image;

  const PubMedResultsPage({super.key, required this.data, required this.image});

  static MaterialPageRoute customRouter(
      BuildContext context, List<PubMedData> data, String image) {
    return MaterialPageRoute(
      builder: (context) => PubMedResultsPage(
        data: data,
        image: image,
      ),
    );
  }

  @override
  State<PubMedResultsPage> createState() => _PubMedResultsPageState();
}

class _PubMedResultsPageState extends State<PubMedResultsPage> {
  late final List<bool> _isOpen = List.filled(widget.data.length, false);

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PubMed'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.image,
              child: Image.asset(widget.image),
            ),
            ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 300),
              elevation: 8.0,
              dividerColor: Colors.purple[800],
              expandedHeaderPadding: const EdgeInsets.all(15.0),
              children: widget.data.map((e) {
                return ExpansionPanel(
                  backgroundColor: Colors.blue[800],
                  canTapOnHeader: true,
                  headerBuilder: (_, __) => _Text(e.title),
                  body: Column(
                    children: [
                      const Text('Summary:\n'),
                      _Text('${e.summary}\n'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PubMedPage(data: e);
                              },
                            ),
                          );
                        },
                        child: const Text('View full info\n'),
                      )
                    ],
                  ),
                  isExpanded: _isOpen[index++],
                );
              }).toList(),
              expansionCallback: (i, isOpen) {
                setState(() {
                  _isOpen[i] = !isOpen;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;

  const _Text(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.formatWith('\n', step: 50),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
