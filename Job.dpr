program Job;

uses
  Vcl.Forms,
  Job.View.Main in 'src\view\Job.View.Main.pas' {Form1},
  Job.Model.Timer in 'src\model\Job.Model.Timer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
