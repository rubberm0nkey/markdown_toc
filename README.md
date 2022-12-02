# markdown_toc

Simple TOC (Table Of Contents) generator for markdown

## Usage

Siply put a `<!--TOC.Begin-->` and a `<!--TOC.End-->` signal to the markdown file.

Run the program with the markdown file as argument

```bash
markdown_toc path/to/markdown/file.md
```

Supports only heeadings marked with `#` hash character.

It will replace the content with the new TOC

The content before the `<!--TOC.End-->` signal will be skipped from TOC

## Sample markdown content without TOC

```markdown
# Hello World! I'm a heading, and I will be skipped from TOC!

Lorem ipsum dolor sit amet, consectetur adipiscing elit

# Table Of Contents

<!--TOC.Begin-->
<!--TOC.End-->

# I will be the first item in the TOC

Morbi quis rhoncus orci

## Just a second level heading

Maecenas pulvinar quam at dolor placerat consectetur.

## Another second level heading

Aenean consectetur ornare sollicitudin

### Third level heading for the sake

Donec sed aliquam ligula. Quisque commodo erat quis volutpat gravida

### Second third

Aliquam laoreet ante quis auctor lacinia

### Third third 

Quisque porta lectus nec rutrum ullamcorper

# Back to the roots

Nunc maximus fermentum varius
```

## Run the program

```bash
$ markdown_toc sample.md
TOC.Begin: 6 TOC.End: 7
TOC updated
```

**And the result TOC will be like this:**

```markdown
# Hello World! I'm a heading, and I will be skipped from TOC!

Lorem ipsum dolor sit amet, consectetur adipiscing elit

# Table Of Contents

<!--TOC.Begin-->
- [I will be the first item in the TOC](#i-will-be-the-first-item-in-the-toc)
  - [Just a second level heading](#just-a-second-level-heading)
  - [Another second level heading](#another-second-level-heading)
    - [Third level heading for the sake](#third-level-heading-for-the-sake)
    - [Second third](#second-third)
    - [Third third ](#third-third-)
- [Back to the roots](#back-to-the-roots)
<!--TOC.End-->

# I will be the first item in the TOC

Morbi quis rhoncus orci

## Just a second level heading

Maecenas pulvinar quam at dolor placerat consectetur.

## Another second level heading

Aenean consectetur ornare sollicitudin

### Third level heading for the sake

Donec sed aliquam ligula. Quisque commodo erat quis volutpat gravida

### Second third

Aliquam laoreet ante quis auctor lacinia

### Third third 

Quisque porta lectus nec rutrum ullamcorper

# Back to the roots

Nunc maximus fermentum varius
```

