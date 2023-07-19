

abstract class RootState {
  const RootState();
}

class RootInitialState extends RootState {}

class RootLoadingState extends RootState {}

class RootSuccessState extends RootState {}

class RootErrorState extends RootState {
  final String errors;

  const RootErrorState({required this.errors});
}
