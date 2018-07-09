/**
*
* Creates a documentation based on the comments from the file.
*
* @command /document
*
* @param <file> the source file to document
* @param <path> the destination path for the file of the documentation
*                 Note: README.html is generated on the specified path.
*
* @global
*
*/
alias document {
  if (!$isid) {
    if ($isfile($1)) && ($isdir($2)) {
        ; write -c $2
        ; write -c $qt($scriptdirdocumentation.temp)
        ; write -c $qt($scriptdirtopics.temp)
        hmake documenting 1
        hadd documenting file $1
        hadd documenting path $2
        hadd documenting active $false
        hadd documenting documenting main_description
        hadd documenting line 0
        readFile
    }
    else {
      echo $color(info) -es * /document: syntax error
      halt
    }
  }
  else {
    echo $color(info) -es * document: is not an identifier
    halt
  }
}

/**
*
* Reads file and documents.
*
* @command /readFile
*
*/
alias -l readFile {
  if (!$isid) {
    hinc documenting line
    tokenize 32 $hget(documenting,file) $hget(documenting,path) $hget(documenting,line) $hget(documenting,documenting)
    var %line = $read($1,n,$3)
    var %text = $right(%line,-2)
    if ($hget(documenting,active)) {
      if (%text != $null) {
        if ($regex(%text,/@(title|header|subheader) (.*)/)) hadd documenting $regml(1) $regml(2)
      }
      elseif (%line == $+($chr(42),$chr(47))) {
        hadd documenting active $false
      }
    }
    elseif (%line == $+($chr(47),$chr(42),$chr(42))) hadd documenting active $true
    
    if ($3 == $lines($1)) createDocumentation
    else .timercleanSimpleGUI 1 0 readFile
  }
  else {
    echo $color(info) -es * readFile: is not an identifier
    halt
  }
}

/**
*
* Generates the README.html file.
*
* @command /createDocumentation
*
*/
alias -l createDocumentation {
  if (!$isid) {
    hdel documenting file
    hdel documenting path
    hdel documenting active
    hdel documenting documenting
    hdel documenting line
    noop $hfind(documenting,*,0,w,echo -s $1 $hget(documenting,$1))
    hfree documenting
    echo $color(info) -es /!\ $+($2,README.html) has been created. /!\
  }
  else {
    echo $color(info) -es * createDocumentation: is not an identifier
    halt
  }
}

/*
    hinc documenting line
    tokenize 32 $hget(documenting,file) $hget(documenting,path) $hget(documenting,line) $hget(documenting,documenting)
    var %line = $read($1,n,$3)
    var %text = $right(%line,-2)
    if ($hget(documenting,active)) {
      if (%text != $null) {
        if ($left(%text,1) != @) && ($4) {
          hadd documenting $+($4,$calc($hfind(documenting,$($4,*),0,w) + 1)) %text
        }
        elseif ($left(%text,1) == @) {
          if ($regex($gettok(%text,1,32),/(@(?:event|command|identifier|group))/)) {
            if ($gettok(%text,2,32) != $null) {
              hadd documenting topic_type $regml(1)
              hadd documenting topic_name $v1
              hdel documenting documenting
            }
          }
          elseif ($regex([name], text, re))
          ; /@param (?:<(.*)>|\[(.*)\]) (.*)/
        }
      }
      elseif (%line == $+($chr(42),$chr(47))) {

      }
    }
    elseif (%line == $+($chr(47),$chr(42),$chr(42))) hadd documenting active $true
    
    if ($3 == $lines($1)) {
      ; finish some stuff here    
      echo $color(info) -es /!\ $+($2,README.html) has been created. /!\ 
    }
    else .timercleanSimpleGUI 1 0 readFile
*/