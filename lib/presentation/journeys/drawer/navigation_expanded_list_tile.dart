import 'package:flutter/material.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String? title;
  final Function(int i) onPressed;
  final List<String> children;
  const NavigationExpandedListItem(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.7),
          blurRadius: 2,
        )
      ]),
      child: ExpansionTile(
        title: Text(
          title!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          for (int i = 0; i < children.length; i++)
            NavigationSubListItem(title: children[i], onPressed: () => onPressed(i))
        ],
      ),
    );
  }
}
