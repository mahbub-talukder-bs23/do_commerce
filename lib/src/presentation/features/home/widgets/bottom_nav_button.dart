part of '../pages/home_page.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.text,
    required this.icon,
    required this.index,
    required this.selectedIndex,
  });

  final String text;
  final IconData icon;
  final int index;
  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        final color = (value == index)
            ? Theme.of(context).colorScheme.primary
            : Colors.grey;
        return TextButton(
          onPressed: () {
            selectedIndex.value = index;
          },
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(color),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          child: Column(children: [Icon(icon), Text(text)]),
        );
      },
    );
  }
}
