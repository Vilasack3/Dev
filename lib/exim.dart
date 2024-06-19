import 'package:flutter/material.dart';

class EximScreen extends StatefulWidget {
  const EximScreen({super.key});

  @override
  State<EximScreen> createState() => _EximScreenState();
}

class _EximScreenState extends State<EximScreen> {
  ///Array
  List<int> numbers = [7, 2, 0, 3, 0, 2, 0];

  List<int> removeZeros(List<int> list) {
    list.removeWhere((item) => item == 0);
    return list;
  }

  List<int> sortAndMoveZerosToEnd(List<int> list) {
    // Separate non-zeros and zeros
    List<int> nonZeros = list.where((number) => number != 0).toList();
    List<int> zeros = list.where((number) => number == 0).toList();

    // Combine non-zeros followed by zeros
    return nonZeros + zeros;
  }

  ///String compression
  String str = "aabbbcddddd";

  Map<String, int> countCharacters(String s) {
    Map<String, int> charCount = {};

    for (int i = 0; i < s.length; i++) {
      String char = s[i];
      if (charCount.containsKey(char)) {
        charCount[char] = charCount[char]! + 1;
      } else {
        charCount[char] = 1;
      }
    }

    return charCount;
  }

  ///Masking number

  String str1 = "010120034312437001";
  String str2 = "2201212630005";

  // Function to format the string
  String formatString(String s) {
    if (s.length == 18) {
      // Format for strings of length 18
      String part1 = s.substring(0, 3); // "010"
      String part2 = s.substring(3, 5); // "12"
      String part3 = s.substring(5, 7); // "00"
      String part4 =
          s.substring(7, 12).replaceAll(RegExp(r'.'), 'x'); // "xxxxx"
      String part5 = s.substring(12, 15); // "437"
      String part6 = s.substring(15); // "001"
      return "$part1-$part2-$part3-$part4$part5-$part6";
    } else if (s.length == 13) {
      // Format for strings of length 13
      String part1 = s.substring(0, 3); // "220"
      String part2 = s.substring(3, 5); // "12"
      String part3 =
          s.substring(5, 10).replaceAll(RegExp(r'.'), 'x'); // "xxxxx"
      String part4 = s.substring(10); // "005"
      return "$part1-$part2-$part3$part4";
    } else {
      throw ArgumentError(
          "The input string must be either 18 or 13 characters long.");
    }
  }

  // Get the formatted strings

  @override
  Widget build(BuildContext context) {
    List<int> filteredNumbers = removeZeros(List.from(numbers));
    List<int> sortedNumbers = sortAndMoveZerosToEnd(List.from(numbers));
    Map<String, int> counts = countCharacters(str);
    String formattedString1 = formatString(str1);
    String formattedString2 = formatString(str2);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Array
            Wrap(
              spacing: 8.0, // Space between each item
              runSpacing: 4.0, // Space between each row
              children: filteredNumbers.map((number) {
                return Chip(
                  label: Text(number.toString()),
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8.0, // Space between each item
              runSpacing: 4.0, // Space between each row
              children: sortedNumbers.map((number) {
                return Chip(
                  label: Text(number.toString()),
                );
              }).toList(),
            ),

            ///String compression
            Text("a: ${counts['a'] ?? 0}"),
            Text("b: ${counts['b'] ?? 0}"),
            Text("c: ${counts['c'] ?? 0}"),
            Text("d: ${counts['d'] ?? 0}"),

            ///Masking digits
            Text(formattedString1),
            Text(formattedString2),
          ],
        ),
      ),
    );
  }
}
