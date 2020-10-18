import 'package:flutter/material.dart';
import 'stack_grouping_content.dart';

class StackGroupingContainer extends StatefulWidget {

  bool isExpanded = false;
  int groupingItemCount;
  double itemHeight;
  double groupingItemPadding;
  double expandItemPadding;
  double headerHeight;
  Duration animatedSizeDuration;
  Duration animatedGroupDuration;

  final Widget Function(BuildContext context, int index, bool isExpanded) itemBuilder;
  final Widget Function(BuildContext context, bool isExpanded, VoidCallback onCollapse) headerBuilder;
  final Function(int index) onSelectItem;
  final int itemCount;

  StackGroupingContainer({@required this.itemCount,
    @required this.itemBuilder,
    this.headerBuilder,
    this.isExpanded = false,
    this.groupingItemCount = 3,
    this.itemHeight = 120,
    this.groupingItemPadding = 10,
    this.expandItemPadding = 10,
    this.onSelectItem,
    this.headerHeight = 46,
    this.animatedSizeDuration = const Duration(milliseconds: 350),
    this.animatedGroupDuration = const Duration(milliseconds: 300),
  }) : assert(itemCount != null && itemBuilder != null);

  @override
  _StackGroupingContainerState createState() => _StackGroupingContainerState();
}

class _StackGroupingContainerState extends State<StackGroupingContainer> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _height;
  Animation<double> _contentTopPosition;
  Animation<double> _headerTopPosition;

  Future<void> triggerContent({bool isExpanded}) async {

    widget.isExpanded = isExpanded;

    try {
      if (isExpanded){
        await _controller.animateTo(1).orCancel;
      }else {
        await _controller.animateTo(0).orCancel;
      }
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _controller = AnimationController(vsync: this, duration: widget.animatedSizeDuration);

    _height = Tween<double>(
      begin: _collapseHeight(),
      end: _expandHeight(),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _contentTopPosition = Tween<double>(
      begin: 0,
      end: widget.headerHeight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _headerTopPosition = Tween<double>(
      begin: widget.headerHeight,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    super.initState();

  }

  double _collapseHeight() {
    if (widget.itemCount == 1){
      return widget.itemHeight + widget.groupingItemPadding;
    }
    double totalHeight = widget.itemHeight;
    for (int index = 0; index < widget.groupingItemCount; index++){
      totalHeight += widget.groupingItemPadding;
    }
    return totalHeight;
  }

  double _expandHeight() {
    if (widget.itemCount == 1){
      return widget.itemHeight + widget.expandItemPadding;
    }
    double totalHeight = 0;
    for (int index = 0; index < widget.itemCount; index++){
      totalHeight += widget.itemHeight;
      totalHeight += widget.expandItemPadding;
    }
    bool hasHeader = widget.headerBuilder != null;
    if (hasHeader){
      totalHeight += widget.headerHeight;
    }
    return totalHeight;
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget child){

      bool hasHeader = widget.headerBuilder != null;

      return Container(
        height: _height.value,
        child: Stack(
          children: [
            if (hasHeader)
              Positioned(
                left: 0,
                right: 0,
                top: _headerTopPosition.value,
                height: widget.headerHeight,
                child: widget.headerBuilder(context, widget.isExpanded, (){
                  triggerContent(isExpanded: false);
                }),
              ),
            Positioned(
              left: 0,
              right: 0,
              top: _contentTopPosition.value,
              height: _height.value,
              child: StackGroupingContent(
                isExpanded: widget.isExpanded,
                itemCount: widget.itemCount,
                itemBuilder: widget.itemBuilder,
                itemHeight: widget.itemHeight,
                animatedGroupDuration: widget.animatedGroupDuration,
                expandItemPadding: widget.expandItemPadding,
                groupingItemCount: widget.groupingItemCount,
                groupingItemPadding: widget.groupingItemPadding,
                onSelectItem: widget.onSelectItem,
                onContentTrigger: (isExpanded){
                  triggerContent(isExpanded: isExpanded);
                },
              ),
            ),
          ],
        ),
      );
    },
    );
  }

}
