import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

Widget renderTextAndLaTeX(String inputString) {
  // Create a list of widgets from the input string
  List<Widget> widgets = [];

  // Regular expression to find LaTeX parts in the string
  RegExp regex = RegExp(r'\$.*?\$');

  // Starting position for the next search
  int start = 0;

  // Find and extract LaTeX parts from the string
  Iterable<Match> matches = regex.allMatches(inputString);
  for (Match match in matches) {
    // Add regular text part from the position before the LaTeX part
    String textPart = inputString.substring(start, match.start);
    if (textPart.isNotEmpty) {
      widgets.add(Text(
        textPart,
        style: TextStyle(fontSize: 16), // Ensure consistent text size
      ));
    }

    // Extract and process the LaTeX part
    String latexPart = match.group(0)!;
    latexPart = latexPart.replaceAll(r'$', ''); // Remove the $$

    // Add the LaTeX part to the list of widgets
    widgets.add(
      Container(
        constraints: BoxConstraints(maxWidth: double.infinity),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            latexPart,
            textStyle:
                const TextStyle(fontSize: 16), // Adjust the font size if needed
          ),
        ),
      ),
    );

    // Update the starting position for the next search
    start = match.end;
  }

  // Add the last regular text part (if any)
  String lastTextPart = inputString.substring(start);
  if (lastTextPart.isNotEmpty) {
    widgets.add(Text(
      lastTextPart,
      style: TextStyle(fontSize: 16), // Ensure consistent text size
    ));
  }

  // Use Wrap to avoid the Column's new line issue and to render inline
  return SingleChildScrollView(
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widgets,
    ),
  );
}
