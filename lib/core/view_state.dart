enum Status { LOADING, ERROR, DATA }

class ViewState<LOADING, ERROR, DATA> {
  Status status;
  LOADING loading;
  ERROR error;
  DATA data;

  ViewState.setLoading(this.loading) : status = Status.LOADING;

  ViewState.setData(this.data) : status = Status.DATA;

  ViewState.setError(this.error) : status = Status.ERROR;
}
