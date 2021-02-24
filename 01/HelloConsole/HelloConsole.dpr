program HelloConsole;

{$APPTYPE CONSOLE}

var
  StrMessage: string;

begin
  StrMessage := 'Hello, World';
  Writeln(StrMessage);
  // wait until the Enter key is pressed
  Readln;
end.
