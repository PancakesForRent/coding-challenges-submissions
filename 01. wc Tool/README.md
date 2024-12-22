# Build Your Own wc Tool

This challenge is to build your own version of the Unix command line tool wc!

The Unix command line tools are a great metaphor for good software engineering and they follow the Unix Philosophies of:

- Writing simple parts connected by clean interfaces - each tool does just one thing and provides a simple CLI that handles text input from either files or file streams.
  
- Design programs to be connected to other programs - each tool can be easily connected to other tools to create incredibly powerful compositions.


 
## The Challenge - Building wc

The TL/DR version is: wc – word, line, character, and byte count.

### Step Zero

Like all good software engineering we’re zero indexed! In this step you’re going to set your environment up ready to begin developing and testing your solution.

I’ll leave you to setup your IDE / editor of choice and programming language of choice. After that here’s what I’d like you to do to be ready to test your solution.

### Step One
`DONE`

In this step your goal is to write a simple version of wc, let’s call it ccwc (cc for Coding Challenges) that takes the command line option -c and outputs the number of bytes in a file.

If you’ve done it right your output should match this:

```bash
>ccwc -c test.txt
  342190 test.txt
```

### Step Two

`DONE`
In this step your goal is to support the command line option -l that outputs the number of lines in a file.

If you’ve done it right your output should match this:

```bash
>ccwc -l test.txt
  7145 test.txt
```

### Step Three

`DONE`
In this step your goal is to support the command line option -w that outputs the number of words in a file. If you’ve done it right your output should match this:

```bash
>ccwc -w test.txt
  58164 test.txt
```

### Step Four

`DONE`
In this step your goal is to support the command line option -m that outputs the number of characters in a file. If the current locale does not support multibyte characters this will match the -c option.

You can learn more about programming for locales here

For this one your answer will depend on your locale, so if can, use wc itself and compare the output to your solution:

```bash
>wc -m test.txt
  339292 test.txt

>ccwc -m test.txt
  339292 test.txt
```

### Step Five

`DONE`
In this step your goal is to support the default option - i.e. no options are provided, which is the equivalent to the -c, -l and -w options. If you’ve done it right your output should match this:

```bash
>ccwc test.txt
    7145   58164  342190 test.txt
```

### The Final Step

`TODO`
In this step your goal is to support being able to read from standard input if no filename is specified. If you’ve done it right your output should match this:

```bash
>cat test.txt | ccwc -l
    7145
```

*Credits to Coding Challenges for providing this wonderful challenge!*