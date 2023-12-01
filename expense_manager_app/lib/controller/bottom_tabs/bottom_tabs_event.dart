abstract class BottomTabsEvent {
  const BottomTabsEvent();
}

class IndexEvent extends BottomTabsEvent {
  const IndexEvent(this.index);
  final int index;
}
