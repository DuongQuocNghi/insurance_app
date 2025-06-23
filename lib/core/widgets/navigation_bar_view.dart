import 'package:flutter/material.dart';
import 'package:insurance_app/app/config/app_config.dart';

var openLogApp = 0;

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key,
    this.titleText,
    this.titleWidget,
    this.backgroundColor,
    this.backgroundImage,
    this.actionRight,
    this.actionLeft,
    this.bottomView,
    this.underline,
    this.iconBack,
    this.titleAlignment,
    this.titlePadding,
  });

  final EdgeInsets? titlePadding;
  final Alignment? titleAlignment;
  final Widget? titleWidget;
  final String? titleText;
  final Color? backgroundColor;
  final DecorationImage? backgroundImage;
  final List<Widget>? actionRight;
  final List<Widget>? actionLeft;
  final List<Widget>? bottomView;
  final bool? underline;
  final IconData? iconBack;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? appColors.background,
          image: backgroundImage,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
          child: _bottomView(context),
        )
    );
  }

  Widget _bottomView(BuildContext context){
    return Column(
      children: [
        _buildToolBar(context),
        if(bottomView?.isNotEmpty ?? false)
          ...bottomView ?? [],
      ],
    );
  }

  Widget _buildToolBar(BuildContext context){
    return Column(
      children: [
        SizedBox(
            height: kToolbarHeight,
            child: Stack(
              children: [
                Center(
                  child: Row(
                    children: actionLeft ?? [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(iconBack ?? Icons.arrow_back_ios,
                          color: appColors.onBackground_9,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: titlePadding ?? const EdgeInsets.symmetric(horizontal: 50),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).popUntil((route){
                        return route.isFirst;
                      });
                    },
                    onLongPress: (){
                      if(openLogApp == 5){
                        // Navigator.of(context).push(LogAppPage.route());
                      }
                    },
                    child: Align(
                      alignment: titleAlignment ?? Alignment.center,
                        child: titleWidget ?? Text(titleText??'',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: appColors.onBackground_9
                          ),
                        )
                    ),
                  ),
                ),
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actionRight ?? [],
                    )
                )
              ],
            )
        ),
        if (underline ?? true)
          _buildLineView(),
      ],
    );
  }

  Widget _buildLineView(){
    return Container(
      height: 1,
      color: appColors.onBackground_2,
    );
  }


}
