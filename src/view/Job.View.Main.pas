unit Job.View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Job.Model.Timer, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FTimerJob: TTimerJob;
    procedure DoTimer(Sender: TObject);
    procedure DoFinish(Sender: TObject);
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FTimerJob.Start;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FTimerJob.ForceTerminate;
end;

procedure TForm1.DoFinish(Sender: TObject);
begin
  TThread.Queue(
    nil,
    procedure
    begin
      Memo1.Lines.Add('Fim da thread');
    end
  );
end;

procedure TForm1.DoTimer(Sender: TObject);
begin
  TThread.Queue(
    nil,
    procedure
    begin
      Memo1.Lines.Add(DateTimeToStr(Now));
    end
  );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTimerJob := TTimerJob.Create(True);
  FTimerJob.Interval := 5000;
  FTimerJob.OnTimer := DoTimer;
  FTimerJob.OnFinish := DoFinish;
end;

end.
