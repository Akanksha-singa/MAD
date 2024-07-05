import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFF000000),
        body: SizedBox(
          width: 360,
          child: Column(
            children: [
              _buildMainContent(context),
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Recent Transfers",
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 14,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildRecentTransfers(context),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 264,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 48,
                            right: 40,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/img_group.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 74),
                                    Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.only(
                                        left: 34,
                                        right: 36,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 14),
                                            child: Text(
                                              "25%",
                                              style: TextStyle(
                                                color: Color(0XFFFFFFFF),
                                                fontSize: 10.626542091369629,
                                                fontFamily: 'Antonio',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 12),
                                                  child: Text(
                                                    "50%",
                                                    style: TextStyle(
                                                      color: Color(0XFFFFFFFF),
                                                      fontSize:
                                                          10.626542091369629,
                                                      fontFamily: 'Antonio',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 4),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "YOUR",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF54658E),
                                                          fontSize:
                                                              14.670745849609375,
                                                          fontFamily: 'Antonio',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      Text(
                                                        "EXPENSES",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF54658E),
                                                          fontSize:
                                                              14.670745849609375,
                                                          fontFamily: 'Antonio',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "5%",
                                                  style: TextStyle(
                                                    color: Color(0XFFFFFFFF),
                                                    fontSize:
                                                        10.626542091369629,
                                                    fontFamily: 'Antonio',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          Padding(
                                            padding: EdgeInsets.only(right: 30),
                                            child: Text(
                                              "20%",
                                              style: TextStyle(
                                                color: Color(0XFFFFFFFF),
                                                fontSize: 10.626542091369629,
                                                fontFamily: 'Antonio',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 42),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "EDUCATION",
                                                  style: TextStyle(
                                                    color: Color(0XFFFFFFFF),
                                                    fontSize:
                                                        11.746837615966797,
                                                    fontFamily: 'Antonio',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Container(
                                                  height: 4,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment(0.01, 0.5),
                                                      end: Alignment(0.99, 0.5),
                                                      colors: [
                                                        Color(0XFFFFE100),
                                                        Color(0XFFFFA82A),
                                                        Color(0XFFFF4276)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "ENTERTAINMENT",
                                                  style: TextStyle(
                                                    color: Color(0XFFFFFFFF),
                                                    fontSize:
                                                        11.746837615966797,
                                                    fontFamily: 'Antonio',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: double.maxFinite,
                                                  child: Divider(
                                                    height: 4,
                                                    thickness: 4,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  " INVESTMENTS",
                                                  style: TextStyle(
                                                    color: Color(0XFFFFFFFF),
                                                    fontSize:
                                                        11.746837615966797,
                                                    fontFamily: 'Antonio',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Container(
                                                  height: 4,
                                                  width: 48,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment(0.01, 0.5),
                                                      end: Alignment(0.99, 0.5),
                                                      colors: [
                                                        Color(0XFFFFE611),
                                                        Color(0XFF00A700)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "HOUSEHOLD BILLS",
                                        style: TextStyle(
                                          color: Color(0XFFFFFFFF),
                                          fontSize: 11.746837615966797,
                                          fontFamily: 'Antonio',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 66,
                                        child: Divider(
                                          height: 4,
                                          thickness: 4,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: SizedBox(
                        height: 74,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/images/img_ellipse_1.svg",
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildMainContent(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Color(0XFFFF4D4D),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            elevation: 0,
            toolbarHeight: 38,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leadingWidth: 67,
            leading: Padding(
              padding: EdgeInsets.only(left: 13),
              child: Image.asset(
                "assets/images/img_group_498.png",
                height: 38,
                width: 54,
              ),
            ),
            title: Column(
              children: [
                Text(
                  "Home",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: EdgeInsets.only(right: 22),
                  child: Text(
                    "REX",
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 8,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  top: 7,
                  right: 23,
                  bottom: 7,
                ),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    "assets/images/img_vector.svg",
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                16,
              ),
              gradient: LinearGradient(
                begin: Alignment(0.91, -0.13),
                end: Alignment(0.5, 1),
                colors: [Color(0XFFFF4D4D), Color(0XFFE77676)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "₹14,235",
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 36,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ".34",
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 18,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4),
                Text(
                  "Main balance",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 12,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Padding(
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: SvgPicture.asset(
                                "assets/images/img_upload_line.svg",
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Top up",
                            style: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 12,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Color(0XFF992E2E),
                      ),
                      Column(
                        children: [
                          Padding(
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: SvgPicture.asset(
                                "assets/images/img_download_line.svg",
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Withdraw",
                            style: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 12,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Color(0XFF992E2E),
                      ),
                      Column(
                        children: [
                          Padding(
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: SvgPicture.asset(
                                "assets/images/img_exchange_funds_line.svg",
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Transfer",
                            style: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 12,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentTransfers(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return RecenttransfersItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFF4D4D),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 22,
              width: 22,
              child: SvgPicture.asset(
                "assets/images/img_budgeting_1.svg",
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 16,
              width: 12,
              child: SvgPicture.asset(
                "assets/images/img_vector_16x12.svg",
              ),
            ),
            label: '',
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class RecenttransfersItemWidget extends StatelessWidget {
  const RecenttransfersItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {},
          constraints: BoxConstraints(
            minHeight: 348,
            minWidth: 348,
          ),
          padding: EdgeInsets.all(0),
          icon: Container(
            width: 348,
            height: 64,
            padding: EdgeInsets.all(20),
            child: SvgPicture.asset(
              "assets/images/img_add_line.svg",
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            "Add",
            style: TextStyle(
              color: Color(0XFFFFFFFF),
              fontSize: 12,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
