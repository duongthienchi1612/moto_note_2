import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/user_entity.dart';
import '../theme/app_colors.dart';
import 'account_tile.dart';
import 'base/base_widget.dart';
import 'dialog/add_user_form.dart';

class SideMenu extends StatefulWidget {
  final UserEntity user;
  final List<UserEntity> users;
  final Function(String userName) onAddAccount;
  final Function(String userName) onEditAccount;
  final Function(String userId) onSwitchAccount;
  final Function(String userId) onDeletedAccount;
  const SideMenu(
    this.user, {
    super.key,
    required this.onAddAccount,
    required this.onEditAccount,
    required this.onSwitchAccount,
    required this.onDeletedAccount,
    required this.users,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends BaseState<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: AppColors.menuBackgroundColor,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Stack(
              children: [
                Column(
                  children: [
                    AccountTile(
                      user: widget.user,
                      isCurrent: true,
                      onEditAccount: widget.onEditAccount,
                      onSwitchAccount: widget.onSwitchAccount,
                      onDeleted: (_) {},
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildAccountList(),
                    const SizedBox(height: 16),
                    _buildAddAccountButton(),
                    const SizedBox(height: 16),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: _buildBuyMeACoffeeButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountList() {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: widget.users
            .where((account) => account.userName != widget.user.userName)
            .map(
              (account) => AccountTile(
                user: account,
                onEditAccount: widget.onEditAccount,
                onSwitchAccount: widget.onSwitchAccount,
                onDeleted: widget.onDeletedAccount,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildAddAccountButton() {
    return GestureDetector(
      onTap: () async {
        final value = await showDialog(
          context: context,
          builder: (_) => AddUserForm(userName: '', isAddNew: true),
        );
        if (StringUtils.isNotNullOrEmpty(value)) {
          widget.onAddAccount(value);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            localizations.addAnotherAccount,
            style: theme.textTheme.labelLarge!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyMeACoffeeButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buyMeACoffeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 1,
      ),
      icon: Icon(Icons.coffee, size: 24),
      label: Text(
        localizations.buyMeACoffee,
        style: theme.textTheme.labelLarge,
      ),
    );
  }
}
