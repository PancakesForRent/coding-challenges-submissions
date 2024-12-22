import 'package:args/args.dart';
import 'dart:io';

void main(List<String> arguments) async {
  //DONE:Create parser to read command line arguments
  //DONE:Read the argument and process it as a file object
  exitCode = 0;
  final argParser = ArgParser()
    ..addFlag('bytes', negatable: false, abbr: 'c')
    ..addFlag('lines', negatable: false, abbr: 'l')
    ..addFlag('words', negatable: false, abbr: 'w')
    ..addFlag('characters', negatable: false, abbr: 'm')
    ..addFlag('help', negatable: false, abbr: 'h');

  ArgResults argResults = argParser.parse(arguments);
  if (argResults.rest.isEmpty && argResults['help']) {
    returnDocs();
    return;
  }

  final path = argResults.rest[0];
  var output = path;

  //TODO: Turn output parsing into function

  if (argResults.arguments.length > 1) {
    if (argResults['characters']) {
      final characters = await returnCharCount(path);
      output = '$characters $output';
    }
    if (argResults['words']) {
      final words = await returnWordsCount(path);
      output = '$words $output';
    }
    if (argResults['lines']) {
      final lines = await returnLinesCount(path);
      output = '$lines $output';
    }
    if (argResults['bytes']) {
      final bytes = await returnBytesCount(path);
      output = '$bytes $output';
    }

    stdout.writeln(output);
  } else {
    final characters = await returnCharCount(path);
    final words = await returnWordsCount(path);
    final lines = await returnLinesCount(path);
    final bytes = await returnBytesCount(path);
    output = '$bytes $lines $words $characters $path';

    stdout.writeln(output);
  }
}

void returnDocs() {
  stdout.writeln("Welcome to Coding Challenges wc tool!");
  stdout.writeln("\n");
  stdout.writeln("NAME");
  stdout.writeln("\twc - print newline, word, and byte counts for each file");
  stdout.writeln("SYNOPSIS");
  stdout.writeln("\twc [OPTION]... [FILE]...");
  stdout.writeln("");
  stdout.writeln("-c\n\tprint the byte counts");
  stdout.writeln("-m\n\tprint the character counts");
  stdout.writeln("-l\n\tprint the newline counts");
  stdout.writeln("-w\n\tprint the word counts");
  stdout.writeln("-h\n\topens the ccwc man page");
}

Future<String> returnBytesCount(String path) async {
  try {
    var file = File(path);
    final bytesCount = await file.readAsBytes();
    return '${bytesCount.length}';
  } catch (_) {
    return await _handleError(path);
  }
}

Future<String> returnLinesCount(String path) async {
  try {
    var file = File(path);
    final linesCount = await file.readAsLines();
    return '${linesCount.length}';
  } catch (_) {
    return await _handleError(path);
  }
}

Future<String> returnWordsCount(String path) async {
  try {
    var file = File(path);
    var stringContents = await file.readAsString();
    RegExp exp = RegExp(r'\S+');
    Iterable<RegExpMatch> matches = exp.allMatches(stringContents);
    return '${matches.length}';
  } catch (_) {
    return await _handleError(path);
  }
}

Future<String> returnCharCount(String path) async {
  try {
    var file = File(path);
    var charCount = 0;
    var stringContents = await file.readAsString();

    // readAsString possibly ignores a trailing newline
    var endsWithNewline = await file.readAsBytes();
    if (endsWithNewline.last == 10) {
      // 10 is newline in ASCII
      charCount = stringContents.length + 1;
    }

    return '$charCount';
  } catch (_) {
    return await _handleError(path);
  }
}

Future<String> _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    return 'error: $path is a directory';
  } else {
    exitCode = 2;
    return '';
  }
}
