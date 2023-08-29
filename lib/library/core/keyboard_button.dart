import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardButton extends StatefulWidget {
  KeyboardButton({
    Key? key, 
    required this.onPressed, 
    required this.label,
    required this.enabled,
    this.height,
    this.width,
    this.enabledColor,
    this.disabledColor,
    this.focussedBorderColor,
    this.hoveredTextColor,
    this.unHoveredTextColor,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String label;
  bool enabled;
  double? height;
  double? width;
  Color? enabledColor;
  Color? disabledColor;
  Color? focussedBorderColor;
  Color? unHoveredTextColor;
  Color? hoveredTextColor;

  @override
  State<KeyboardButton> createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> with TickerProviderStateMixin  {
  late Color? _color = widget.disabledColor;
  bool wasEnabled = false;
  bool _isHovered = false;
  bool _isFocused = false;
  FocusNode _focusNode = FocusNode();
  final Duration _duration = const Duration(milliseconds: 500);
  late AnimationController controller = AnimationController(duration: _duration, vsync: this);
  late Animation<Color?> animation;
  late Color backgroundColor;

  @override
  void initState() {
    
    animation = ColorTween(begin: widget.disabledColor, end: widget.enabledColor).animate(controller)
      ..addListener(() {
        setState(() {
          _color = animation.value;
        });
      });     
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    backgroundColor = widget.disabledColor!;
    if(wasEnabled == false && widget.enabled == true) controller.forward();
    if(wasEnabled == true && widget.enabled == false) controller.reverse();
    wasEnabled = widget.enabled;
    // Change visuals based on focus/hover state
    Color outlineColor = _isFocused ? Colors.black87 : Colors.transparent;
    if(widget.enabled){
      backgroundColor = widget.enabled ? _color! :  widget.disabledColor!;
    } else {
      backgroundColor = widget.enabled ? widget.enabledColor! :  _color!;
    }
    Color textColor = (widget.enabled && _isHovered) ? widget.hoveredTextColor! : widget.unHoveredTextColor!;
    return GestureDetector(
      onTap: widget.enabled ? _handlePressed : null,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        // Set mouse cursor
        mouseCursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onFocusChange: (v) => setState(() => _isFocused = v,),
        
        // Rebuild with hover/focus changes
        onShowHoverHighlight: (v) => setState(() => _isHovered = v),        
        actions: widget.enabled 
          ? {ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handlePressed())} 
          : {ActivateIntent: CallbackAction<Intent>(onInvoke: (_){} )},
        shortcuts: {
          // SingleActivator(LogicalKeyboardKey.keyX, control: true): const ActivateIntent(),
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          child: Center(child: Text(widget.label, style: TextStyle(fontSize: 14, color: textColor),)),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: outlineColor, width: 1),
            borderRadius: BorderRadius.circular(widget.height! / 2),
          ),
        ),
      ),
    );
  }

  void _handlePressed() {
    _focusNode.requestFocus();
    widget.onPressed();
  }
}
