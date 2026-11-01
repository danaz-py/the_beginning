import 'package:flutter/cupertino.dart';
import 'contact_groups.dart';
import 'contacts.dart';
//this is adapting to the screen sizes

const largeScreenMinWidth = 600.0;


class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int selectedListId = 0; //tracks currently selected contact group

  //updates the value when a new contact group is selected
  void _onContactListSelected(int listId) {
    setState(() {
      selectedListId = listId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( //provides info abt parent size constaints
      builder: (context, constraints) {
        //in builder callback u recieve boxconstraints object
        //tells you the max available width and height
        final isLargeScreen = constraints.maxWidth >= largeScreenMinWidth;
        if (isLargeScreen) {
          return _buildLargeScreenLayout();
        } else {
          return const ContactGroupsPage(); //displays contact groups page for smaller screens
        }
      },
    );
  }

  //also what u can have several widget within now??

  //creates classic menu detial layout for larger screens
Widget _buildLargeScreenLayout() {
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.extraLightBackgroundGray,
    child: SafeArea(
      child: Row(
        children: [
          SizedBox(
            width: 320,
            child: ContactGroupsSidebar(
              selectedListId: selectedListId,
              onListSelected: _onContactListSelected,
            ),
          ),
          Container(width: 1, color: CupertinoColors.separator),
          Expanded(child: ContactListDetail(listId: selectedListId)),
        ],
      ),
    ),
  );
}
}


