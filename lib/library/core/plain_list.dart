import 'dart:collection';

class PlainList<E> extends ListBase<E> {
  PlainList();

  List innerList = <E>[];

  @override
  int get length => innerList.length;

  @override
  set length(int length) {
    innerList.length = length;
  }
  @override
  void operator[]=(int index, E value) {
    innerList[index] = value;
  }
  @override
  E operator [](int index) => innerList[index];

  @override
  void add(E element) => innerList.add(element);

  @override
  void addAll(Iterable<E> iterable) => innerList.addAll(iterable);
}