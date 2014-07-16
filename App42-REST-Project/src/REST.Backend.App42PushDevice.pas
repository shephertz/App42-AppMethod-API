

{$HPPEMIT LINKUNIT}
unit REST.Backend.App42PushDevice;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  System.PushNotification,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.App42Provider,
  REST.Backend.App42Api,
  REST.Backend.Exception;

type

{$IFDEF IOS}
{$DEFINE PUSH}
{$ENDIF}
{$IFDEF ANDROID}
{$DEFINE PUSH}
{$ENDIF}

  TApp42PushDeviceAPI = class(TApp42ServiceAPIAuth, IBackendPushDeviceApi)
  private const
    sApp42 = 'App42';
  private
    FGCMAppID: string;
  protected
    { IBackendPushDeviceAPI }
    function GetPushService: TPushService; // May raise exception
    function HasPushService: Boolean;
    procedure RegisterDevice(AOnRegistered: TDeviceRegisteredAtProviderEvent);
    procedure UnregisterDevice;
  end;

  TApp42PushDeviceService = class(TApp42BackendService<TApp42PushDeviceAPI>, IBackendService, IBackendPushDeviceService)
  protected
    function CreateBackendApi: TApp42PushDeviceAPI; override;
    { IBackendPushDeviceService }
    function CreatePushDeviceApi: IBackendPushDeviceApi;
    function GetPushDeviceApi: IBackendPushDeviceApi;
  end;

  EApp42PushNotificationError = class(EBackendServiceError);

implementation

uses
  System.Generics.Collections,
  System.TypInfo,
  REST.Backend.Consts,
  REST.Backend.ServiceFactory
{$IFDEF PUSH}
{$IFDEF IOS}
  ,FMX.PushNotification.IOS // inject IOS push provider
{$ENDIF}
{$IFDEF ANDROID}
  ,FMX.PushNotification.Android // inject GCM push provider
{$ENDIF}
{$ENDIF}
  ;

{ TApp42PushDeviceService }

function TApp42PushDeviceService.CreatePushDeviceApi: IBackendPushDeviceApi;
begin
  Result := CreateBackendApi;
end;

function TApp42PushDeviceService.CreateBackendApi: TApp42PushDeviceAPI;
begin
  Result := inherited;
  if ConnectionInfo <> nil then
    Result.FGCMAppID := ConnectionInfo.AndroidPush.GCMAppID
  else
    Result.FGCMAppID := '';
end;

function TApp42PushDeviceService.GetPushDeviceApi: IBackendPushDeviceApi;
begin
  EnsureBackendApi;
  Result := FBackendAPI;
end;

{ TApp42PushDeviceAPI }


function FindValue(const AName: string; APairs: TPushService.TPropArray): string;
var
  LPair: TPair<string, string>;
begin
  for LPair in APairs do
    if SameText(AName, LPair.Key) then
    begin
      Result := LPair.Value;
      break;
    end;
end;

function GetDeviceID(const AService: TPushService): string;
begin
  Result := FindValue(TPushService.TDeviceIDNames.DeviceID, AService.DeviceID);
end;

function GetDeviceName: string;
begin
{$IFDEF IOS}
  Result := 'ios';
{$ENDIF}
{$IFDEF ANDROID}
  Result := 'android';
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result := 'windows';
{$ENDIF}
end;

function GetServiceName: string;
begin
{$IFDEF PUSH}
{$IFDEF IOS}
  Result := TPushService.TServiceNames.APS;
{$ENDIF}
{$IFDEF ANDROID}
  Result := TPushService.TServiceNames.GCM;
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result := '';
{$ENDIF}
{$ENDIF}
end;


function GetService(const AServiceName: string): TPushService;
begin
  Result := TPushServiceManager.Instance.GetServiceByName(AServiceName);
end;

procedure GetRegistrationInfo(const APushService: TPushService;
  out ADeviceID, ADeviceToken: string);
begin
  ADeviceID := FindValue(TPushService.TDeviceIDNames.DeviceID,
    APushService.DeviceID);
  ADeviceToken := FindValue(TPushService.TDeviceTokenNames.DeviceToken,
    APushService.DeviceToken);

  if ADeviceID = ''  then
    raise EApp42PushNotificationError.Create(sDeviceIDUnavailable);

  if ADeviceToken = ''  then
    raise EApp42PushNotificationError.Create(sDeviceTokenUnavailable);
end;

function TApp42PushDeviceAPI.GetPushService: TPushService;
var
  LServiceName: string;
  LDeviceName: string;
  LService: TPushService;
begin
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
  LServiceName := GetServiceName;
  if LServiceName = '' then
    raise EApp42PushNotificationError.CreateFmt(sPushDeviceNoPushService, [sApp42, LDeviceName]);

  LService := GetService(LServiceName);
  if LService = nil then
    raise EApp42PushNotificationError.CreateFmt(sPushDevicePushServiceNotFound, [sApp42, LServiceName]);

  if LService.ServiceName = TPushService.TServiceNames.GCM then
    if not (LService.Status in [TPushService.TStatus.Started]) then
    begin
      if FGCMAppID = '' then
        raise EApp42PushNotificationError.Create(sPushDeviceGCMAppIDBlank);
      LService.AppProps[TPushService.TAppPropNames.GCMAppID] := FGCMAppID;
    end;
  Result := LService;
end;

function TApp42PushDeviceAPI.HasPushService: Boolean;
var
  LServiceName: string;
begin
  LServiceName := GetServiceName;
  Result := (LServiceName <> '') and (GetService(LServiceName) <> nil);
end;


procedure TApp42PushDeviceAPI.RegisterDevice(
  AOnRegistered: TDeviceRegisteredAtProviderEvent);
var
  LDeviceName: string;
  LServiceName: string;
{$IFDEF PUSH}
  LDeviceID: string;
  LDeviceToken: string;
{$ENDIF}
begin
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
  LServiceName := GetServiceName;
  if LServiceName = '' then
    raise EApp42PushNotificationError.CreateFmt(sPushDeviceNoPushService, [sApp42, LDeviceName]);

{$IFDEF PUSH}
  GetRegistrationInfo(GetPushService, LDeviceID, LDeviceToken);    // May raise exception
{$IFDEF IOS}
  App42API.PushRegisterDevice(TApp42Api.TPlatformType.IOS, LDeviceToken);
{$ELSE}
  App42API.PushRegisterDevice(TApp42Api.TPlatformType.Android, LDeviceToken);
{$ENDIF}
  if Assigned(AOnRegistered) then
    AOnRegistered(GetPushService);
{$ELSE}
  raise EApp42PushNotificationError.CreateFmt(sPushDeviceNoPushService, [sApp42, LDeviceName]);
{$ENDIF}
end;

procedure TApp42PushDeviceAPI.UnregisterDevice;
{$IFDEF PUSH}
var
  LDeviceID: string;
  LDeviceToken: string;
{$ENDIF}
begin
{$IFDEF PUSH}
  GetRegistrationInfo(GetPushService, LDeviceID, LDeviceToken);    // May raise exception
{$IFDEF IOS}
  App42API.PushUnregisterDevice(TApp42Api.TPlatformType.IOS, LDeviceToken);
{$ELSE}
  App42API.PushUnregisterDevice(TApp42Api.TPlatformType.Android, LDeviceToken);
{$ENDIF}
{$ENDIF}
end;


type
  TApp42PushDeviceServiceFactory = class(TProviderServiceFactory<IBackendPushDeviceService>)
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; override;
  public
    constructor Create;
  end;

constructor TApp42PushDeviceServiceFactory.Create;
begin
  inherited Create(TCustomApp42Provider.ProviderID, 'REST.Backend.App42PushDevice');
end;

function TApp42PushDeviceServiceFactory.CreateService(const AProvider: IBackendProvider;
  const IID: TGUID): IBackendService;
begin
  Result := TApp42PushDeviceService.Create(AProvider);
end;

var
  FFactory: TApp42PushDeviceServiceFactory;

initialization
  FFactory := TApp42PushDeviceServiceFactory.Create;
  FFactory.Register;
finalization
  FFactory.Unregister;
  FFactory.Free;

end.

