enum Status { empty, loading, done, error }

class DataState<T> {
  late Status status;
  T? data;
  late String? message;
  DataState.empty([this.message, this.data]) : status = Status.empty;
  DataState.loading([this.message, this.data]) : status = Status.loading;
  DataState.done(this.data) : status = Status.done;
  DataState.error([this.message]) : status = Status.error;

  R when<R>(
      {R Function(String?)? empty,
      required R Function(String?) loading,
      required R Function(T) done,
      R Function(String?)? error}) {
    switch (status) {
      case Status.empty:
        return empty!(message);
      case Status.loading:
        return loading(message);
      case Status.done:
        return done(data!);
      case Status.error:
        return error!(message);
    }
  }

  @override
  String toString() {
    return "Status: $status, Message: $message, Data: $data";
  }
}
