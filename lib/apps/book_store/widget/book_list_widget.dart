import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/BookList.dart';

class BookListWidget extends StatelessWidget {
  final TabController controller;

  const BookListWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: const [
        _books(
          type: '1',
        ),
        _books(
          type: '2',
        ),
        _books(
          type: '3',
        ),
        _books(
          type: '4',
        ),
      ],
    );
  }
}

class _books extends StatefulWidget {
  final String type;

  const _books({Key? key, required this.type}) : super(key: key);

  @override
  State<_books> createState() => _booksState();
}

class _booksState extends State<_books> with AutomaticKeepAliveClientMixin{

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  RxList<BookList> list = RxList([]);
  int index = 1;
  int total = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    index = 1;
    Api.book_list(widget.type, pageNum: index).then((value) {
      if (value.success && value.data != null) {
        list.value = value.data ?? [];
        total = value.total ?? 0;
        _refreshController.refreshCompleted();
      } else {
        _refreshController.resetNoData();
      }
    }).catchError((e) {
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() async {
    if (total > list.length) {
      index++;
      Api.book_list(widget.type, pageNum: index).then((value) {
        if (value.success && value.data != null) {
          list.addAll(value.data ?? []);
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      }).catchError((e) {
        _refreshController.loadFailed();
      });
    } else {
      _refreshController.loadNoData();
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: ListView.builder(
            itemCount: list.length,
            itemExtent: 130,
            itemBuilder: (_, index) {
              final data = list[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routers.bookDetailsPage,
                        arguments: data,
                        parameters: {'bookId': '${data.bookId}'});
                  },
                  child: Container(

                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: BookCover(
                            height: double.infinity,

                            title: '${data.name}',
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  data.author ?? '--',
                                  style: Get.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Expanded(
                                    child: Text(
                                      '${htmlparser
                                          .parse(data.synopsis)
                                          .body
                                          ?.text}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.labelLarge,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
