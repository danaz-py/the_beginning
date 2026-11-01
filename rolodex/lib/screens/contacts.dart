import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/data/contact.dart';

class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListsView(listId: listId);
  }
}

class _ContactListsView extends StatelessWidget {
  const _ContactListsView({
    required this.listId,
    this.automaticallyImplyLeading = true,
  });

  final int listId;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: ContactGroupsModel().listsNotifier,
        builder: (context, contactLists, child) {
          final contactList = ContactGroupsModel().findContactList(listId);
          final contacts  = contactList.alphabetizedContacts;

          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                automaticallyImplyLeading: automaticallyImplyLeading,
                largeTitle: Text(contactList.label),
              ),
              SliverList.list(
                //provide a list of widgets that become part of the scrollable content
                children: [
                  const SizedBox(height: 20),
                  ...contacts.keys.map(
                    (initial) => ContactListSection(
                      lastInitial: initial,
                      contacts: contacts[initial]!,
                    ),
                  ),
                ],
              ),
            ]
          );
        }
      ),
    );
}
}

//reorganize contacts alphabetically by last name and group them by the first letter of the last name.
class ContactListSection extends StatelessWidget {
  const ContactListSection({
    super.key,
    required this.lastInitial,
    required this.contacts,
  });

  final String lastInitial;
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              lastInitial,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CupertinoListSection(
            backgroundColor: CupertinoColors.systemBackground,
            dividerMargin: 0,
            additionalDividerMargin: 0,
            topMargin: 4,
            children: [
              for (final Contact contact in contacts)
                CupertinoListTile(
                  padding: const EdgeInsets.all(0),
                  title: Text('${contact.firstName} ${contact.lastName}'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


// reuses _ContactListView and sets the automaticallyImplyLeading parameter to false 
//to hide the back button, as navigation is handled by the sidebar.
class ContactListDetail extends StatelessWidget {
  const ContactListDetail({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListsView(listId: listId, automaticallyImplyLeading: false);
  }
}
