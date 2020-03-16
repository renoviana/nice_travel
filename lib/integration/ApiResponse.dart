//https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

class ApiResponse<T> {
  Status status;
  T data;
  String message;

  ApiResponse.loading({this.message = 'Carregando'}) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
