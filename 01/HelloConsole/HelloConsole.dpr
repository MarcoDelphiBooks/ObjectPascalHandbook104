program HelloConsole;

{$APPTYPE CONSOLE}

var
  StrMessage: string;

begin
  StrMessage := 'Hello, World';
  writeln (StrMessage);
  // wait until the Enter key is pressed
  readln;
end.
