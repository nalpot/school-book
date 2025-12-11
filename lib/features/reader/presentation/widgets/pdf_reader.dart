import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// A customizable PDF viewer widget that supports both local and remote PDF files.
///
/// This widget can load PDFs from either a local file path or download them from a URL.
/// It includes features like page navigation, loading states, and error handling.
class CustomPdfViewer extends StatefulWidget {
  /// Path to a local PDF file
  final String? pdfPath;

  /// URL to download the PDF from
  final String? pdfUrl;

  /// Creates a PDF viewer widget
  ///
  /// Either [pdfPath] or [pdfUrl] must be provided, but not both.
  /// - [pdfPath]: Path to a local PDF file
  /// - [pdfUrl]: URL to download the PDF from
  const CustomPdfViewer({super.key, this.pdfPath, this.pdfUrl})
    : assert(
        pdfPath != null || pdfUrl != null,
        'Either pdfPath or pdfUrl must be provided',
      ),
      assert(
        pdfPath == null || pdfUrl == null,
        'Cannot provide both pdfPath and pdfUrl',
      );

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  // Controller for the PDF viewer
  final PdfViewerController _controller = PdfViewerController();

  // Path to the local PDF file (either provided or downloaded)
  String? _localFilePath;

  // Controls the visibility of the top toolbar
  bool _isToolbarVisible = true;

  // State for tracking PDF download/loading progress
  bool _isDownloading = false;
  String? _downloadError;

  // Current page and total pages for navigation
  int _currentPage = 0;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  /// Initializes the PDF viewer with either local file or downloads from URL
  Future<void> _init() async {
    if (widget.pdfPath != null) {
      // Use the provided local file path
      setState(() {
        _localFilePath = widget.pdfPath;
      });
      return;
    }

    // Download or load from cache if URL is provided
    await _loadOrDownloadPdf();
  }

  /// Loads PDF from cache or downloads it from the provided URL
  ///
  /// This method implements a caching mechanism to avoid re-downloading the same file.
  /// Files are stored in the app's documents directory with a hashed filename based on the URL.
  Future<void> _loadOrDownloadPdf() async {
    setState(() {
      _isDownloading = true;
      _downloadError = null;
    });

    try {
      // Get the app's documents directory for storing cached files
      final dir = await getApplicationDocumentsDirectory();
      final fileName = _buildFileName(widget.pdfUrl!);
      final file = File('${dir.path}/$fileName');

      // Check if file already exists in cache
      if (await file.exists()) {
        setState(() {
          _localFilePath = file.path;
          _isDownloading = false;
        });
        return;
      }

      // Download the PDF file
      final response = await http.get(Uri.parse(widget.pdfUrl!));

      // Check if the request was successful
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      // Save the downloaded file
      await file.writeAsBytes(response.bodyBytes, flush: true);

      // Update the UI with the downloaded file
      setState(() {
        _localFilePath = file.path;
        _isDownloading = false;
      });
    } catch (e) {
      // Handle any errors during download or file operations
      setState(() {
        _isDownloading = false;
        _downloadError = 'Failed to load PDF\n$e';
      });
    }
  }

  /// Generates a unique filename for the PDF based on its URL
  ///
  /// Uses SHA-1 hashing to create a consistent filename for each unique URL.
  /// This ensures the same URL always maps to the same filename for caching purposes.
  String _buildFileName(String url) {
    final hash = sha1.convert(utf8.encode(url)).toString();
    return 'pdf_$hash.pdf';
  }

  void _toggleToolbar() {
    setState(() => _isToolbarVisible = !_isToolbarVisible);
  }

  @override
  Widget build(BuildContext context) {
    // Show error view if there was a problem loading the PDF
    if (_downloadError != null) {
      return _ErrorView(message: _downloadError!);
    }

    // Show loading indicator while downloading or initializing
    if (_isDownloading || _localFilePath == null) {
      return const _LoadingView(text: 'Loading PDF...');
    }

    // Main PDF viewer UI
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // PDF viewer with tap-to-toggle toolbar
          GestureDetector(
            onTap: _toggleToolbar,
            child: SfPdfViewer.file(
              File(_localFilePath!),
              controller: _controller,
              onDocumentLoaded: (details) {
                // Update the total page count when the document is loaded
                setState(() {
                  _totalPages = details.document.pages.count;
                });
              },
              onPageChanged: (details) {
                // Update the current page when the user navigates
                setState(() {
                  _currentPage = details.newPageNumber;
                });
              },
            ),
          ),

          // Top toolbar with page navigation (conditionally shown)
          if (_isToolbarVisible)
            _TopBar(currentPage: _currentPage, totalPages: _totalPages),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _TopBar({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.transparent],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  totalPages == 0
                      ? 'Loading...'
                      : 'Page $currentPage of $totalPages',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String text;

  const _LoadingView({required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 24),
            Text(text, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
