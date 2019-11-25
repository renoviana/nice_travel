import 'package:intl/intl.dart';

final formatter = NumberFormat.currency(locale: "pt_BR", symbol: "");
final dateFormat = DateFormat("dd/MM/yyyy");
final timeFormat = DateFormat("HH:mm");

String getValueFormatted(valorAPagar) =>
    valorAPagar == null ? null : formatter.format(valorAPagar);

int diffDaysToNow(dt) {
  return dt == null ? 0 : dt.difference(DateTime.now()).inDays;
}

String formatarDate(date) {
  return dateFormat.format(date);
}

String formatarHoraToString(date) {
  return timeFormat.format(date);
}

DateTime formatarStringToHora(String date) {
  return timeFormat.parse(date);
}
