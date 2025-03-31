import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final Function(String userId, String userName) onEditAccount;
  final Function(String userId) onSwitchAccount;
  final Function(String userId) onDeletedAccount;
  final Function(String)? changeLanguage;
  
  const SideMenu(
    this.user, {
    super.key,
    required this.onAddAccount,
    required this.onEditAccount,
    required this.onSwitchAccount,
    required this.onDeletedAccount,
    required this.users,
    this.changeLanguage,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends BaseState<SideMenu> {
  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình để thiết kế responsive
    final screenSize = MediaQuery.of(context).size;
    final maxWidth = screenSize.width * 0.85; // Giới hạn width tối đa 85% màn hình
    final menuWidth = maxWidth < 288.0 ? maxWidth : 288.0;
    
    return Scaffold(
      body: Container(
        width: menuWidth,
        height: double.infinity,
        color: AppColors.menuBackgroundColor,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          localizations.appTitle,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (widget.changeLanguage != null)
                      _buildLanguageIcon(),
                  ],
                ),
                SizedBox(height: 24),
                AccountTile(
                  user: widget.user,
                  isCurrent: true,
                  onEditAccount: widget.onEditAccount,
                  onSwitchAccount: widget.onSwitchAccount,
                  onDeleted: (_) {},
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(color: Colors.white24, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
                  child: Text(
                    localizations.otherAccounts,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _buildAccountList(),
                _buildAddAccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageIcon() {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => _showLanguageSelector(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.language,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    final currentLocale = Localizations.localeOf(context).languageCode;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            localizations.selectLanguage,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('Tiếng Việt', 'vi', currentLocale == 'vi'),
              SizedBox(height: 8),
              _buildLanguageOption('English', 'en', currentLocale == 'en'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String languageName, String languageCode, bool isSelected) {
    return Material(
      color: isSelected ? Colors.blue.shade50 : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (widget.changeLanguage != null) {
            widget.changeLanguage!(languageCode);
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  languageName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blue.shade700 : Colors.black87,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Colors.blue.shade700,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountList() {
    final otherUsers = widget.users
        .where((account) => account.userName != widget.user.userName)
        .toList();
        
    return Flexible(
      child: otherUsers.isEmpty
          ? Center(
              child: Text(
                localizations.noOtherAccounts,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white60),
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: otherUsers
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
}
