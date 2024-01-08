unit Job.Model.Timer;

interface

uses
  System.Classes, 
  System.SyncObjs;

type
  TTimerJob = class(TThread)
  private
    FEvent: TEvent;
    FOnTimer: TNotifyEvent;
    FInterval: Integer;
    FOnFinish: TNotifyEvent;
    procedure SetOnTimer(const Value: TNotifyEvent);
    procedure SetInterval(const Value: Integer);
    procedure SetOnFinish(const Value: TNotifyEvent);
  protected
    procedure Execute; override;
    procedure DoTimer;
    procedure DoFinish;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure ForceTerminate;
    property Interval: Integer read FInterval write SetInterval;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
    property OnFinish: TNotifyEvent read FOnFinish write SetOnFinish;
  end;

implementation

{ TTimerJob }

procedure TTimerJob.AfterConstruction;
begin
  inherited;
  FInterval := 1000;
  FEvent := TEvent.Create;
end;

procedure TTimerJob.BeforeDestruction;
begin
  inherited;
  FEvent.Free;
end;

procedure TTimerJob.DoFinish;
begin
  if Assigned(FOnFinish) then
  begin
    FOnFinish(Self);
  end;
end;

procedure TTimerJob.DoTimer;
begin
  if Assigned(FOnTimer) then
  begin
    FOnTimer(Self);
  end;
end;

procedure TTimerJob.Execute;
begin
  inherited;
  var LWaitResult: TWaitResult;
  try
    while not Self.Terminated do
    begin
      LWaitResult := FEvent.WaitFor(FInterval);
      if LWaitResult <> TWaitResult.wrTimeout then
      begin
        Exit;
      end;
      Self.DoTimer;
    end;
  finally
    Self.DoFinish;
  end;
end;

procedure TTimerJob.ForceTerminate;
begin
  FEvent.SetEvent;
end;

procedure TTimerJob.SetInterval(const Value: Integer);
begin
  FInterval := Value;
end;

procedure TTimerJob.SetOnFinish(const Value: TNotifyEvent);
begin
  FOnFinish := Value;
end;

procedure TTimerJob.SetOnTimer(const Value: TNotifyEvent);
begin
  FOnTimer := Value;
end;

end.
