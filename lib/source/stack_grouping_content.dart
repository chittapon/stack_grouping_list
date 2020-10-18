import 'package:flutter/material.dart';

class StackGroupingContent extends StatefulWidget {

  bool isExpanded = false;
  double itemHeight;
  int groupingItemCount;
  double groupingItemPadding;
  double expandItemPadding;
  Duration animatedGroupDuration;
  final Widget Function(BuildContext context, int index, bool isExpanded) itemBuilder;
  final Function(bool isExpanded) onContentTrigger;
  final Function(int index) onSelectItem;
  final int itemCount;

  StackGroupingContent({
    this.isExpanded,
    this.itemHeight,
    this.groupingItemCount,
    this.groupingItemPadding,
    this.expandItemPadding,
    this.animatedGroupDuration,
    this.itemBuilder,
    this.itemCount,
    this.onContentTrigger,
    this.onSelectItem});

  @override
  _StackGroupingContentState createState() => _StackGroupingContentState();
}

class _StackGroupingContentState extends State<StackGroupingContent> {

  @override
  Widget build(BuildContext context) {

    double topPosition = 0;
    double leftPosition = 0;
    double rightPosition = 0;

    return GestureDetector(
      onTap: widget.itemCount > 1 ? _expandContent : null,
      child: Stack(

        fit: StackFit.expand,
        children: List.generate(widget.itemCount, (index){

          if (widget.isExpanded){
            if (index > 0){
              topPosition += widget.itemHeight;
              topPosition += widget.expandItemPadding;
            }
          }else {
            if (index > 0 && index < widget.groupingItemCount){
              topPosition += widget.groupingItemPadding;
              leftPosition += widget.groupingItemPadding;
              rightPosition += widget.groupingItemPadding;
            }
          }

          bool selectableItem = widget.isExpanded || widget.itemCount == 1;

          return AnimatedPositioned(
            top: topPosition,
            left: leftPosition,
            right: rightPosition,
            duration: widget.animatedGroupDuration,
            child: SizedBox(
              height: widget.itemHeight,
              child: GestureDetector(
                onTap: selectableItem ? (){
                  widget.onSelectItem(index);
                } : null,
                child: widget.itemBuilder(context, index, widget.isExpanded),
              ),
            ),
          );

        }).toList().reversed.toList(),
      ),
    );
  }

  _expandContent() {
    widget.isExpanded = true;
    widget.onContentTrigger(true);
    setState(() {
      widget.isExpanded = true;
    });
  }

}
