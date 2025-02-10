import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/user_entity.dart';
import 'base/base_widget.dart';
import 'dialog/add_user_form.dart';

class AccountTile extends StatefulWidget {
  UserEntity user;
  bool isCurrent;
  Function(String) onDeleted;
  Function(String) onEditAccount;
  Function(String) onSwitchAccount;
  AccountTile(
      {super.key,
      required this.user,
      required this.onSwitchAccount,
      required this.onDeleted,
      required this.onEditAccount,
      this.isCurrent = false});

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends BaseState<AccountTile> {
  double dx = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          dx = details.primaryDelta! + dx;
          if (dx < Constants.offsetShowIconDeleted) {
            dx = Constants.offsetShowIconDeleted;
          }
          if (dx > 0) {
            dx = 0;
          }
        });
      },
      onHorizontalDragEnd: (_) {
        if (dx > Constants.offsetShowIconDeleted) {
          setState(() => dx = 0);
        }
      },
      onTap: () async {
        if (!widget.isCurrent) {
          widget.onSwitchAccount(widget.user.id!);
        } else {
          final value = await showDialog(
            context: context,
            builder: (_) => AddUserForm(
              userName: widget.user.userName,
            ),
          );
          if (StringUtils.isNotNullOrEmpty(value)) {
            widget.onEditAccount(value);
          }
        }
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          if (!widget.isCurrent)
            Visibility(
              visible: dx <= Constants.offsetShowIconDeleted,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 180),
                child: IconButton(
                  style: OutlinedButton.styleFrom(
                    iconSize: 18,
                    backgroundColor: Colors.red,
                  ),
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      dx = 0;
                    });
                    widget.onDeleted(widget.user.id!);
                  },
                ),
              ),
            ),
          AnimatedContainer(
            duration: Duration(milliseconds: 180),
            transform: Matrix4.translationValues(dx, 0, 0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                widget.user.userName!,
                style: theme.textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
              trailing: widget.isCurrent ? const Icon(Icons.check, color: Colors.white) : null,
            ),
          ),
        ],
      ),
    );
  }
}
