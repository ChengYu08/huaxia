
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';

class Ebooks extends StatefulWidget {
  const Ebooks({Key? key}) : super(key: key);

  @override
  State<Ebooks> createState() => _EbooksState();
}

class _EbooksState extends State<Ebooks>  with WidgetsBindingObserver {
  late EpubController _epubController;
  @override
  void initState() {
    _epubController = EpubController(
      // Load document
      document: EpubDocument.openAsset('assets/images/book.epub'),
      // Set start point
      epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
    );
    super.initState();
  }
  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: EpubViewActualChapter(
        controller: _epubController,
        builder: (chapterValue) => Text(
          chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
          textAlign: TextAlign.start,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.save_alt),
          color: Colors.white,
          onPressed: () => _showCurrentEpubCfi(context),
        ),
      ],
    ),
    drawer: Drawer(
      child: EpubViewTableOfContents(controller: _epubController),
    ),
    body: EpubView(
      builders: EpubViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        chapterDividerBuilder: (_) => const Divider(),
      ),
      controller: _epubController,
    ),
  );

  void _showCurrentEpubCfi(context) {
    final cfi = _epubController.generateEpubCfi();

    if (cfi != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(cfi),
          action: SnackBarAction(
            label: 'GO',
            onPressed: () {
              _epubController.gotoEpubCfi(cfi);
            },
          ),
        ),
      );
    }
  }
}
