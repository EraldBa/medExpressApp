import 'package:flutter/material.dart';
import 'package:med_express/app/results/models/nhs_data.dart';

class NhsResultPage extends StatelessWidget {
  final List<NhsData> data;
  final String image;

  const NhsResultPage({super.key, required this.data, required this.image});

  static MaterialPageRoute customRouter(
    BuildContext context, {
    required List<NhsData> data,
    required String image,
  }) {
    return MaterialPageRoute(
      builder: (context) => NhsResultPage(
        data: data,
        image: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
