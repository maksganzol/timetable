import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocWaitForState<Event, State> on Bloc<Event, State> {
  Future<void> waitFor(bool Function(State) predicate) async {
    await for (final state in stream) {
      if (predicate(state)) {
        return;
      }
    }
  }
}
