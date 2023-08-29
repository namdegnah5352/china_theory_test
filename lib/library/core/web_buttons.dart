import 'package:flutter/material.dart';
import '../../style/app_colors.dart';

import '../../style/text_styles.dart';

class WebTextButton{
  WebTextButton({
    required this.id,
    required this.onTap,
    required this.title,
    required this.active,
    required this.enabled,
    this.height,
  });
  final int id;
  final Function()? onTap;
  final String title;
  bool enabled;
  bool active;
  bool _size = false;
  double? _width;
  double? height;
  double? _cornerRadius;
  Color? _buttonInactiveTextActive;
  Color? _buttonActiveTextInActive;
  Color? _buttonHover;
  Color? _textHover;

  int get bId => id;
  set buttonInactiveTextActive(Color color) => _buttonInactiveTextActive = color;
  set buttonActiveTextInActive(Color color) => _buttonActiveTextInActive = color;
  set buttonHover(Color color) => _buttonHover = color;
  set textHover(Color color) => _textHover = color;
  set width(double width) => _width = width;
  set cornerRadius(double cornerRadius) => _cornerRadius = cornerRadius;
  set size(bool size) => _size = size;
  Widget get button {
    return SizedBox(
      height: height ?? 40,
      width: _size ? (_width ?? 327) : 2 * (_width ?? 327)/3,
      child: TextButton(     
        style: ButtonStyle(
          
          foregroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {

              if(states.contains(MaterialState.pressed)) return _buttonInactiveTextActive;
              // this seems to set the color of the text when hovered
              if(states.contains(MaterialState.hovered)) return active ? _buttonInactiveTextActive : _textHover;
              // this seems to set the color of the text when launched
              return active ? _buttonInactiveTextActive : _buttonActiveTextInActive;
            }
          ),
          
          overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            // this seems to set the color of button background when hovered
            if( states.contains(MaterialState.hovered)){
              return active ? _buttonActiveTextInActive : _buttonHover;
            }
      
          }),       
          textStyle: MaterialStateProperty.resolveWith((Set<MaterialState> states) {

            return whiteButtonText;
          }),
          
          shape: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_cornerRadius ?? 16),
            ),
          ), 
          // this seems to set the color of the button when launched      
          backgroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
                return active ? _buttonActiveTextInActive : _buttonInactiveTextActive;
            }
          ),
        ), 
        onPressed: enabled ? onTap : null,
        child: Text(title),         
      ),
    );    
  }
}


