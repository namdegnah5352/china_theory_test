import 'package:flutter/material.dart';
import 'dart:collection';
import '../../util/ui/column_heading.dart';
import '../../util/models/enums.dart';

class ColumnHeadingList<E> extends ListBase<E> {
  ColumnHeadingList({
    required this.notHoveredColor,
    required this.isHoveredColor,
    required this.activeColor,
  });
  
  final Color notHoveredColor;
  final Color isHoveredColor;
  final Color activeColor;
  
  late Size size;

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
extension MyExtension on ColumnHeadingList<ColumnHeading> {
  List<Widget> getHeadings(){
    List<Widget> ret = [];
    for(ColumnHeading heading in this){
      if(heading.visible){
        ret.add(heading);
      }
    }
    return ret;
  }
  void setSize(Size size, List<double> limits){
    for(ColumnHeading heading in this){
      if(heading.id == CustomerColumnHeading.accountid.index){
        if(size.width > limits[0]){
          heading.visible = true;
        } else {
          heading.visible = false;
        }
      }
      if(heading.id == CustomerColumnHeading.email.index){
        if(size.width > limits[1]){
          heading.visible = true;
        } else {
          heading.visible = false;
        }
      }  
      if(heading.id == CustomerColumnHeading.joindate.index){
        if(size.width > limits[3]){
          heading.visible = true;
        } else {
          heading.visible = false;
        }
      }          
      // heading.id == CustomerColumnHeading.accountid.index && size.width > limits[0] ? heading.visible = true : heading.visible = false;
      // heading.id == CustomerColumnHeading.email.index && size.width > limits[1] ? heading.visible = true : heading.visible = false;
      // heading.id == CustomerColumnHeading.joindate.index && size.width > limits[3] ? heading.visible = true : heading.visible = false;  
    }
  }
  void onTap(int id){
    for(ColumnHeading heading in this){
      if(heading.id == id){
        heading.active = true;
      } else {
        heading.active = false;
      }
    }
  } 
  void addHeading(ColumnHeading heading){
    heading.activeColor = activeColor;
    heading.notHoveredColor = notHoveredColor;
    heading.isHoveredColor = isHoveredColor;
    innerList.add(heading);
  }
}