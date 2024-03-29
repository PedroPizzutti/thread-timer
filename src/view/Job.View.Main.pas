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
    procedure DoException(Sender: TObject; AException: Exception);
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

procedure TForm1.DoException(Sender: TObject; AException: Exception);
begin
  TThread.Synchronize(
    nil,
    procedure
    begin
      Memo1.Lines.Add(AException.Message);
    end
  );
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

  var LRandomNumber: Integer := Random(10);

  if (LRandomNumber mod 2) <> 0 then
  begin
    //Se der esse tipo de exce��o aqui, o tratamento � interno do timer
    raise Exception.Create('Erro tratado dentro do timer');
  end;

  TThread.Queue(
    nil,
    procedure
    begin
      try
        if (Random(10) mod 2) <> 0 then
        begin
          Memo1.Lines.Add('Deu certo!');
        end
        else
        begin
          raise Exception.Create('Erro tratado externamente');
        end;
      except
        on E: Exception do
        begin
          DoException(Sender, E);
        end;
      end;
    end
  );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTimerJob := TTimerJob.Create(True);
  FTimerJob.Interval := 2000;
  FTimerJob.OnTimer := DoTimer;
  FTimerJob.OnFinish := DoFinish;
  FTimerJob.OnException := DoException;
end;

end.
