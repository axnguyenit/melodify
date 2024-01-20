import 'package:equatable/equatable.dart';

typedef MapCallback<T, S> = S Function(T source);
typedef CompareCallback<T> = int Function(T a, T b);

class Group<T extends Object> extends Equatable {
  final String groupBy;
  final List<T> list;
  final Map<String, dynamic>? extra;
  final bool isHidden;

  Group({
    required this.groupBy,
    List<T>? initial,
    this.extra,
    this.isHidden = false,
  }) : list = initial ?? <T>[];

  factory Group.custom({required String type, Map<String, dynamic>? data}) {
    return Group(groupBy: type, extra: data);
  }

  void add(T item) {
    list.add(item);
  }

  void addAll(List<T> items) {
    list.addAll(items);
  }

  int get length => list.length;

  T itemAtIndex(int index) => list[index];

  void sort({required CompareCallback<T> compareCallback}) {
    list.sort(compareCallback);
  }

  void insertItem(T item, {required int at}) {
    list.insert(at, item);
  }

  A? extraObjectByKey<A extends Object>({required String key}) {
    if (extra == null) {
      return null;
    }

    return extra![key];
  }

  Group<S> map<S extends Object>(MapCallback<T, S> mapCallback) {
    return Group(
      groupBy: groupBy,
      initial: list.map((e) => mapCallback(e)).toList(),
      extra: extra,
    );
  }

  Group<T> copyWith({bool? isHidden}) {
    return Group<T>(
      groupBy: groupBy,
      initial: list,
      extra: extra,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  List<Object> get props => [groupBy];
}
