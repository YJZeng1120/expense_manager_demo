import 'package:flutter/material.dart';

abstract class NewsEvent {
  const NewsEvent();
}

class FetchNewsListEvent extends NewsEvent {
  const FetchNewsListEvent();
}

class FetchNewsDetailEvent extends NewsEvent {
  const FetchNewsDetailEvent(this.id);
  final String id;
}

class ScrollControllerEvent extends NewsEvent {
  const ScrollControllerEvent(this.scrollController);
  final ScrollController scrollController;
}
