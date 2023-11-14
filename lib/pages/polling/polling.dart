// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/polling/polling_done/polling_done_bloc.dart';
import 'package:survey_io/pages/home/home.dart';

import '../../bloc/polling/polling/polling_bloc.dart';
import '../../common/constants/styles.dart';
import '../../common/constants/colors.dart';
import '../../common/components/label.dart';
import '../../common/components/appbar_plain.dart';
import 'widgets/tab_polling_done.dart';
import 'widgets/tab_polling_new.dart';

class PollingPage extends StatefulWidget {
  const PollingPage({super.key});

  @override
  State<PollingPage> createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
  @override
  initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    context.read<PollingBloc>().add(const PollingEvent.getPolling());
    context
        .read<PollingDoneBloc>()
        .add(const PollingDoneEvent.getPollingDone());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: LabelInput(
                    labelText: 'Polling',
                    labelStyle:
                        TextStyles.h2ExtraBold(color: AppColors.secondary)),
              ),
            ),
            Container(
              height: 10,
              color: Colors.white,
            ),
            Expanded(
              // height: MediaQuery.of(context).size.height,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: TabBar(
                        unselectedLabelColor: AppColors.light.withOpacity(0.5),
                        labelColor: AppColors.primary,
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'Polling Baru',
                              style: TextStyles.medium(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Selesai',
                              style: TextStyles.medium(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          TabNewPolling(),
                          TabPollingDone(),
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
    );
  }
}
