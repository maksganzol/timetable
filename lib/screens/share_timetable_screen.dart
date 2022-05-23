import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareTimetableScreen extends StatelessWidget {
  const ShareTimetableScreen({
    Key? key,
    required this.timetableIdentificator,
    required this.timetableTitle,
    required this.timetableColor,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required String timetableIdentificator,
    required String timetableTitle,
    required Color timetableColor,
  }) =>
      CupertinoScaffold.showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => ShareTimetableScreen(
          timetableTitle: timetableTitle,
          timetableIdentificator: timetableIdentificator,
          timetableColor: timetableColor,
        ),
      );

  final String timetableIdentificator;
  final String timetableTitle;
  final Color timetableColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: const Text('Поделитесь расписанием'),
        backgroundColor: timetableColor.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timetableTitle,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            QrImage(
              data: timetableIdentificator,
              version: QrVersions.auto,
              size: 300.0,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(text: timetableIdentificator),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Идентификатор скопирован в буфер обмена'),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedBorder(
                    color: CupertinoColors.systemGrey,
                    strokeWidth: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        timetableIdentificator,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.copy),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
