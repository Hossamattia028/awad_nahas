// ignore_for_file: camel_case_types, constant_identifier_names

enum ORDER_STATUS{
  PENDING,
  ONGOING,
  COMPLETED,
  CANCELED
}


class WCStatusKey{
  static const  wc_pending = "wc-pending";
  static const  wc_processing = "wc-processing";
  static const  wc_canceled = "wc-canceled";
  static const  wc_tamara_canceled = "wc-tamara-p-canceled";
  static const  wc_tamara_failed = "wc-tamara-p-failed";
}
