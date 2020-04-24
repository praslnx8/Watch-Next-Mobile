enum Status { NONE, LOADING, ERROR, DATA }

class ViewState<LOADING, ERROR, DATA> {
  Status status;
  LOADING loading;
  ERROR error;
  DATA data;

  ViewState.setNone() : status = Status.NONE;

  ViewState.setLoading(this.loading) : status = Status.LOADING;

  ViewState.setData(this.data) : status = Status.DATA;

  ViewState.setError(this.error) : status = Status.ERROR;
}

class SingleEventState<DATA> extends ViewState<bool, String, DATA> {
  SingleEventState.setData(DATA data) : super.setData(data);

  SingleEventState.setError(String error) : super.setError(error);

  SingleEventState.setLoading() : super.setLoading(true);

  SingleEventState.setNone() : super.setNone();
}
