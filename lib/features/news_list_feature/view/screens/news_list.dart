import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_cubit.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_state.dart';
import 'package:newapi_app/features/news_list_feature/view/screens/article_detail_screen.dart';
import 'package:newapi_app/features/news_list_feature/view/widgets/filters_widget.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'iOS News',
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(1.sw, 90.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.h),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Поиск по названию'),
                    onChanged: (value) {
                      context
                          .read<NewsListCubit>()
                          .addFilter('search', _controller.text);
                    },
                  ),
                ),
                FiltersList(),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<NewsListCubit, NewsListState>(
        builder: (context, state) {
          if (state is NewsListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsListEmptyState) {
            return const Center(
              child: Text('Нет новостей'),
            );
          } else if (state is NewsListErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is NewsListLoadedState) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ArticleDetailScreen(article: state.articles[index]);
                  }));
                },
                child: Card(
                  child: ListTile(
                    title: Text(state.articles[index].title ?? '',
                        maxLines: 3, overflow: TextOverflow.ellipsis),
                    subtitle: Text(state.articles[index].author ?? '',
                        maxLines: 3, overflow: TextOverflow.ellipsis),
                    trailing: Text(DateFormat('dd.MM.yyyy')
                        .format(state.articles[index].publishedAt!)),
                  ),
                ),
              ),
              itemCount: state.articles.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 5.h,
              ),
            );
          }
          return const Center(
            child: Text('Wrong state!'),
          );
        },
      ),
    );
  }
}
