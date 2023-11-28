abstract class DataState{
  const DataState();
}

class InitialDataState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadingDataState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadedDataState extends DataState {
  final dynamic data;

  LoadedDataState(this.data);

  @override
  List<Object> get props => [data];
}

class ErrorDataState extends DataState {
  final String error;

  ErrorDataState(this.error);

  @override
  List<Object> get props => [error];
}