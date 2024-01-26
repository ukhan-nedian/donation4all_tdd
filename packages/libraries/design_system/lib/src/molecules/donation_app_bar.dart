import 'package:design_system/src/atoms/size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DonationAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DonationAppBar({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height(context, 0.15),
      // padding: EdgeInsets.all(SizeConfig.width(context, 0.01)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context, 0.05),
            ),
            child: Row(
              // padding: EdgeInsets.only(left: SizeConfig.width(context, 0.16)),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (scaffoldKey != null)
                    ? InkWell(
                        onTap: () {
                          LogManager.info('drawer clicked');
                          scaffoldKey?.currentState?.openDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            SizeConfig.width(context, 0.02),
                          ),
                          child: Image.asset('assets/icons/drawer_icon.png'),
                        ),
                      )
                    : InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                // Image.asset('assets/images/donation_logo.png'),
                Image.asset(
                  'assets/images/donation4all_logo.png',
                  width: SizeConfig.width(context, 0.4),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.width(context, 0.02)),
                    child: Image.asset('assets/icons/drawer_icon.png'),
                  ),
                ),
                // SizedBox(width: SizeConfig.width(context, 0.05)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
