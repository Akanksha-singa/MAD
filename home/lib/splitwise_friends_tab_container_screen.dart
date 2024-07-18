import 'package:flutter/material.dart';
import 'splitwise_friends_page.dart';
import 'splitwise_groups_page.dart';

class SplitwiseFriendsTabContainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Split Wise'),
          actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
        ),
        body: Column(
          children: [
            _buildBalanceCard(),
            TabBar(
              tabs: [Tab(text: 'FRIENDS'), Tab(text: 'GROUPS')],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SplitwiseFriendsPage(),
                  SplitwiseGroupsPage(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // Implement adding new friend logic here
          },
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    // Implement the balance card widget here
    return Container(
      // Add your balance card implementation
    );
  }
}