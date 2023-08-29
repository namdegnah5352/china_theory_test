import 'package:flutter/material.dart';
import 'dart:collection';
import 'web_buttons.dart';

class WebButtonList<E> extends ListBase<E> {
  WebButtonList({
    required this.buttonInactiveTextActive,
    required this.buttonActiveTextInActive,
    required this.buttonHover,
    required this.textHover,
    required this.width,
    required this.cornerRadius,
  });
  
  final Color buttonInactiveTextActive;
  final Color buttonActiveTextInActive;
  final Color buttonHover;
  final Color textHover;
  final double width;
  final double cornerRadius;
  
  late bool boolean;

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
extension MyExtension on WebButtonList<WebTextButton> {
  void setSize(bool size){
    for(WebTextButton webTextButton in this){
      webTextButton.size = size;
    }
    boolean = size;
  }
  void onTap(int id){
    for(WebTextButton webTextButton in this){
      if(webTextButton.bId == id){
        webTextButton.active = true;
      } else {
        webTextButton.active = false;
      }
    }
  } 
  void addButton(WebTextButton element){
    element.buttonActiveTextInActive = buttonActiveTextInActive;
    element.buttonInactiveTextActive = buttonInactiveTextActive;
    element.buttonHover = buttonHover;
    element.textHover = textHover;
    element.cornerRadius = cornerRadius;
    element.width = width;
    innerList.add(element);
  }
}