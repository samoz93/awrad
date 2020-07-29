import 'dart:developer';

import 'package:awrad/Consts/ConstMethodes.dart';
import 'package:awrad/Consts/ThemeCosts.dart';
import 'package:awrad/Views/awrad/AwradVM.dart';
import 'package:awrad/Views/awrad/ExpansionVM.dart';
import 'package:awrad/base/locator.dart';
import 'package:awrad/models/AwradModel.dart';
import 'package:awrad/models/AwradTypesModel.dart';
import 'package:awrad/widgets/LoadingWidget.dart';
import 'package:awrad/widgets/MyErrorWidget.dart';
import 'package:awrad/widgets/MyScf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stacked/stacked.dart';

class AwradListScreen extends StatelessWidget {
  final AwradTypesModel type;
  AwradListScreen({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return MyScaffold(
      title: type.typeName,
      child: ViewModelBuilder<AwradVM>.reactive(
        builder: (context, model, ch) {
          if (model.isBusy) return LoadingWidget();
          if (model.hasError)
            return MyErrorWidget(
              err: model.modelError,
            );
          return ListView.builder(
            itemCount: model.awrad.length,
            itemBuilder: (BuildContext context, int index) {
              final wrd = model.awrad[index];
              return ViewModelBuilder<ExpansionVM>.reactive(
                  viewModelBuilder: () => ExpansionVM(wrd: wrd),
                  builder: (ctx, exVm, ch) {
                    if (exVm.hasError)
                      return MyErrorWidget(
                        err: exVm.modelError,
                      );
                    return ExpansionTile(
                      onExpansionChanged: (v) async {
                        // final _ser = Get.find<NotificationService>();
                        // await _ser.testRemoveAll();
                        final pending = await flutterLocalNotificationsPlugin
                            .pendingNotificationRequests();
                        log(pending.length.toString());
                        log(pending
                            .map((e) =>
                                "${e.body} ${e.id} ${e.payload} ${e.title}\n")
                            .toString());
                      },
                      initiallyExpanded: false,
                      subtitle: Align(
                        alignment: Alignment.bottomRight,
                        child: ch,
                      ),
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Html(data: wrd.wrdDesc),
                            SizedBox(height: 20),
                            AlarmOptions(wrd: wrd),
                            //TODO should i add it ?
                            // exVm.showAlaramOption
                            //     ? SizedBox()
                            //     : Text("خيارات التنبيه")
                          ],
                        ),
                      ],
                      title: Text("${index + 1}-${wrd.wrdName}"),
                    );
                  });
            },
          );
        },
        fireOnModelReadyOnce: true,
        staticChild: Text(type.typeName),
        onModelReady: (vv) => vv.fetchData(type.type),
        viewModelBuilder: () => AwradVM(),
      ),
    );
  }
}

class AlarmOptions extends ViewModelWidget<ExpansionVM> {
  final WrdModel wrd;
  const AlarmOptions({Key key, @required this.wrd}) : super(key: key);

  @override
  Widget build(BuildContext context, ExpansionVM exVm) {
    final media = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: exVm.showAlaramOption
                      ? media.height * 0.2
                      : media.height * 0.07,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        exVm.showAlaramOption
                            ? IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: AppColors.deleteColor,
                                ),
                                onPressed: () {
                                  exVm.toggelAlarmOption();
                                },
                              )
                            : SizedBox(),
                        IconButton(
                          icon: Icon(
                            exVm.showAlaramOption
                                ? Icons.check_circle
                                : Icons.alarm_add,
                            color: AppColors.addColor,
                          ),
                          onPressed: () {
                            exVm.showAlaramOption
                                ? exVm.saveDate()
                                : exVm.toggelAlarmOption();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                exVm.hasReminder && !exVm.showAlaramOption
                    ? IconButton(
                        icon: Icon(
                          Icons.alarm_off,
                          color: AppColors.deleteColor,
                        ),
                        onPressed: () {
                          exVm.deleteNotification(wrd.uid,
                              showNotification: true);
                        },
                      )
                    : SizedBox(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: exVm.showAlaramOption ? media.width * 0.84 : 0,
                  height: exVm.showAlaramOption ? media.height * 0.2 : 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          ToggleButtons(
                            borderRadius: BorderRadius.circular(8),
                            children: <Widget>[
                              ...daysOfWeek.map(
                                (e) => Text(e),
                              ),
                            ],
                            isSelected: exVm.selectionBool,
                            onPressed: (index) {
                              exVm.addDay(index);
                            },
                            color: Colors.red,
                          ),
                          ToggleButtons(
                            borderRadius: BorderRadius.circular(8),
                            children: <Widget>[
                              ...timesOfDay.map(
                                (e) => Text(e.toString()),
                              ),
                            ],
                            isSelected: exVm.selectionBoolTimes,
                            onPressed: (index) {
                              exVm.addTime(index);
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
