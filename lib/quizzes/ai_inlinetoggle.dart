import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedInlineInfo());
}

class AnimatedInlineInfo extends StatefulWidget {
  const AnimatedInlineInfo({super.key});

  @override
  State<AnimatedInlineInfo> createState() => _AnimatedInlineInfoState();
}

class _AnimatedInlineInfoState extends State<AnimatedInlineInfo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The trigger button
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          icon: Icon(_isExpanded ? Icons.close : Icons.info_outline),
          label: Text(_isExpanded ? 'Hide Info' : 'Show Info'),
        ),
        
        // Animated expansion container
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline, 
                  size: 20, 
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'This box smoothly slides open and expands directly in the page flow.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          crossFadeState: _isExpanded 
              ? CrossFadeState.showSecond 
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}