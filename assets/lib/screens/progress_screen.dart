import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/bmr_component.dart';
import '../components/ideal_weight_component.dart';
import '../extensions/extension_util/list_extensions.dart';
import '../extensions/LiveStream.dart';
import '../extensions/shared_pref.dart';
import '../main.dart';
import '../../components/bmi_component.dart';
import '../../components/step_count_component.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../screens/progress_detail_screen.dart';
import '../components/horizontal_bar_chart.dart';
import '../extensions/decorations.dart';
import '../extensions/text_styles.dart';
import '../extensions/widgets.dart';
import '../network/rest_api.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class ProgressScreen extends StatefulWidget {
  static String tag = '/ProgressScreen';

  const ProgressScreen({super.key});

  @override
  ProgressScreenState createState() => ProgressScreenState();
}

class ProgressScreenState extends State<ProgressScreen> {
  bool? isWeight, isHeartRate, isPush;

  @override
  void initState() {
    super.initState();
    init();
    LiveStream().emit(IdealWeight);
    getDoubleAsync(IdealWeight);

    LiveStream().on(PROGRESS_SETTING, (p0) {
      userStore.mProgressList.forEachIndexed((element, index) {
        if (element.id == 1) {
          isWeight = element.isEnable;
        }
        if (element.id == 2) {
          isHeartRate = element.isEnable;
        }
        if (element.id == 3) {
          isPush = element.isEnable;
        }
        setState(() {});
      });
    });
  }

  init() async {
    userStore.mProgressList.forEachIndexed((element, index) {
      if (element.id == 1) {
        isWeight = element.isEnable;
        if (element.isEnable == true) {
          getProgressApi(METRICS_WEIGHT);
        }
      }
      if (element.id == 2) {
        isHeartRate = element.isEnable;
        if (element.isEnable == true) {
          getProgressApi(METRICS_HEART_RATE);
        }
      }
      if (element.id == 3) {
        isPush = element.isEnable;
        if (element.isEnable == true) {
          getProgressApi(PUSH_UP_MIN_UNIT);
        }
      }
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value!, style: boldTextStyle()),
        8.width,
        const Icon(Icons.keyboard_arrow_right, color: primaryColor),
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 8);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: appBarWidget(languages.lblReport, showBack: false, color: appStore.isDarkMode ? scaffoldColorDark : Colors.white, context: context, titleSpacing: 16),
        body: Observer(builder: (context) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const StepCountComponent().expand(),
                    16.width,
                    const BMIComponent().expand().visible(userStore.weightUnit.isNotEmpty && userStore.heightUnit.isNotEmpty),
                  ],
                ).paddingSymmetric(horizontal: 16),
                16.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BMRComponent().expand().visible(userStore.weightUnit.isNotEmpty && userStore.heightUnit.isNotEmpty),
                    16.width,
                    const IdealWeightComponent().expand().visible(userStore.gender.isNotEmpty && userStore.heightUnit.isNotEmpty),
                  ],
                ).paddingSymmetric(horizontal: 16),
                16.height,
                if (isWeight == true)
                  FutureBuilder(
                    future: getProgressApi(METRICS_WEIGHT),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: appStore.isDarkMode
                              ? boxDecorationWithRoundedCorners(borderRadius: radius(16), backgroundColor: context.cardColor)
                              : boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mHeading(languages.lblWeight),
                              SizedBox(
                                child: SingleChildScrollView(
                                  primary: true,
                                  scrollDirection: Axis.horizontal,
                                  child: HorizontalBarChart(snapshot.data?.data).withSize(width: context.width(), height: 250),
                                ).paddingSymmetric(horizontal: 8),
                              )
                            ],
                          ).onTap(() async {
                            bool? res = await ProgressDetailScreen(mType: METRICS_WEIGHT, mUnit: METRICS_WEIGHT_UNIT, mTitle: languages.lblWeight).launch(context);
                            if (res == true) {
                              setState(() {});
                            }
                          }),
                        );
                      }
                      return snapWidgetHelper(snapshot, loadingWidget: const SizedBox());
                    },
                  ).visible(userStore.weight.isNotEmpty && userStore.weightUnit.isNotEmpty),
                if (isHeartRate == true)
                  FutureBuilder(
                    future: getProgressApi(METRICS_HEART_RATE),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: appStore.isDarkMode
                              ? boxDecorationWithRoundedCorners(borderRadius: radius(16), backgroundColor: context.cardColor)
                              : boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mHeading(languages.lblHeartRate),
                              SingleChildScrollView(
                                primary: true,
                                scrollDirection: Axis.horizontal,
                                child: HorizontalBarChart(snapshot.data!.data).withSize(width: context.width(), height: 250),
                              ).paddingSymmetric(horizontal: 8)
                            ],
                          ).onTap(() async {
                            bool? res = await ProgressDetailScreen(mType: METRICS_HEART_RATE, mUnit: METRICS_HEART_UNIT, mTitle: languages.lblHeartRate).launch(context);
                            if (res == true) {
                              setState(() {});
                            }
                          }),
                        );
                      }
                      return snapWidgetHelper(snapshot, loadingWidget: const SizedBox());
                    },
                  ),
                if (isPush == true)
                  FutureBuilder(
                    future: getProgressApi(PUSH_UP_MIN),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: appStore.isDarkMode
                              ? boxDecorationWithRoundedCorners(borderRadius: radius(16), backgroundColor: context.cardColor)
                              : boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mHeading(languages.lblPushUp),
                              SingleChildScrollView(
                                primary: true,
                                scrollDirection: Axis.horizontal,
                                child: HorizontalBarChart(snapshot.data!.data).withSize(width: context.width(), height: 250),
                              ).paddingSymmetric(horizontal: 8)
                            ],
                          ).onTap(() async {
                            bool? res = await ProgressDetailScreen(mType: PUSH_UP_MIN, mUnit: PUSH_UP_MIN_UNIT, mTitle: languages.lblPushUp).launch(context);
                            if (res == true) {
                              setState(() {});
                            }
                          }),
                        );
                      }
                      return snapWidgetHelper(snapshot);
                    },
                  ),
                16.height,
              ],
            ),
          );
        }),
      );
    });
  }
}
