import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_cubit.dart';

class FiltersList extends StatefulWidget {
  FiltersList({
    Key? key,
  }) : super(key: key);
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  bool newestFirst = true;
  @override
  State<FiltersList> createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Искать от',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
            GestureDetector(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year, DateTime.now().month-2, DateTime.now().day),
                    lastDate: DateTime.now());
                if (date != null) {
                  setState(() {
                    widget.dateFrom = date;
                  });
                  context
                      .read<NewsListCubit>()
                      .addFilter('from', DateFormat('yyyy-MM-dd').format(date));
                }
              },
              child: Text(
                DateFormat('dd-MM-yyy').format(widget.dateFrom),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Искать до',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
            GestureDetector(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: widget.dateFrom,
                    lastDate: DateTime.now());
                if (date != null) {
                  setState(() {
                    widget.dateTo = date;
                  });
                  context
                      .read<NewsListCubit>()
                      .addFilter('to', DateFormat('yyyy-MM-dd').format(date));
                }
              },
              child: Text(
                DateFormat('dd-MM-yyy').format(widget.dateTo),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          onTap: () {
            context.read<NewsListCubit>().changeOrder();
            setState(() {
              widget.newestFirst = !widget.newestFirst;
            });
          },
          child: Text(
            widget.newestFirst ? 'Сначала новые' : 'Сначала старые',
            style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
