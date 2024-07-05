import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransferToTwoScreen extends StatelessWidget {
  const TransferToTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFF000000),
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 18,
          ),
          child: Column(
            children: [
              Text(
                "Transfer to",
                style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 24,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 58),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 52),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        36,
                      ),
                      child: Image.asset(
                        "assets/images/img_profile_photo.png",
                        height: 72,
                        width: 72,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ajay N M",
                            style: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 16,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "+91 7892817647",
                            style: TextStyle(
                              color: Color(0XFF78838D),
                              fontSize: 14,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 56),
              Text(
                "Enter Amount",
                style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 12,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "\$1,252.00",
                style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 36,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.maxFinite,
                child: Divider(
                  height: 2,
                  thickness: 2,
                  color: Color(0XFFFF4D4D),
                  indent: 52,
                  endIndent: 52,
                ),
              ),
              Spacer(),
              _buildSecurePaymentSection(context),
              SizedBox(height: 22)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 58,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leadingWidth: 66,
      leading: Padding(
        padding: EdgeInsets.only(
          left: 8,
          top: 18,
          bottom: 18,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                "assets/images/img_arrow_left.svg",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 2,
                bottom: 1,
              ),
              child: Text(
                "Back",
                style: TextStyle(
                  color: Color(0XFFFF4D4D),
                  fontSize: 14,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSecurePaymentSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFFF4D4D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                  ),
                  visualDensity: const VisualDensity(
                    vertical: -4,
                    horizontal: -4,
                  ),
                  padding: EdgeInsets.only(
                    top: 12,
                    right: 4,
                    bottom: 12,
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      child: SvgPicture.asset(
                        "assets/images/img_securepaymentline.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Text(
                      "Secure payment",
                      style: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 14,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFFF4D4D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                  ),
                  visualDensity: const VisualDensity(
                    vertical: -4,
                    horizontal: -4,
                  ),
                  padding: EdgeInsets.only(
                    top: 12,
                    right: 4,
                    bottom: 12,
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      child: SvgPicture.asset(
                        "assets/images/img_securepaymentline.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Text(
                      "Secure payment",
                      style: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 14,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
