import 'package:flutter/material.dart';

import '../../../../di.dart';
import '../../domain/usecases/get_book_usecase.dart';
import '../widgets/pdf_reader.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({required this.id, super.key});

  final int id;

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<GetBookUseCase>().call(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;
        return CustomPdfViewer(pdfUrl: data.file);
      },
    );
  }
}
