# stack_grouping_list

Stack grouping list inpired by iOS notification group.

[![Pub](https://img.shields.io/pub/v/stack_grouping_list)](https://pub.dev/packages/stack_grouping_list)

![Screenshot](https://raw.githubusercontent.com/chittapon/stack_grouping_list/master/images/demo.gif)

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  stack_grouping_list: ^0.1.0
```

## Basic Usage
Create grouping container widget from `StackGroupingContainer` required `itemCount` and `itemBuilder` parameter.
```dart
    //For this example, we create single group.
    return StackGroupingContainer(
      itemBuilder: (BuildContext context, int index, bool isExpanded){
        List<BoxShadow> boxShadow = [BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.04), offset: Offset(0, 3),)];
        // Prevent shadow too dark
        if (!isExpanded){
          if (index > 3 ){
            boxShadow = null;
          }
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: boxShadow,
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(width: 10,),
                  Text('MESSENGER'),
                  Spacer(),
                  Text('1m ago'),
                ],
              ),
              SizedBox(height: 4,),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Wick',
                      ),
                      SizedBox(height: 4,),
                      Text('Everything\'s got a price.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 3,
      headerBuilder: (BuildContext context, bool isExpanded, VoidCallback onDismiss){
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('Messenger',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: Row(
                    children: [
                      Text('Show less',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_up),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      groupingItemCount: 3,
      itemHeight: 90,
      headerHeight: 46,
      expandItemPadding: 15,
      onSelectItem: (index){
        print("select item $index");
      },
    );
```

## Constructor

| Parameter  | Default   | Description |
| :------------ |:---------------:| :-----|
| itemCount | null  | The number of item in group. |
| itemBuilder | null | Customization of item widget. |
| headerBuilder | null |  Customization of header widget. |
| isExpanded | false | Initial expand group, set true to initial expand. |
| groupingItemCount | 3  | Number of display stack cards. |
| itemHeight | 120  | Because the item widget is in the stack widget tree so we have to define height of item widget. |
| groupingItemPadding | 10.0  | Padding for each item in state grouping. |
| expandItemPadding | 10.0 | Padding for each item in state expand. |
| onSelectItem | null | Callback function when selecting item. |
| headerHeight | 46 | Height of header widget. |
| animatedSizeDuration | 350 ms | The duration of sizing animation. |
| animatedGroupDuration | 300 ms | The duration of positioned item animation. |
