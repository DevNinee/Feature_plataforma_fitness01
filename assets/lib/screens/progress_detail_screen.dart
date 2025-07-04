import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_fitness/extensions/constants.dart';
import 'package:mighty_fitness/extensions/extension_util/int_extensions.dart';
import '../extensions/colors.dart';
import '../screens/no_data_screen.dart';
import '../../components/progress_component.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/loader_widget.dart';
import '../../extensions/widgets.dart';
import '../../main.dart';
import '../components/horizontal_bar_chart.dart';
import '../extensions/decorations.dart';
import '../extensions/setting_item_widget.dart';
import '../extensions/text_styles.dart';
import '../models/graph_response.dart';
import '../network/rest_api.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';

enum SampleItem { month, year }

class ProgressDetailScreen extends StatefulWidget {
  static String tag = '/ProgressDetailScreen';

  final String? mType;
  final String? mUnit;
  final String? mTitle;

  final Function? onCall;

  const ProgressDetailScreen({super.key, this.mType, this.mUnit, this.mTitle, this.onCall});

  @override
  ProgressDetailScreenState createState() => ProgressDetailScreenState();
}

class ProgressDetailScreenState extends State<ProgressDetailScreen> {
  GraphResponse? mGraphModel;
  SampleItem? selectedMenu;
  int page = 1;
  int? numPage;
  bool isLastPage = false;

  int? mWeight = 1;
  bool isKGClicked = false;
  bool isLBSClicked = false;


  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !appStore.isLoading) {
        if (page < numPage!) {
          page++;
          init();
        }
      }
    });
  }

  init({bool? isFilter = false, String? isFilterType}) async {
    if (userStore.adsBannerDetailShowAdsOnProgressDetail == 1) loadInterstitialAds();
    appStore.setLoading(true);
    await getProgressApi(widget.mType, isFilter: isFilter, isFilterType: isFilterType).then((value) {
      mGraphModel = value;
      numPage = value.pagination!.totalPages;
      isLastPage = false;

      appStore.setLoading(false);

      // widget.onCall!.call();
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      setState(() {});
    });
  }

  GraphResponse _convertWeightsToLbs(GraphResponse response) {
    const double kgToLbsConversionFactor = 2.20462;

    response.data = response.data?.map((item) {
      if (item.value != null) {
        var valueRes=item.value!.replaceAll('user', '').toDouble();
        var data = (valueRes * kgToLbsConversionFactor).toDouble();
        item.value=data.toStringAsFixed(2);
        item.unit='lbs';
      }
      return item;
    }).toList();

    return response;
  }


  initLbs({bool? isFilter = false, String? isFilterType}) async {
    if (userStore.adsBannerDetailShowAdsOnProgressDetail == 1) loadInterstitialAds();
    appStore.setLoading(true);
    await getProgressApi(widget.mType, isFilter: isFilter, isFilterType: isFilterType).then((value) {
      mGraphModel = _convertWeightsToLbs(value);
      numPage = value.pagination!.totalPages;
      isLastPage = false;

      appStore.setLoading(false);

      // widget.onCall!.call();
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      setState(() {});
    });
  }




  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    if (userStore.adsBannerDetailShowAdsOnProgressDetail == 1)  showInterstitialAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
          appBar: appBarWidget(widget.mTitle.toString(),
              backWidget: Icon(
                appStore.selectedLanguageCode == 'ar' ? MaterialIcons.arrow_back_ios : Octicons.chevron_left,
                color: primaryColor,
                size: 28,
              ).onTap(() {
                Navigator.pop(context, true);
              }),
              context: context,
              actions: [
                widget.mTitle=='Weight'?Container(
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: appStore.isDarkMode
                        ? context.cardColor
                        : GreyLightColor,
                  ),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      mWeightOption(languages.lblLbs, 0),
                      4.width,
                      mWeightOption(languages.lblKg, 1),
                    ],
                  ),
                ):const SizedBox.shrink(),
                PopupMenuButton<SampleItem>(
                  icon: Icon(Icons.more_vert, color: appStore.isDarkMode ? Colors.white : Colors.black54),
                  shape: RoundedRectangleBorder(borderRadius: radius()),
                  initialValue: selectedMenu,
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedMenu = item;
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                    PopupMenuItem<SampleItem>(
                      value: SampleItem.month,
                      child: Text(languages.lblMonth, style: primaryTextStyle()),
                      onTap: () {
                        init(isFilter: true, isFilterType: "month");
                      },
                    ),
                    PopupMenuItem<SampleItem>(
                      value: SampleItem.year,
                      child: Text(languages.lblYear.capitalizeFirstLetter(), style: primaryTextStyle()),
                      onTap: () {
                        init(isFilter: true, isFilterType: "year");
                      },
                    ),
                  ],
                )
              ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: appStore.isDarkMode ? cardDarkColor : cardLightColor,
                  shape: RoundedRectangleBorder(borderRadius: radiusOnly(topRight: 18, topLeft: 18)),
                  builder: (context) {
                    // return METRICS_WEIGHT.isNotEmpty
                    //     ?
                    return ProgressComponent(
                      mType: widget.mType,
                      mUnit: widget.mUnit,
                      onCall: () {
                        print("$isLBSClicked");
                        if(isLBSClicked==true){
                          initLbs();
                        }else{
                          init();

                        }
                      },
                    );
                    // : ProgressComponent(
                    //     mType: widget.mType,
                    //     mUnit: widget.mUnit,
                    //     onCall: () {
                    //       init();
                    //     },
                    //   );
                  });
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: Stack(
            children: [
              if (mGraphModel != null)
                mGraphModel!.data!.isEmpty
                    ? NoDataScreen(
                        mTitle: languages.lblResultNoFound,
                      ).center().visible(mGraphModel!.data!.isEmpty)
                    : SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: HorizontalBarChart(mGraphModel!.data!).withSize(width: context.width(), height: 280),
                            ),
                            ListView.separated(
                              itemCount: mGraphModel!.data!.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16, bottom: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SettingItemWidget(
                                  title: '${mGraphModel!.data![index].value.validate().replaceAll('user', '')} ${mGraphModel!.data![index].unit!.toString()}',
                                  trailing: Text(progressDateStringWidget(mGraphModel!.data![index].date.toString()), style: secondaryTextStyle()),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  titleTextStyle: boldTextStyle(size: 14),
                                  onTap: () async {
                                    /*await showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        backgroundColor: appStore.isDarkMode ? cardDarkColor : cardLightColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius)),
                                        ),
                                        builder: (context) {
                                          // return METRICS_WEIGHT.isNotEmpty
                                          //     ?
                                          return ProgressComponent(
                                            mType: widget.mType,
                                            mUnit: widget.mUnit,
                                            onCall: () {
                                              init();
                                            },
                                          );
                                          // : ProgressComponent(
                                          //     mType: widget.mType,
                                          //     mUnit: widget.mUnit,
                                          //     onCall: () {
                                          //       init();
                                          //     },
                                          //   );
                                        });*/
                                  },
                                  subTitleTextStyle: secondaryTextStyle(size: 12),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(thickness: 0.3);
                              },
                            ),
                          ],
                        ),
                      ),
              const Loader().visible(appStore.isLoading)
            ],
          )),
    );
  }

  Widget mWeightOption(String? value, int? index) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(6),
          backgroundColor: mWeight == index
              ? primaryColor
              : appStore.isDarkMode
              ? context.cardColor
              : GreyLightColor),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(value!, style: secondaryTextStyle(color: mWeight == index ? Colors.white : textSecondaryColorGlobal)),
    ).onTap(() {
      mWeight = index;
      if (index == 0) {
        if (!isLBSClicked) {
          print("------------273>>>LBS");
          initLbs();
          isLBSClicked = true;
          isKGClicked = false;
        }
      } else {
        if (!isKGClicked) {
          print("------------273>>>Kg");
          init();
          isKGClicked = true;
          isLBSClicked = false;
        }
      }
      setState(() {});
    });
  }
}
