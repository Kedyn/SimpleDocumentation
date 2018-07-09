# SimpleDocumentation
This is a tool that generates documentation based on comments on an mSL file.

# Dependencies

mIRC v7.52+

# Installation

The main file is called `SimpleDocumentation.mRC` and it is located in the `root` folder. 

# How to use it

The main command is `document <file> <destination>`, where `<file>` is the msl file and `<path>` the destination path for the file of the documentation *(README.html)*.

All of your documentation comments must start with **`/**`**. And the documentation must start with an asterics and a space (`* `). The documentation must follow the following paterns:

**For General Information**
```php
/**
* @title Documentation title
* @header Main Header
* @subheader Sub Header
* @footer Some footer
*/
```
*example:*
```php
/**
* @title My Project's Documentation
* @header My Project
* @subheader The best project
* @footer My Project
*/
```

**For events:**
```php
/**
* Description...
*
* @event someEvent
*/
```
*example:*
```php
/**
*
* Loads everything needed for this project when mIRC starts.
*
* @event start
*
*/
on *:start: echo -s nothing is needed ;)
```

**For Commands**
```php
/**
* Description...
*
* @command /myCommand
*
* @switch a some description...
* 
* @param <someParam> someParam description...
*
* @global
*/
```
*example:*
```php
/**
*
* Changes my nick to something random
*
* @command /fun
*
* @param <N> the number of characters
*
*/
alias -l fun {
  var %nick = $char($rand(65,90)),%i = 1
  whie (%i < $1) {
    %nick = $+(%nick,$char($rand(65,90)))
    inc %i
  }
  nick %nick
}
```

**For Identifiers**
```php
/**
* Description...
*
* @identifier $myIdentifier
* 
* @param <someParam> someParam description...
*
* @prop someProp someProp description...
*
* @global
*/
```

*example:*
```php
/**
*
* Returns my projects current version.
*
* @identifier $SIMPLE_VERSION
*
* @global
*
*/
alias SIMPLE_VERSION return 0.0.1
```

__*Note:*__
- All *@* specifiers are optional.
- *@title*,*@header*,*@subtitle* can only be one line long
- The *@global* specifier indicates that the alias is a global.

# Contributing & Development Process

If you would like to contribute to the project I ask that you use variable_names with all lower case and all aliases with camelCase. All new aliases and/or modifications must be documented.

# License

This project is made available under the MIT License.