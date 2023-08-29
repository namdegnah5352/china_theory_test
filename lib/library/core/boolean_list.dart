import 'package:flutter/material.dart';
import 'dart:collection';
import '../../widgets/common_widgets.dart';


class BooleanList<E> extends ListBase<E> {
  BooleanList();

  bool boolean = false;

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
extension MyExtension on BooleanList<CanSize> {
  void setSize(bool size){
    for(CanSize canSize in this){
      canSize.size = size;
    }
    boolean = size;
  }
}