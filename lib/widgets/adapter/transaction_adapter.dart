import 'package:flutter/material.dart';
import 'package:myfirebase/widgets/item/item_transaction.dart';

class TransactionAdapter extends StatelessWidget {
  const TransactionAdapter({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ItemTransaction(
          iconLeading: Icons.login_sharp,
          textTitle: 'Transaction 1',
          textSubtitle: 'Rp. 100.000',
        ),
        ItemTransaction(
          iconLeading: Icons.login_sharp,
          textTitle: 'Transaction 2',
          textSubtitle: 'Rp. 50.000',
        ),
      ],
    );
  }
}
