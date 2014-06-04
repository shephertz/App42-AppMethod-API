{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2014 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}
unit REST.Backend.App42Provider;

interface

uses System.Classes, System.Generics.Collections, REST.Backend.Providers,
  REST.Backend.App42API, REST.Client, REST.Backend.ServiceTypes,
  REST.Backend.MetaTypes,REST.Backend.ParseProvider;

type

  TCustomApp42ConnectionInfo = class(TComponent)
  public type
    TNotifyList = class
    private
      FList: TList<TNotifyEvent>;
      procedure Notify(Sender: TObject);
    public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ANotify: TNotifyEvent);
      procedure Remove(const ANotify: TNotifyEvent);
    end;
    TAndroidPush = class(TPersistent)
    private
      FGCMAppID: string;
    protected
      procedure AssignTo(AValue: TPersistent); override;
    published
      property GCMAppID: string read FGCMAppID write FGCMAppID;
    end;
  private
    FConnectionInfo: TApp42Api.TConnectionInfo;
    FNotifyOnChange: TNotifyList;
    FAndroidPush: TAndroidPush;
    procedure SetApiVersion(const Value: string);
 //   procedure SetApplicationID(const Value: string);
    procedure SetApiKey(const Value: string);
    procedure SetSecretKey(const Value: string);
 //   procedure SetDBName(const Value: string);
    function GetApiVersion: string;
    function GetApiKey: string;
    function GetSecretKey: string;
  //  function GetDBName: string;
  //  function GetApplicationID: string;
    procedure SetAndroidPush(const Value: TAndroidPush);
  protected
    procedure DoChanged; virtual;
    property NotifyOnChange: TNotifyList read FNotifyOnChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateApi(const AApp42Api: TApp42Api);

    property ApiVersion: string read GetApiVersion write SetApiVersion;
 //   property ApplicationID: string read GetApplicationID write SetApplicationID;
    property ApiKey: string read GetApiKey write SetApiKey;
    property SecretKey: string read GetSecretKey write SetSecretKey;
  //  property DBName: string read GetDBName write SetDBName;
    property AndroidPush: TAndroidPush read FAndroidPush write SetAndroidPush;
  end;

  TCustomApp42Provider = class(TCustomApp42ConnectionInfo, IBackendProvider, IRESTIPComponent)
  public const
    ProviderID = 'App42';
  protected
    { IBackendProvider }
    function GetProviderID: string;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid)]
  TApp42Provider = class(TCustomApp42Provider)
  published
    property ApiVersion;
 //   property ApplicationID;
    property ApiKey;
    property SecretKey;
  //  property DBName;
    // App42/GCM not currently supported
    // property AndroidPush;
  end;

  TApp42BackendService = class(TInterfacedObject)
  private
    FConnectionInfo: TCustomApp42ConnectionInfo;
    procedure SetConnectionInfo(const Value: TCustomApp42ConnectionInfo);
    procedure OnConnectionChanged(Sender: TObject);
  protected
    procedure DoAfterConnectionChanged; virtual;
    property ConnectionInfo: TCustomApp42ConnectionInfo read FConnectionInfo write SetConnectionInfo;
  public
    constructor Create(const AProvider: IBackendProvider); virtual;
    destructor Destroy; override;
  end;

  // Use to access TApp42API from a component
  //
  // if Supports(BackendStorage1.ProviderService, IGetApp42API, LIntf) then
  //    LApp42API := LIntf.App42API;
  IGetApp42API = interface
    ['{9EFB309D-6A53-4F3B-8B7F-D9E7D92998E8}']
    function GetApp42API: TApp42API;
    property App42API: TApp42API read GetApp42Api;
  end;

  TApp42ServiceAPI = class(TInterfacedObject, IBackendAPI, IGetApp42API)
  private
    FApp42API: TApp42API;
    { IGetApp42API }
    function GetApp42API: TApp42API;
  protected
    property App42API: TApp42API read FApp42API;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TApp42ServiceAPIAuth = class(TApp42ServiceAPI, IBackendAuthenticationApi)
  protected
    { IBackendAuthenticationApi }
    procedure Login(const ALogin: TBackendEntityValue);
    procedure Logout;
    procedure SetDefaultAuthentication(ADefaultAuthentication: TBackendDefaultAuthentication);
    function GetDefaultAuthentication: TBackendDefaultAuthentication;
    procedure SetAuthentication(AAuthentication: TBackendAuthentication);
    function GetAuthentication: TBackendAuthentication;
  end;

  TApp42BackendService<TAPI: TApp42ServiceAPI, constructor> = class(TApp42BackendService, IGetApp42API)
  private
    FBackendAPI: TAPI;
    FBackendAPIIntf: IInterface;
    procedure ReleaseBackendApi;
    { IGetApp42API }
    function GetApp42API: TApp42API;
  protected
    function CreateBackendApi: TAPI; virtual;
    procedure EnsureBackendApi;
    procedure DoAfterConnectionChanged; override;
  end;

implementation

uses System.SysUtils, REST.Backend.App42MetaTypes;

{ TCustomApp42Provider }

function TCustomApp42Provider.GetProviderID: string;
begin
  Result := ProviderID;
end;

{ TCustomApp42ConnectionInfo }

constructor TCustomApp42ConnectionInfo.Create(AOwner: TComponent);
begin
  inherited;
  FConnectionInfo := TApp42Api.TConnectionInfo.Create('', '');
  FNotifyOnChange := TNotifyList.Create;
  FAndroidPush := TAndroidPush.Create;
end;

destructor TCustomApp42ConnectionInfo.Destroy;
begin
  FAndroidPush.Free;
  inherited;
  FNotifyOnChange.Free;
end;

procedure TCustomApp42ConnectionInfo.DoChanged;
begin
  FNotifyOnChange.Notify(Self);
end;

function TCustomApp42ConnectionInfo.GetApiVersion: string;
begin
  Result := FConnectionInfo.ApiVersion;
end;

//function TCustomApp42ConnectionInfo.GetApplicationID: string;
//begin
//  Result := FConnectionInfo.ApplicationID;
//end;

function TCustomApp42ConnectionInfo.GetApiKey: string;
begin
  Result := FConnectionInfo.ApiKey;
end;

function TCustomApp42ConnectionInfo.GetSecretKey: string;
begin
  Result := FConnectionInfo.SecretKey;
end;

//function TCustomApp42ConnectionInfo.GetDBName: string;
//begin
//  Result := 'dfgdfg';
//end;

procedure TCustomApp42ConnectionInfo.SetAndroidPush(const Value: TAndroidPush);
begin
  FAndroidPush.Assign(Value);
end;

procedure TCustomApp42ConnectionInfo.SetApiVersion(const Value: string);
begin
  if Value <> ApiVersion then
  begin
    FConnectionInfo.ApiVersion := Value;
    DoChanged;
  end;
end;

//procedure TCustomApp42ConnectionInfo.SetApplicationID(const Value: string);
//begin
//  if Value <> ApplicationID then
//  begin
//    FConnectionInfo.ApplicationID := Value;
//    DoChanged;
//  end;
//end;

procedure TCustomApp42ConnectionInfo.SetApiKey(const Value: string);
begin
  if Value <> ApiKey then
  begin
    FConnectionInfo.ApiKey := Value;
    DoChanged;
  end;
end;

procedure TCustomApp42ConnectionInfo.SetSecretKey(const Value: string);
begin
  if Value <> SecretKey then
  begin
    FConnectionInfo.SecretKey := Value;
    DoChanged;
  end;
end;

//procedure TCustomApp42ConnectionInfo.SetDBName(const Value: string);
//begin
//  if Value <> DBName then
//  begin
//    FConnectionInfo.DBName := Value;
//    DoChanged;
//  end;
//end;

procedure TCustomApp42ConnectionInfo.UpdateApi(const AApp42Api: TApp42Api);
begin
  AApp42Api.ConnectionInfo := FConnectionInfo;
end;

{ TCustomApp42ConnectionInfo.TNotifyList }

procedure TCustomApp42ConnectionInfo.TNotifyList.Add(const ANotify: TNotifyEvent);
begin
  Assert(not FList.Contains(ANotify));
  if not FList.Contains(ANotify) then
    FList.Add(ANotify);
end;

constructor TCustomApp42ConnectionInfo.TNotifyList.Create;
begin
  FList := TList<TNotifyEvent>.Create;
end;

destructor TCustomApp42ConnectionInfo.TNotifyList.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TCustomApp42ConnectionInfo.TNotifyList.Notify(Sender: TObject);
var
  LProc: TNotifyEvent;
begin
  for LProc in FList do
    LProc(Sender);
end;

procedure TCustomApp42ConnectionInfo.TNotifyList.Remove(
  const ANotify: TNotifyEvent);
begin
  Assert(FList.Contains(ANotify));
  FList.Remove(ANotify);
end;

{ TApp42ServiceAPI }

constructor TApp42ServiceAPI.Create;
begin
  FApp42API := TApp42API.Create(nil);
end;

destructor TApp42ServiceAPI.Destroy;
begin
  FApp42API.Free;
  inherited;
end;

function TApp42ServiceAPI.GetApp42API: TApp42API;
begin
  Result := FApp42API;
end;

{ TApp42BackendService<TAPI> }

function TApp42BackendService<TAPI>.CreateBackendApi: TAPI;
begin
  Result := TAPI.Create;
  if ConnectionInfo <> nil then
    ConnectionInfo.UpdateAPI(Result.FApp42API)
  else
    Result.FApp42API.ConnectionInfo := TApp42API.EmptyConnectionInfo;
end;

procedure TApp42BackendService<TAPI>.EnsureBackendApi;
begin
  if FBackendAPI = nil then
  begin
    FBackendAPI := CreateBackendApi;
    FBackendAPIIntf := FBackendAPI; // Reference
  end;
end;

function TApp42BackendService<TAPI>.GetApp42API: TApp42API;
begin
  EnsureBackendApi;
  if FBackendAPI <> nil then
    Result := FBackendAPI.FApp42API;
end;

procedure TApp42BackendService<TAPI>.ReleaseBackendApi;
begin
  FBackendAPI := nil;
  FBackendAPIIntf := nil;
end;

procedure TApp42BackendService<TAPI>.DoAfterConnectionChanged;
begin
  ReleaseBackendApi;
end;

{ TApp42BackendService }

constructor TApp42BackendService.Create(const AProvider: IBackendProvider);
begin
  if AProvider is TCustomApp42ConnectionInfo then
    ConnectionInfo := TCustomApp42ConnectionInfo(AProvider)
  else
    raise Exception.Create('wrong provider');
end;

destructor TApp42BackendService.Destroy;
begin
  if Assigned(FConnectionInfo) then
    FConnectionInfo.NotifyOnChange.Remove(OnConnectionChanged);
  inherited;
end;

procedure TApp42BackendService.DoAfterConnectionChanged;
begin
//
end;

procedure TApp42BackendService.OnConnectionChanged(Sender: TObject);
begin
  DoAfterConnectionChanged;
end;

procedure TApp42BackendService.SetConnectionInfo(
  const Value: TCustomApp42ConnectionInfo);
begin
  if FConnectionInfo <> nil then
    FConnectionInfo.NotifyOnChange.Remove(OnConnectionChanged);
  FConnectionInfo := Value;
  if FConnectionInfo <> nil then
    FConnectionInfo.NotifyOnChange.Add(OnConnectionChanged);
  OnConnectionChanged(Self);
end;

{ TCustomApp42ConnectionInfo.TAndroidProps }

procedure TCustomApp42ConnectionInfo.TAndroidPush.AssignTo(
  AValue: TPersistent);
begin
  if AValue is TAndroidPush then
    Self.FGCMAppID := TAndroidPush(AValue).FGCMAppID
  else
    inherited;
end;

{ TApp42ServiceAPIAuth }

procedure TApp42ServiceAPIAuth.Login(const ALogin: TBackendEntityValue);
var
  LMetaLogin: TMetaLogin;
begin
  if ALogin.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(ALogin.Data);
    App42API.Login(LMetaLogin.Login);
  end
  else
    raise Exception.Create('Parameter');
end;

procedure TApp42ServiceAPIAuth.Logout;
begin
  App42API.Logout;
end;

procedure TApp42ServiceAPIAuth.SetDefaultAuthentication(
  ADefaultAuthentication: TBackendDefaultAuthentication);
begin
  case ADefaultAuthentication of
    TBackendDefaultAuthentication.Root:
      App42API.DefaultAuthentication := TApp42Api.TDefaultAuthentication.ApiKey;
//    TBackendDefaultAuthentication.Application:
//      TApp42Api.DefaultAuthentication := TApp42Api.TDefaultAuthentication.ApiVersion;
//    TBackendDefaultAuthentication.Session:
//      TApp42Api.DefaultAuthentication := TApp42Api.TDefaultAuthentication.Session;
//    TBackendDefaultAuthentication.None:
//      TApp42Api.DefaultAuthentication := TApp42Api.TDefaultAuthentication.None;
//    TBackendDefaultAuthentication.User:
//      raise EApp42APIError.CreateFmt(sAuthenticationNotSupported, [
//        System.TypInfo.GetEnumName(TypeInfo(TBackendDefaultAuthentication), Integer(ADefaultAuthentication))]);
  else
    Assert(False);
  end;
end;

function TApp42ServiceAPIAuth.GetDefaultAuthentication: TBackendDefaultAuthentication;
begin
  case App42API.DefaultAuthentication of
    TApp42Api.TDefaultAuthentication.APIKey:
      Result := TBackendDefaultAuthentication.Application;
    TApp42Api.TDefaultAuthentication.ApiVersion:
      Result := TBackendDefaultAuthentication.Root;
//    TApp42Api.TDefaultAuthentication.Session:
//      Result := TBackendDefaultAuthentication.Session;
  else
    Assert(False);
    Result := TBackendDefaultAuthentication.Root;
  end;
end;


procedure TApp42ServiceAPIAuth.SetAuthentication(
  AAuthentication: TBackendAuthentication);
begin
  case AAuthentication of
    TBackendAuthentication.Default:
      App42API.Authentication := TApp42API.TAuthentication.ApiKey;
//    TBackendAuthentication.Root:
//      App42API.Authentication := TApp42API.TAuthentication.ApiKey;
//    TBackendAuthentication.Application:
//      App42API.Authentication := TApp42API.TAuthentication.APIKey;
//    TBackendAuthentication.Session:
//      App42API.Authentication := TApp42API.TAuthentication.Session;
//    TBackendAuthentication.None:
//      App42API.Authentication := TApp42API.TAuthentication.None;
//    TBackendAuthentication.User:
//      raise EApp42APIError.CreateFmt(sAuthenticationNotSupported, [
//        System.TypInfo.GetEnumName(TypeInfo(TBackendAuthentication), Integer(AAuthentication))]);
  else
    Assert(False);
  end;
end;


  function TApp42ServiceAPIAuth.GetAuthentication : TBackendAuthentication;
begin
  case App42Api.Authentication of
    TApp42Api.TAuthentication.ApiKey:
      Result := TBackendAuthentication.Default;
    TApp42Api.TAuthentication.ApiVersion:
      Result := TBackendAuthentication.Root;
//    TApp42Api.TAuthentication.APIKey:
//       Result := TBackendAuthentication.Application;
//   TApp42Api.TAuthentication.Session:
//       Result := TBackendAuthentication.Session;
  else
    Assert(False);
    Result := TBackendAuthentication.Default;
  end;
end;

initialization
  TBackendProviders.Instance.Register(TCustomApp42Provider.ProviderID, 'App42');
finalization
  TBackendProviders.Instance.UnRegister(TCustomApp42Provider.ProviderID);
end.
