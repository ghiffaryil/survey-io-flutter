import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/constants/colors.dart';

class ShimmerCardMain extends StatelessWidget {
  const ShimmerCardMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.light.withOpacity(0.3),
      highlightColor: AppColors.light.withOpacity(0.2),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.light.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.light.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.light.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class ShimmerIcon extends StatelessWidget {
  const ShimmerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerProfileFloat extends StatelessWidget {
  const ShimmerProfileFloat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Shimmer.fromColors(
                baseColor: AppColors.light.withOpacity(0.3),
                highlightColor: AppColors.light.withOpacity(0.2),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.light.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.light.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.light.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.light.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.light.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.light.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ShimmerProfileUser extends StatelessWidget {
  const ShimmerProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.light.withOpacity(0.3),
      highlightColor: AppColors.light.withOpacity(0.2),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.light.withOpacity(0.3),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.15),
      ]),
    );
  }
}

class ShimmerSurveyDesign extends StatelessWidget {
  const ShimmerSurveyDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.light.withOpacity(0.3),
      highlightColor: AppColors.light.withOpacity(0.2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.light.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ]),
          const Divider(),
          CustomDividers.verySmallDivider(),
          SizedBox(
            width: double.infinity,
            child: Row(children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class ShimmerInvite extends StatelessWidget {
  const ShimmerInvite({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomDividers.regularDivider(),
            Container(
              height: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)),
            ),
            CustomDividers.extraLargeDivider(),
            CustomDividers.smallDivider(),
            Container(
              height: 40,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)),
            ),
            CustomDividers.smallDivider(),
            Container(
              height: 40,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)),
            ),
            CustomDividers.smallDivider(),
            Container(
              height: 40,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)),
            ),
            CustomDividers.regularDivider(),
            Container(
              height: 40,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)),
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerNotification extends StatelessWidget {
  const ShimmerNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(0)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(0)),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerReedem extends StatelessWidget {
  const ShimmerReedem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.light.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ShimmerPolling extends StatelessWidget {
  final String tab;

  const ShimmerPolling({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 20,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 20,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 20,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 15,
            ),
            tab == 'New'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.light.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.light.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.light.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerListSurvey extends StatelessWidget {
  const ShimmerListSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 10,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.light.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerProfileMenu extends StatelessWidget {
  const ShimmerProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.light.withOpacity(0.3),
        highlightColor: AppColors.light.withOpacity(0.2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.light.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
