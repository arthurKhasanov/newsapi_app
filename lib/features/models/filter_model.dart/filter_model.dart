import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_model.freezed.dart';

@freezed
class Filter with _$Filter {
  const factory Filter({
    String? from,
    String? to,
    String? search,
  }) = _Filter;


  
}
