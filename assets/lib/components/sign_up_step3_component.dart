import 'package:flutter/cupertino.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/text_styles.dart';
import '../extensions/app_button.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class SignUpStep3Component extends StatefulWidget {
  final bool? isNewTask;

  const SignUpStep3Component({super.key, this.isNewTask = false});

  @override
  _SignUpStep3ComponentState createState() => _SignUpStep3ComponentState();
}

class _SignUpStep3ComponentState extends State<SignUpStep3Component> {
  int mSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (!userStore.age.isEmptyOrNull) {
      mSelectedIndex = int.parse(userStore.age.validate());
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    if (widget.isNewTask != true) {
      print(userStore.age);
      if (!userStore.age.isEmptyOrNull) {
        mSelectedIndex = int.parse(userStore.age.validate());
      }
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(languages.lblHowOld, style: boldTextStyle(size: 22)),
          SizedBox(
            height: context.height() * 0.6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CupertinoPicker(
                  magnification: 1.4,
                  squeeze: 0.8,
                  useMagnifier: true,
                  selectionOverlay: const SizedBox(),
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: userStore.age.validate().toInt()-17
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    mSelectedIndex = selectedItem+17;
                    setState(() {});
                  },
                  children: List<Widget>.generate(99 - 17 + 1, (int index) {
                    int actualIndex = index + 17;
                    return Text(actualIndex.toString(), style: boldTextStyle(size: 30)).center();
                  }),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 2, width: 100, color: primaryColor),
                    50.height,
                    Container(height: 2, width: 100, color: primaryColor),
                  ],
                ),
              ],
            ),
          ),
          24.height,
          AppButton(
            text: languages.lblNext,
            width: context.width(),
            color: primaryColor,
            onTap: () {
              if (mSelectedIndex > 0) {
                userStore.setAge(mSelectedIndex.toString());
                appStore.signUpIndex = 3;
                setState(() {});
              }else{
                 userStore.setAge(17.toString());
                 appStore.signUpIndex = 3;
                 setState(() {});
              }
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
