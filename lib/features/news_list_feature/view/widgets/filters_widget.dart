import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_cubit.dart';

import '../../../models/filter_model.dart/filter_model.dart';

class FiltersList extends StatefulWidget {
  FiltersList({
    required this.onSubmit,
    required this.changeOrder,
    Key? key,
  }) : super(key: key);

  void Function(Filter) onSubmit;
  void Function() changeOrder;

  @override
  State<FiltersList> createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  bool newestFirst = true;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: TextField(
                autofocus: false,
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Поиск по теме'),
              ),
            ),
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
                      ?.copyWith(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month - 1, DateTime.now().day),
                        lastDate: DateTime.now());
                    if (date != null) {
                      setState(() {
                        dateFrom = date;
                      });
                    }
                  },
                  child: Text(
                    DateFormat('dd-MM-yyy').format(dateFrom),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
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
                      ?.copyWith(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: dateFrom,
                        lastDate: DateTime.now());
                    if (date != null) {
                      setState(() {
                        dateTo = date;
                      });
                    }
                  },
                  child: Text(
                    DateFormat('dd-MM-yyy').format(dateTo),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
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
                  'Сначала новые',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
                Checkbox(
                    value: newestFirst,
                    onChanged: (value) {
                      setState(() {
                        newestFirst = value!;
                        widget.changeOrder();
                      });
                    })
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final filter = Filter(
                    from: DateFormat('yyyy-MM-dd').format(dateFrom),
                    to: DateFormat('yyyy-MM-dd').format(dateTo),
                    search: _controller.text);

                widget.onSubmit(filter);
                Navigator.of(context).pop();
              },
              child: const Text('Поиск'),
            ),
          ],
        ),
      ),
    );
  }
}
