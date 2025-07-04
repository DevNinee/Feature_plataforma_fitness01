import 'package:mighty_fitness/extensions/extension_util/context_extensions.dart';
import 'package:mighty_fitness/extensions/text_styles.dart';
import 'package:mighty_fitness/main.dart';
import 'package:mighty_fitness/utils/AppButtonWidget.dart';
import 'package:mighty_fitness/utils/app_colors.dart';
import 'package:mighty_fitness/utils/app_images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/material.dart';


class UpdateAvailable extends StatefulWidget {
  bool? force;
  String storeUrl;
  UpdateAvailable({super.key, this.force,required this.storeUrl});

  @override
  State<UpdateAvailable> createState() => _UpdateAvailableState();
}

class _UpdateAvailableState extends State<UpdateAvailable> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(widget.force!=true){
          return true;
        }
        return false;
      },
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          runAlignment: WrapAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 45,),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: context.width() * 0.40, child: Image.asset(updateAvailableImg)),
                    const SizedBox(height: 16,),
                    Text(
                      textAlign: TextAlign.center,
                      languages.lblUpdateAvailable,
                      style: boldTextStyle(color: primaryColor),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      textAlign: TextAlign.center,
                        languages.lblUpdateNote,
                      style: secondaryTextStyle(color: primaryColor),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: widget.force!=true?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppButtonWidget(
                          text: languages.lblUpdateNow,
                          color: primaryColor,
                          textStyle: boldTextStyle( size: 18,color: Colors.white),
                          onTap: () {
                            if (Platform.isAndroid) {
                              launchUrl(Uri.parse(widget.storeUrl), mode: LaunchMode.externalApplication);
                            } else if (Platform.isIOS) {
                              launchUrl(Uri.parse(widget.storeUrl), mode: LaunchMode.externalApplication);
                            }
                          },
                        ),
                        if(widget.force!=true)
                        const SizedBox(width: 8,),
                        if(widget.force!=true)
                          AppButtonWidget(
                          text: languages.lblSkip,
                          color: Colors.white,
                          shapeBorder: RoundedRectangleBorder(side: const BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(12)),
                          textStyle: boldTextStyle( size: 18,color: primaryColor),
                          onTap: () {
                           Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                // Observer(builder: (context) {
                //   return Loader().center().visible(appStore.isLoading);
                // })
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
