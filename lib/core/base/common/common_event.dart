part of 'common_bloc.dart';

class CommonEvent extends BaseEvent {
  const CommonEvent();
}

class ExceptionEmitted extends CommonEvent {
  const ExceptionEmitted({this.wrapper});
  final ExceptionWrapper? wrapper;
}

class LoadingVisibilityEmitted extends CommonEvent {
  const LoadingVisibilityEmitted({
    required this.isLoading,
  });
  final bool isLoading;
}
