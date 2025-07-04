import 'package:flutter/material.dart';
import '../extensions/extension_util/context_extensions.dart';
import '../main.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/widgets.dart';
import '../../screens/view_workouts_screen.dart';
import '../../utils/app_colors.dart';
import '../extensions/constants.dart';
import '../extensions/text_styles.dart';
import 'view_all_diet.dart';

class FavouriteScreen extends StatefulWidget {
  static String tag = '/FavouriteScreen';

  final int index;

  const FavouriteScreen({super.key, required this.index});

  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  bool? select;

  @override
  void initState() {
    super.initState();
    init();
    print("1234565");

  }


  @override
  void deactivate() {
    super.deactivate();
    print("1234565");
  }

  init() async {
    //
    if (widget.index == 0) {
      select = true;
    } else {
      select = false;
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(languages.lblFavoriteWorkoutAndNutristions,
          context: context,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.dividerColor))),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: select! ? primaryColor : Colors.transparent))),
                  child: Text(
                    languages.lblWorkouts,
                    style: boldTextStyle(color: select! ? primaryColor : textSecondaryColorGlobal),
                  ).center(),
                ).onTap(
                  () {
                    setState(() {
                      select = !select!;
                    });
                  },
                ).expand(),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: select! ? Colors.transparent : primaryColor))),
                  child: Text(languages.lblDiet, style: boldTextStyle(color: select! ? textSecondaryColorGlobal : primaryColor)).center(),
                ).onTap(
                  () {
                    setState(() {
                      select = !select!;
                    });
                  },
                ).expand(),
              ]).paddingSymmetric(horizontal: 16),
            ),
          )),
      body: select! ? const ViewWorkoutsScreen(isFav: true) : const ViewAllDiet(isFav: true),
    );
  }
}
