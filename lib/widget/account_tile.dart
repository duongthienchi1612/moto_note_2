import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/user_entity.dart';
import '../theme/app_colors.dart';
import 'base/base_widget.dart';
import 'dialog/add_user_form.dart';

class AccountTile extends StatefulWidget {
  final UserEntity user;
  final bool isCurrent;
  final Function(String userId) onDeleted;
  final Function(String userId) onSwitchAccount;
  final Function(String userId, String userName) onEditAccount;

  const AccountTile({
    super.key,
    required this.user,
    this.isCurrent = false,
    required this.onDeleted,
    required this.onSwitchAccount,
    required this.onEditAccount,
  });

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends BaseState<AccountTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        color: widget.isCurrent ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: widget.isCurrent ? null : () => widget.onSwitchAccount(widget.user.id!),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.waveColorMedium,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.isCurrent ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.user.userName != null && widget.user.userName!.isNotEmpty
                          ? widget.user.userName![0].toUpperCase()
                          : 'A',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.userName ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (widget.isCurrent)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              localizations.current,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (!widget.isCurrent)
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.white),
                    onPressed: () => _showDeleteConfirmation(),
                  ),
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: Colors.white),
                  onPressed: () => _onEdit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          localizations.deleteAccount,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          '${localizations.deleteAccountConfirmation} "${widget.user.userName}"?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              localizations.cancel,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDeleted(widget.user.id!);
            },
            child: Text(
              localizations.delete,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onEdit() async {
    final value = await showDialog(
      context: context,
      builder: (_) => AddUserForm(userName: widget.user.userName ?? ''),
    );
    if (value != null) {
      widget.onEditAccount(widget.user.id!, value);
    }
  }
}
