import 'package:flutter/material.dart';

class DefaultHomeTile extends StatefulWidget {
  const DefaultHomeTile({
    super.key,
    required this.title,
    required this.onTab,
  });

  final String title;
  final void Function() onTab;

  @override
  State<DefaultHomeTile> createState() => _DefaultHomeTileState();
}

class _DefaultHomeTileState extends State<DefaultHomeTile> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        isHover = true;
      }),
      onExit: (event) => setState(() {
        isHover = false;
      }),
      child: GestureDetector(
        onTap: widget.onTab,
        child: AnimatedContainer(
          duration: Durations.extralong1,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: isHover ? 5 : 2,
            ),
            gradient: LinearGradient(
              begin: isHover ? Alignment.bottomRight : Alignment.topLeft,
              end: isHover ? Alignment.topLeft : Alignment.bottomRight,
              colors: [
                Colors.red.shade300,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 24),
              const Spacer(),
              AnimatedDefaultTextStyle(
                duration: Durations.extralong1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isHover ? Colors.amber : Colors.black,
                ),
                child: Text(
                  widget.title,
                ),
              ),
              const Spacer(),
              const Icon(Icons.catching_pokemon)
            ],
          ),
        ),
      ),
    );
  }
}
