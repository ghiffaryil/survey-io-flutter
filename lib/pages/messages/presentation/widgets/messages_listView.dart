import 'package:flutter/material.dart';
import 'package:survey_io/common/extension/helper/date_helper.dart';
import 'package:survey_io/pages/messages/data/list_messages.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';
import '../../models/messages_model.dart';
import 'messages_card.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<MessagesModel> messages = ListMessage.getMessage();

  void markReadMessage(int messageId) {
    setState(() {
      for (var dataMessage in messages) {
        if (dataMessage.id == messageId) {
          dataMessage.status = 'read';
        }
      }
    });
  }

  void markClickedMessage(int messageId) {
    setState(() {
      for (var dataMessage in messages) {
        if (dataMessage.id == messageId) {
          dataMessage.clicked = true;
        }
      }
    });
  }

  Widget dismissibleMessages(int index) {
    final dataMessage = messages[index];
    final messageId = dataMessage.id;

    return Dismissible(
      onDismissed: (DismissDirection direction) {
        setState(() {
          markReadMessage(messageId);
        });
        messages.removeAt(index);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: AppColors.info,
        child: Image.asset(
          IconName.trash,
          width: 25,
        ),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      child: InkWell(
        onTap: () {
          markClickedMessage(messageId);
        },
        child: MessagesCard(
          messages: dataMessage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return dismissibleMessages(index);
      },
    );
  }
}
