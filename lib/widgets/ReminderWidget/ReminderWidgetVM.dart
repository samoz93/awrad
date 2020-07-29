import 'package:awrad/Consts/ConstMethodes.dart';
import 'package:awrad/models/ReminderModel.dart';
import 'package:stacked/stacked.dart';

class ReminderWidgetVm extends BaseViewModel {
  ReminderModel rmd;
  ReminderWidgetVm({this.rmd});

  List<String> get daysString {
    final weekDay = daysOfWeek;
    return rmd.days.map((e) => weekDay[e]).toList();
  }

  List<String> get timeString {
    final weekDay = timesOfDay;
    return rmd.times.map((e) => weekDay[e]).toList();
  }
}
