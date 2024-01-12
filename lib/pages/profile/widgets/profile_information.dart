import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  bool isLogged = true;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return Container();
            }, loading: () {
              return const ShimmerProfileUser();
            }, error: (message) {
              return Row(children: [
                Image.asset(
                  IconName.account,
                  width: 45,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '-',
                        style: TextStyles.extraLarge(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '-',
                        style: TextStyles.regular(color: AppColors.secondary),
                      )
                    ],
                  ),
                ),
              ]);
            }, loaded: (data) {
              String userName = data.user.name;

              List<String> nameParts = userName.split(" ");

              String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
              String secondName = nameParts.length > 1 ? nameParts[1] : "";
              String thirdName = nameParts.length > 2
                  ? nameParts.sublist(2).map((e) => e[0]).join("")
                  : "";

              return Row(
                children: [
                  Image.asset(
                    IconName.account,
                    width: 45,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$firstName $secondName $thirdName',
                          style: TextStyles.extraLarge(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.user.phoneNumber,
                          style: TextStyles.regular(color: AppColors.secondary),
                        )
                      ],
                    ),
                  ),
                  data.user.emailVerified > 0
                      ? Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5),
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Verified',
                                    style: TextStyles.h5(color: Colors.white),
                                  ),
                                  Image.asset(IconName.iconCheck)
                                ],
                              )),
                            ),
                          ),
                        )
                      : Container(),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
