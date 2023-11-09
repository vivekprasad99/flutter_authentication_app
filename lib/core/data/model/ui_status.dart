enum Event {
  success,
  failed,
  none,
  verified,
}

class UIStatus {
  bool isOnScreenLoading;
  bool isDialogLoading;
  String successWithAlertMessage;
  String loadingMessage;
  String successWithoutAlertMessage;
  String failedWithAlertMessage;
  String failedWithoutAlertMessage;
  Event event;
  dynamic data;

  UIStatus(
      {this.isOnScreenLoading = false,
      this.isDialogLoading = false,
      this.successWithAlertMessage = '',
      this.loadingMessage = '',
      this.successWithoutAlertMessage = '',
      this.failedWithAlertMessage = '',
      this.failedWithoutAlertMessage = '',
      this.event = Event.none,
      this.data});
}
