// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/reedem/reedem_gift_card.dart';

import '../../../common/constants/styles.dart';
import '../../../datasources/polling/polling_participate_datasource.dart';

class PollingParticipateModal extends StatelessWidget {
  final int selectedItemId;
  final String selectedItemLabel;
  final Function(String) onSelectedValueChange;

  const PollingParticipateModal({
    super.key,
    required this.selectedItemId,
    required this.selectedItemLabel,
    required this.onSelectedValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            onPressed: () {
              onSelectedValueChange('');
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
              color: AppColors.secondary,
            )),
      ),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Pilihan tidak dapat diubah ketika anda menekan tombol',
                style: TextStyles.extraLarge(color: AppColors.secondary)),
            TextSpan(
              text: ' Submit ',
              style: TextStyles.extraLarge(color: AppColors.primary),
            ),
            TextSpan(
                text: ', anda yakin tetap ingin memilih',
                style: TextStyles.extraLarge(color: AppColors.secondary)),
            TextSpan(
              text: ' "$selectedItemLabel"',
              style: TextStyles.extraLarge(color: AppColors.primary),
            ),
            TextSpan(
                text: '?',
                style: TextStyles.extraLarge(color: AppColors.secondary)),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: CustomPadding.p2,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ButtonOutlined.secondary(
                  text: 'Batal',
                  height: 40,
                  onPressed: () {
                    onSelectedValueChange('');
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 5,
                child: ButtonFilled.primary(
                  text: 'Submit',
                  height: 40,
                  onPressed: () async {
                    final datasource = PollingParticipateDatasource();
                    final result =
                        await datasource.setPollingParticipate(selectedItemId);

                    if (result.isRight()) {
                      onSelectedValueChange(selectedItemLabel);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReedemGiftCard()));
                    } else {
                      final error = result.fold((l) => l, (r) => '');
                      print('Error: $error');
                      onSelectedValueChange('');
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
