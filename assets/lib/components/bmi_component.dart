import 'package:flutter/material.dart';
import '../extensions/LiveStream.dart';
import '../extensions/extension_util/context_extensions.dart';
import '../extensions/colors.dart';
import '../extensions/decorations.dart';
import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_images.dart';
import '../extensions/text_styles.dart';
import 'count_down_progress_indicator.dart';

class BMIComponent extends StatefulWidget {
  static String tag = '/BMIComponent';

  const BMIComponent({super.key});

  @override
  BMIComponentState createState() => BMIComponentState();
}

class BMIComponentState extends State<BMIComponent> with TickerProviderStateMixin {
  double? mKg;
  double? mCm;
  double? mBMI;

  late AnimationController controller;
  CountDownController mCountDownController = CountDownController();

  @override
  void initState() {
    super.initState();
    init();
    LiveStream().on(PROGRESS, (p0) {
      convertLbsToKg();
      convertFeetToCm();
      double m = (mCm)! * 0.01;
      mBMI = mKg! / (m * m);
      setState(() {});
    });
  }

  init() async {
    //
    convertLbsToKg();
    convertFeetToCm();

    double m = (mCm)! * 0.01;
    mBMI = mKg! / (m * m);

    super.initState();
  }

  //Convert lbs to kg
  void convertLbsToKg() {
    print("user weight->${userStore.weight}");
    double a = double.parse(userStore.weight.toString()) * 2.2046;
    mKg = userStore.weightUnit == LBS ? a : double.parse(userStore.weight.validate());
  }

  // convert Feet to cm
  void convertFeetToCm() {
    mCm = userStore.heightUnit == FEET ? double.parse(userStore.height.validate()) * 30.48 : double.parse(userStore.height.validate());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration:
          appStore.isDarkMode ? boxDecorationWithRoundedCorners(borderRadius: radius(16), backgroundColor: context.cardColor) : boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: boxDecorationWithRoundedCorners(borderRadius: radius(8), backgroundColor: appStore.isDarkMode ? Colors.black : Colors.white),
                padding: const EdgeInsets.all(6),
                child: Image.asset(ic_calories, width: 22, height: 22, color: primaryColor),
              ),
              Text(languages.lblBmi, style: boldTextStyle(color: appStore.isDarkMode ? primaryColor : black), overflow: TextOverflow.ellipsis, maxLines: 2),
            ],
          ),
          12.height,
          Image.asset(ic_bmi, width: 50, height: 50, color: primaryColor),
          10.height,
          Text(mBMI!.toStringAsFixed(2).validate(), style: boldTextStyle(size: 19)),
          Text(languages.lblKcal, style: secondaryTextStyle()),
        ],
      ),
    );
  }
}
