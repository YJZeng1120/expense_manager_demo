class BottomTabsState {
  final int index;

  BottomTabsState({
    this.index = 0,
  });

  BottomTabsState copyWith({
    int? index,
  }) {
    return BottomTabsState(
      index: index ?? this.index,
    );
  }
}
