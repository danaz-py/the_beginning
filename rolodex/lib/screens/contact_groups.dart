import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';
import 'package:rolodex/data/contact.dart';
import 'contacts.dart';

class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: 0,
      onListSelected: (list) => Navigator.of(context).push( //retrives nearest navigator widget from widget tree
      //the push adds a new route to the navigator's stack and displays the widget returned from builder property
      //stack based navigation
        CupertinoPageRoute<void>( //crreates ios style page transiitons
          title: list.title,
          builder: (context) => ContactListsPage(listId: list.id),
        ),
      ),
    );
  }
}


class _ContactGroupsView extends StatelessWidget {
  const _ContactGroupsView({
    required this.selectedListId,
    required this.onListSelected
  });

  final int selectedListId;
  final void Function(ContactGroup) onListSelected;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [ //scrollable list of items
          const CupertinoSliverNavigationBar( //pinionated navigation bar that collapses as the page scrolls.
            largeTitle: Text('Contact Groups')),
          SliverFillRemaining( //sliver tha takes up the remaining space in the scroll view and fills it with a single child widget.
            child: ValueListenableBuilder<List<ContactGroup>>(
              valueListenable: contactGroupsModel.listsNotifier,
              builder: (context, contactLists, child) {
                const groupIcon = Icon(CupertinoIcons.group, weight: 900, size: 32);
                const pairIcon = Icon(CupertinoIcons.person_2, weight: 900, size: 24);
                return CupertinoListSection.insetGrouped(
                  header: const Text('iPhone'),
                  children: [
                    for (final ContactGroup contactList in contactLists)
                      CupertinoListTile(
                        title: Text(contactList.label),
                        onTap: () => onListSelected(contactList),
                        leading: contactList.id == 0 ? groupIcon : pairIcon,
                        trailing: _buildTrailing(contactList.contacts, context),
                      )
                  ]
                );
              }
            )
          )
        ]
      )
    );
  }

  Widget _buildTrailing(List<Contact> contacts, BuildContext context) {
    final TextStyle style = CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: CupertinoColors.systemGrey);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${contacts.length}', style: style),
        const SizedBox(width: 8),
        const Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey, size: 18)
      ]
    );
  }
}

/// A sidebar component for selecting contact groups on large screens.
/// reuses _ContactGroupsView and provides a diff callback
class ContactGroupsSidebar extends StatelessWidget {
  const ContactGroupsSidebar({
    super.key,
    required this.selectedListId,
    required this.onListSelected,
  });

  final int selectedListId;
  final void Function(int) onListSelected;

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: selectedListId,
      onListSelected: (list) => onListSelected(list.id),
    );
  }
}
