import 'package:flutter/foundation.dart';

abstract class BaseUseCase<Input, OutPut> {
  @protected
  Future<OutPut> call(Input param);
}
