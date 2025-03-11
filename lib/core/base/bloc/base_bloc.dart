import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/helper/dispose_bag.dart';
import '../../exception/exception.dart';
import '../../../core/result/result.dart';
import '../../../utils/log/log_utils.dart';
import '../common/common_bloc.dart';

part 'base_event.dart';
part 'base_state.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc(super.initialState);

  CommonBloc get commonBloc => GetIt.instance.get();

  final DisposeBag disposeBag = DisposeBag();

  final exceptionHandler = ExceptionHandler();

  @override
  void add(E event) {
    if (!isClosed) {
      super.add(event);
    } else {
      Log.e('Cannot add new event $event because $runtimeType was closed');
    }
  }

  void showLoading() {
    commonBloc.add(const LoadingVisibilityEmitted(isLoading: true));
  }

  void hideLoading() {
    commonBloc.add(const LoadingVisibilityEmitted(isLoading: false));
  }

  void addException(ExceptionWrapper exception) {
    commonBloc.add(ExceptionEmitted(wrapper: exception));
  }

  void clearExcepption() {
    commonBloc.add(const ExceptionEmitted());
  }

  Future<void> blocResultCatching<T>({
    required Future<Result<T>> action,
    Function(T)? onSuccess,
    bool handleLoading = true,
    bool handleError = true,
    Function(AppException)? doOnError,
    Function()? doOnRetry,
  }) async {
    clearExcepption();
    if (handleLoading) {
      showLoading();
    }
    final result = await action;
    result.when(
      success: (data) {
        onSuccess?.call(data);
      },
      error: (error) {
        doOnError?.call(error);
        if (handleError) {
          addException(
            ExceptionWrapper(error, doOnRetry),
          );
        }
      },
    );
    if (handleLoading) {
      hideLoading();
    }
  }

  Future<void> blocCatching<T>({
    required Future<T> action,
    Function(T)? onSuccess,
    bool handleLoading = true,
    bool handleError = true,
    Function(AppException)? doOnError,
    Function()? doOnRetry,
  }) async {
    if (handleLoading) {
      showLoading();
    }

    try {
      final result = await action;
      onSuccess?.call(result);
    } catch (e) {
      doOnError?.call(e is AppException ? e : const UnCatchException());
      if (handleError) {
        addException(
          ExceptionWrapper(
            e is AppException ? e : const UnCatchException(),
            doOnRetry,
          ),
        );
      }
    }
    if (handleLoading) {
      hideLoading();
    }
  }
}
