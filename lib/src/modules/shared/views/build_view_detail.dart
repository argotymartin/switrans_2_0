import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class BuildViewDetail extends StatelessWidget {
  final String title;
  final String detail;
  final List<String> breadcrumbTrails;
  const BuildViewDetail({
    super.key,
    required this.title,
    this.detail = "",
    this.breadcrumbTrails = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadcrumbTrail(elements: breadcrumbTrails),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.document_scanner_outlined, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
        Text(detail, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
