{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2014 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}
unit REST.Backend.App42Api;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.JSON,
  REST.Client, REST.Types, REST.Backend.Exception;

{$SCOPEDENUMS ON}

type

  EApp42APIError = class(EBackendError)
  private
    FCode: Integer;
    FError: string;
  public
    constructor Create(ACode: Integer; const AError: String); overload;
    property Code: Integer read FCode;
    property Error: string read FError;
  end;

  TApp42APIErrorClass = class of EApp42APIError;

  /// <summary>
  /// <para>
  /// TApp42Api
  /// </para>
  /// </summary>
  TApp42Api = class(TComponent)
  public type
    TPlatformType = (IOS, Android);

  private const
    sStorage = 'storage'; // do not localize
    sFiles = 'upload';    // do not localize
    sUsers = 'user';      // do not localize
    sPush = 'push';       // do not localize
    sSession = 'session'; // do not localize
  public const
  cDefaultApiVersion = '1.0';  // do not localize
  cDefaultBaseURL = 'https://api.shephertz.com/cloud/1.0/'; // do not localize
  public type
    TDeviceNames = record
    public
      const IOS = 'ios';
      const Android = 'android';
    end;

    TConnectionInfo = record
    public
      ApiVersion: string;
      ApiKey: string;
      SecretKey: string;
      AdminKey: string;
      UserName: string;
      ProxyPassword: string;
      ProxyPort: Integer;
      ProxyServer: string;
      ProxyUsername: string;
      constructor Create(const AApiVersion, AApiKey: string);
    end;

    TUpdatedAt = record
    private
      FUpdatedAt: TDateTime;
      FObjectID: string;
      FBackendClassName: string;
    public
      constructor Create(const ABackendClassName, AObjectID: string; AUpdatedAt: TDateTime);
      property UpdatedAt: TDateTime read FUpdatedAt;
      property ObjectID: string read FObjectID;
      property BackendClassName: string read FBackendClassName;
    end;



    TObjectID = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FObjectID: string;
      FBackendClassName: string;
    public
      constructor Create(const ABackendClassName: string; AObjectID: string);
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property ObjectID: string read FObjectID;
      property BackendClassName: string read FBackendClassName;
    end;

    TUser = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FObjectID: string;
      FUserName: string;
    public
      constructor Create(const AUserName: string);
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property ObjectID: string read FObjectID;
      property UserName: string read FUserName;
    end;

    TLogin = record
    private
      FSessionToken: string;
      FUser: TUser;
    public
      constructor Create(const ASessionToken: string; const AUser: TUser);
      property SessionToken: string read FSessionToken;
      property User: TUser read FUser;
    end;

    TFile = record
    private
      FName: string;
      FFileName: string;
      FDownloadURL: string;
    public
      constructor Create(const AName: string);
      property FileName: string read FFileName;
      property DownloadURL: string read FDownloadURL;
      property Name: string read FName;
    end;

    TAuthentication = (Default, AdminKey, APIKey, Session, None);
    TAuthentications = set of TAuthentication;
    TDefaultAuthentication = (APIKey, AdminKey, Session, None);

    TFindObjectProc = reference to procedure(const AID: TObjectID; const AObj: TJSONObject);
    TQueryUserNameProc = reference to procedure(const AUser: TUser; const AUserObject: TJSONObject);
    TLoginProc = reference to procedure(const ALogin: TLogin; const AUserObject: TJSONObject);
    TRetrieveUserProc = reference to procedure(const AUser: TUser; const AUserObject: TJSONObject);

  public
    const
      DateTimeIsUTC = True;
  public class var
      EmptyConnectionInfo: TConnectionInfo;
  private
    FRESTClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FOwnsResponse: Boolean;
    FBaseURL: string;
    FConnectionInfo: TConnectionInfo;
    FSessionToken: string;
    FAuthentication: TAuthentication;
    FDefaultAuthentication: TDefaultAuthentication;
    procedure SetConnectionInfo(const Value: TConnectioninfo);
    procedure SetBaseURL(const Value: string);
    function GetLoggedIn: Boolean;
  protected
    procedure AddAdminKey(const AKey: string); overload;   // AddDefaultAuth
    procedure AddAPIKey(const AKey: string); overload;
    procedure AddDefaultAuth(const ADefault: string); overload;
    procedure AddSessionToken(const ASessionToken: string); overload;
    procedure ApplyConnectionInfo;
    procedure CheckAuthentication(AAuthentication: TAuthentications);
    function GetActualAuthentication: TAuthentication;
    function CreateException(const ARequest: TRESTRequest;
      const AClass: TApp42APIErrorClass): EApp42APIError;
    procedure CheckForResponseError(AValidStatusCodes: array of Integer); overload;
    procedure CheckForResponseError; overload;
    procedure CheckForResponseError(const ARequest: TRESTRequest); overload;
    procedure CheckForResponseError(const ARequest: TRESTRequest;
      AValidStatusCodes: array of Integer); overload;
    procedure PostResource(const AResource: string;
      const AJSON: TJSONObject; AReset: Boolean);
    procedure PutResource(const AResource: string;
      const AJSONObject: TJSONObject; AReset: Boolean);
    function DeleteResource(const AResource: string; AReset: Boolean): Boolean; overload;
    function ObjectIDFromObject(const ABackendClassName, AObjectID: string;
      const AJSONObject: TJSONObject): TObjectID; overload;
    function FileIDFromObject(const AFileName: string; const AJSONObject: TJSONObject): TFile;
    procedure AddAuthParameters; overload;
    procedure AddAuthParameters(AAuthentication: TAuthentication); overload;
    function FindClass(const ABackendClassName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray; AProc: TFindObjectProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean; overload;
    function LoginFromObject(const AUserName: string; const AJSONObject: TJSONObject): TLogin;
    function UserFromObject(const AUserName: string; const AJSONObject: TJSONObject): TUser; overload;
    function UpdatedAtFromObject(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject): TUpdatedAt;
    procedure QueryResource(const AResource: string; ACollection: string; const AQuery: array of string; const AJSONArray: TJSONArray; AReset: Boolean);
    function RetrieveCurrentUser(const ASessionToken: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveUser(const ASessionID, AObjectID: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc; AReset: Boolean): Boolean; overload;
    function RetrieveLoggedInUser(const ASessionID, AObjectID: string; out AUser: TUser; const AJSON: TJSONArray;  AProc: TRetrieveUserProc; AReset: Boolean): Boolean;
    procedure UpdateUser(const ASessionID, AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    property RestClient: TRESTClient read FRESTClient;
    property Request: TRESTRequest read FRequest;
  public
    constructor Create(AOwner: TComponent;
      const AResponse: TRESTResponse = nil); reintroduce; overload;
    destructor Destroy; override;
    function UserFromObject(const AJSONObject: TJSONObject): TUser; overload;
    function ObjectIDFromObject(const ABackendClassName: string;
      const AJSONObject: TJSONObject): TObjectID; overload;
    // Objects
    procedure CreateClass(const ABackendClassName: string; const AJSON: TJSONObject; out ANewObject: TObjectID); overload;
    procedure CreateClass(const ABackendClassName: string; const AACL, AJSON: TJSONObject; out ANewObject: TObjectID); overload;

    function DeleteClass(const AID: TObjectID): Boolean; overload;
    function DeleteClass(const ABackendClassName, AObjectID: string): Boolean; overload;
    function FindClass(const ABackendClassName, AObjectID: string; AProc: TFindObjectProc): Boolean; overload;
    function FindClass(const ABackendClassName, AObjectID: string; out AFoundObjectID: TObjectID; const AFoundJSON: TJSONArray = nil): Boolean; overload;
    function FindClass(const AID: TObjectID; AProc: TFindObjectProc): Boolean; overload;
    function FindClass(const AID: TObjectID; out AFoundObjectID: TObjectID; const AFoundJSON: TJSONArray = nil): Boolean; overload;
    procedure UpdateClass(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    procedure UpdateClass(const AID: TObjectID; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    procedure QueryClass(const ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryClass(const ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>); overload;
    // Installations
    function CreateAndroidInstallationObject(const AInstallationID: string; AChannels: array of string): TJSONObject;
    function CreateIOSInstallationObject(const ADeviceToken: string; ABadge: Integer; AChannels: array of string): TJSONObject;
    procedure UploadInstallation(const AJSON: TJSONObject; out ANewObject: TObjectID);
    procedure UpdateInstallation(const AObjectID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
    function DeleteInstallation(const AObjectID: string): Boolean; overload;
    procedure QueryInstallation(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryInstallation(const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>); overload;


    procedure PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID, AUserID: string); overload;
    procedure PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string); overload;
    procedure PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string; const AUser: TUser); overload;
    procedure PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID, AUserID: string); overload;
    procedure PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string; const AUser: TUser); overload;
    procedure PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string); overload;


    // Push
    procedure PushBody(const AMessage: TJSONObject);
    procedure PushToDevices(const ADevices: array of string; const AData: TJSONObject);
    procedure PushBroadcast(const AData: TJSONObject);
    procedure PushToChannels(const AChannels: array of string; const AData: TJSONObject);
    procedure PushWhere(const AWhere: TJSONObject; const AData: TJSONObject);
    // Files
    procedure UploadFile(const AFileName: string; const AContentType: string; out ANewFile: TFile); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string; out ANewFile: TFile); overload;
    function DeleteFile(const AFileID: TFile): Boolean;
    // Users
    function CreateSessionFromLogin(const AUserName: string; ASessionId: string; AUser: TUser) : Boolean;
    function UserFromUserName(const AUserName: string): TJSONObject;
    function QueryUserName(const AUserName: string; AProc: TQueryUserNameProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AObjectID: string; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveUser(const AObjectID: string; out AUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const ALogin: TLogin; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveUser(const ALogin: TLogin; out AUser: TUser; const AJSON: TJSONArray): Boolean; overload;
    procedure SignupUser(const AUserName, APassword: string; const AUserFields: TJSONObject; out ANewUser: TLogin);
    procedure LoginUser(const AUserName, APassword: string; AProc: TLoginProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out ALogin: TLogin; const AJSONArray: TJSONArray = nil); overload;
    function RetrieveCurrentUser(AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveCurrentUser(out AUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveCurrentUser(const ALogin: TLogin; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveCurrentUser(const ALogin: TLogin; const AJSON: TJSONArray): Boolean; overload;
    procedure UpdateUser(const AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    procedure UpdateUser(const ALogin: TLogin; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    function DeleteUser(const AObjectID: string): Boolean; overload;
    function DeleteUser(const ALogin: TLogin): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AUsers: TArray<TUser>); overload;
    procedure Login(const ASessionToken: string); overload;
    procedure Login(const ALogin: TLogin); overload;
    procedure Logout;
    property LoggedIn: Boolean read GetLoggedIn;
    property Authentication: TAuthentication read FAuthentication write FAuthentication;
    property DefaultAuthentication: TDefaultAuthentication read FDefaultAuthentication write FDefaultAuthentication;
    property Response: TRESTResponse read FResponse;
    property BaseURL: string read FBaseURL write SetBaseURL;
    property ConnectionInfo: TConnectioninfo read FConnectionInfo write SetConnectionInfo;
  end;

  TApp42Utils = class
  protected
  public
    function BuildCompoundQueryString(const q1: TJSONArray; q2: TJSONObject; q3: TJSONObject) : TJSONArray;
    function BuildQueryString(const q1: string) : TJSONObject;
    function Sign(const SignParamsDic: TDictionary<string,string>; AKey: string) : string;
    function CreateSignature(const AData, Akey: string): string;
    function ConverAndSortParamsToString(const SignParamsDic: TDictionary<string,string>): string;
    function GetUTCFormattedTime(const ACurrentTime: TDateTime): string;
    function RootNodeFromResponse(const AResponse: TJSONObject) : TJSONObject;
  end;

 var
 SignParamsDics: TDictionary<string, string>;

implementation

uses System.DateUtils, System.Rtti, REST.Exception, REST.JSON.Types, System.TypInfo,
  REST.Backend.Consts, IdHMACSHA1, IdGlobal, EncdDecd, IdMultipartFormData, IdHTTP, IdSSLOpenSSL;

procedure CheckUserName(const AUserName: string);
begin
  if AUserName = '' then
    raise EApp42APIError.Create('UserName required');
end;

procedure CheckObjectID(const AObjectID: string);
begin
  if AObjectID = '' then
    raise EApp42APIError.Create(sObjectIDRequired);
end;

procedure CheckAdminKey(const AAdminKey: string);
begin
  if AAdminKey = '' then
    raise EApp42APIError.Create('AdminKey required');
end;

procedure CheckSessionID(const SessionID: string);
begin
  if SessionID = '' then
    raise EApp42APIError.Create(sSessionIDRequired);
end;

procedure CheckAPIKey(const AKey: string);
begin
  if AKey = '' then
    raise EApp42APIError.Create(sAPIKeyRequired);
end;

procedure CheckBackendClass(const ABackendClassName: string);
begin
  if ABackendClassName = '' then
    raise EApp42APIError.Create(sBackendClassNameRequired);
end;

procedure CheckJSONObject(const AJSON: TJSONObject);
begin
  if AJSON = nil then
    raise EApp42APIError.Create(sJSONObjectRequired);
end;

constructor TApp42Api.Create(AOwner: TComponent;
  const AResponse: TRESTResponse);
begin
  inherited Create(AOwner);
  FConnectionInfo := TConnectionInfo.Create(cDefaultApiVersion, '');
  FRESTClient := TRESTClient.Create(nil);
  FRESTClient.SynchronizedEvents := False;
  FRequest := TRESTRequest.Create(nil);
  FRequest.SynchronizedEvents := False;
  FRequest.Client := FRESTClient;
  FOwnsResponse := AResponse = nil;
  if FOwnsResponse then
    FResponse := TRESTResponse.Create(nil)
  else
    FResponse := AResponse;
  FRequest.Response := FResponse;
  BaseURL := cDefaultBaseURL;
  ApplyConnectionInfo;
end;


function TApp42Api.CreateIOSInstallationObject(const ADeviceToken: string; ABadge: Integer;
  AChannels: array of string): TJSONObject;
var
  LArray: TJSONArray;
  S: string;
begin
  Result := TJSONObject.Create;
  Result.AddPair('deviceType', TJSONString.Create(TDeviceNames.IOS)); // Do not localize
  Result.AddPair('deviceToken', TJSONString.Create(ADeviceToken));    // Do not localize
  Result.AddPair('badge', TJSONNumber.Create(ABadge));                // Do not localize
  LArray := TJSONArray.Create;
  for S in AChannels do
    LArray.AddElement(TJSONString.Create(S));
  Result.AddPair('channels', LArray);   // empty channels
end;

function TApp42Api.CreateAndroidInstallationObject(const AInstallationID: string; AChannels: array of string): TJSONObject;
var
  LArray: TJSONArray;
  S: string;
begin
  Result := TJSONObject.Create;
  Result.AddPair('deviceType', TJSONString.Create(TDeviceNames.Android));   // Do not localize
  Result.AddPair('deviceToken', TJSONString.Create(AInstallationID));       // Do not localize
  LArray := TJSONArray.Create;
  for S in AChannels do
    LArray.AddElement(TJSONString.Create(S));
  Result.AddPair('channels', LArray);   // empty channels
end;

const
  sDBName = 'App42DB';
  sDefault = 'App42_DefaultAuth';
  sInstallations = 'installations';
  sUserCollectionName = 'App42Users';

  sApiVersion = 'version';      // Do not localize
  sApiKey = 'apiKey';           // Do not localize
  sSecretKey = 'secretKey';     // Do not localize
  sDefaultKey = 'loggedInUser'; // Do not localize
  sAdminKey = 'adminKey';       // Do not localize
  sSessionToken = 'sessionId';  // Do not localize
  sTimestamp = 'timeStamp';     // Do not localize

procedure TApp42Api.ApplyConnectionInfo;
begin
  FRESTClient.Params.AddHeader(sApiKey, FConnectionInfo.ApiKey);
  FRESTClient.Params.AddHeader(sApiVersion, FConnectionInfo.ApiVersion);
end;

procedure TApp42Api.AddAdminKey(const AKey: string);
begin
  CheckAdminKey(AKey);
  FRequest.Params.AddHeader(sAdminKey, AKey);
  SignParamsDics.Add(sAdminKey, FConnectionInfo.AdminKey); // Adding Admin Key For making Client Signature.
end;

procedure TApp42Api.AddSessionToken(const ASessionToken: string);
begin
  CheckSessionID(ASessionToken);
  FRequest.Params.AddHeader(sSessionToken, ASessionToken);
  if SignParamsDics.ContainsKey(sSessionToken) then
  SignParamsDics.Remove(sSessionToken);
  SignParamsDics.Add(sSessionToken, ASessionToken); // Adding session token For making Client Signature.
end;

procedure TApp42Api.AddAPIKey(const AKey: string);
begin
  CheckAPIKey(AKey);
  FRequest.Params.AddHeader(sSecretKey, AKey);
end;

procedure TApp42Api.AddDefaultAuth(const ADefault: string);
begin
//  CheckSessionID(ADefault);
//  FRequest.Params.AddHeader(sSessionToken, ADefault);
//  FRequest.Params.AddHeader(sAdminKey, FConnectionInfo.AdminKey);
//  SignParamsDics.Add(sAdminKey, FConnectionInfo.AdminKey); // Adding Admin Key For making Client Signature.
end;

procedure TApp42API.CheckAuthentication(AAuthentication: TAuthentications);
var
  LAuthentication: TAuthentication;
  LInvalid: string;
  LValid: string;
  LValidItems: TStrings;
begin
  LAuthentication := GetActualAuthentication;
  if not (LAuthentication in AAuthentication) then
  begin
    LInvalid :=  System.TypInfo.GetEnumName(TypeInfo(TAuthentication), Integer(LAuthentication));
    LValidItems := TStringList.Create;
    try
      for LAuthentication in AAuthentication do
        LValidItems.Add(System.TypInfo.GetEnumName(TypeInfo(TAuthentication), Integer(LAuthentication)));
      if LValidItems.Count = 1 then
        LValid := Format(sUseValidAuthentication, [LValidItems[0]])
      else
      begin
        LValid := LValidItems[LValidItems.Count - 1];
        LValidItems.Delete(LValidItems.Count-1);
        LValidItems.Delimiter := ',';
        LValid := Format(sUseValidAuthentications, [LValidItems.DelimitedText, LValid])
      end;

    finally
      LValidItems.Free;
    end;

    raise EApp42APIError.CreateFmt(sInvalidAuthenticationForThisOperation, [LInvalid, LValid]);
  end;
end;

function TApp42API.GetActualAuthentication: TAuthentication;
var
  LAuthentication: TAuthentication;
begin
  LAuthentication := FAuthentication;
  if LAuthentication = TAuthentication.Default then
    case FDefaultAuthentication of
      TDefaultAuthentication.AdminKey:
        LAuthentication := TAuthentication.AdminKey;
      TDefaultAuthentication.APIKey:
        LAuthentication := TAuthentication.ApiKey;
      TApp42Api.TDefaultAuthentication.Session:
        LAuthentication := TAuthentication.Session;
      TApp42Api.TDefaultAuthentication.None:
        LAuthentication := TAuthentication.None;
    else
      Assert(False);
    end;
  Result := LAuthentication;
end;

procedure TApp42Api.AddAuthParameters;
var
  LAuthentication: TAuthentication;
begin
  LAuthentication := GetActualAuthentication;
  AddAuthParameters(LAuthentication);
end;

procedure TApp42Api.AddAuthParameters(AAuthentication: TAuthentication);
var
  Today : TDateTime;
  LApp42Utils: TApp42Utils;
  LTimeStampStr: string;
begin
  Today:= TTimeZone.Local.ToUniversalTime(Now);
  LApp42Utils := TApp42Utils.Create;
  LTimeStampStr:= LApp42Utils.GetUTCFormattedTime(Today);
// Adding ApiKey, TimeStamp, Version for making client request Signature.
  SignParamsDics:= TDictionary<string,string>.create;
  SignParamsDics.Add(sApiKey,FConnectionInfo.ApiKey);
  SignParamsDics.Add(sTimestamp,LTimeStampStr);
  SignParamsDics.Add(sApiVersion,FConnectionInfo.ApiVersion);
// Adding TimeStamp to the heders of request for App42 (ApiKey and Version is Already added in ApplyConnectionInfo.).
  FRequest.Params.AddHeader(sTimestamp,LTimeStampStr);
  FRequest.Accept := 'application/json';
  case AAuthentication of
    TApp42Api.TAuthentication.APIKey:
      AddDefaultAuth(FSessionToken);
    TApp42Api.TAuthentication.AdminKey:
      AddAdminKey(ConnectionInfo.AdminKey);
    TApp42Api.TAuthentication.Session:
      AddSessionToken(FSessionToken);
    TApp42Api.TAuthentication.None:
      ;
  else
    Assert(False);
  end;
end;

function TApp42Api.CreateException(const ARequest: TRESTRequest;
  const AClass: TApp42APIErrorClass): EApp42APIError;
var
  LCode: Integer;
  LMessage: string;
  LJSONCode: TJSONValue;
  LJSONMessage: TJSONValue;
begin
  if ARequest.Response.JSONValue <> nil then
  begin
    LJSONCode := (ARequest.Response.JSONValue as TJSONObject).GetValue('code');     // Do not localize
    if LJSONCode <> nil then
      LCode := StrToInt(LJSONCode.Value)
    else
      LCode := 0;
    LJSONMessage := (ARequest.Response.JSONValue as TJSONObject).GetValue('error');     // Do not localize
    if LJSONMessage <> nil then
      LMessage := LJSONMessage.Value;
    if (LJSONCode <> nil) and (LJSONMessage <> nil) then
      Result :=  TApp42APIErrorClass.Create(LCode, LMessage)
    else if LJSONMessage <> nil then
      Result := TApp42APIErrorClass.Create(LMessage)
    else
      Result := TApp42APIErrorClass.Create(ARequest.Response.Content);
  end
  else
    Result := TApp42APIErrorClass.Create(ARequest.Response.Content);
end;

procedure TApp42Api.CheckForResponseError;
begin
  CheckForResponseError(FRequest);
end;

procedure TApp42Api.CheckForResponseError(const ARequest: TRESTRequest);
begin
  if ARequest.Response.StatusCode >= 300 then
  begin
    if (ARequest.Response.StatusCode >= 400) and (ARequest.Response.StatusCode < 500)
       and (ARequest.Response.JSONValue <> nil) then
    begin
      raise CreateException(ARequest, EApp42APIError);
    end
    else
      raise EApp42APIError.Create(ARequest.Response.Content);
  end
end;

procedure TApp42Api.CheckForResponseError(AValidStatusCodes: array of Integer);
begin
  CheckForResponseError(FRequest, AValidStatusCodes);
end;

procedure TApp42Api.CheckForResponseError(const ARequest: TRESTRequest; AValidStatusCodes: array of Integer);
var
  LCode: Integer;
  LResponseCode: Integer;
begin
  LResponseCode := ARequest.Response.StatusCode;

  for LCode in AValidStatusCodes do
    if LResponseCode = LCode then
      Exit; // Code is valid, exit with no exception
  CheckForResponseError(ARequest);
end;

function TApp42Api.DeleteClass(const AID: TObjectID): Boolean;
begin
  Result := DeleteClass(AID.BackendClassName, AID.ObjectID);
end;

function TApp42Api.DeleteResource(const AResource: string; AReset: Boolean): Boolean;
begin
  Assert(AResource <> '');
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := AResource;
  FRequest.Execute;
  CheckForResponseError([404]);
  Result := FRequest.Response.StatusCode <> 404
end;

//Method- DELETE
//url - https://api.shephertz.com/cloud/1.0/storage/deleteDocById/dbName/{DBName}/collectionName/{collectionName}/docId/{docId}
function TApp42Api.DeleteClass(const ABackendClassName: string; const AObjectID: string): Boolean;
var
 LSignature, LResource: string;
 LApp42Utils: TApp42Utils;
begin
try
  CheckBackendClass(ABackendClassName);
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('collectionName',ABackendClassName);
  SignParamsDics.Add('docId',AObjectID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  LResource := sStorage + '/deleteDocById/dbName/' + sDBName + '/collectionName/' + ABackendClassName + '/docId/' + AObjectID;
  Result := DeleteResource(LResource, False);
finally
 SignParamsDics.Free;
end;
end;

function TApp42Api.DeleteInstallation(const AObjectID: string): Boolean;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters(TAuthentication.AdminKey); // Required
  Result := DeleteResource(sInstallations + '/' + AObjectID, False);
end;


procedure TApp42Api.QueryInstallation(const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  QueryResource(sInstallations, sInstallations,  AQuery, AJSONArray, False);
end;

procedure TApp42Api.QueryInstallation(const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>);
var
  LJSONValue: TJSONValue;
  LList: TList<TObjectID>;
  LInstallation: TObjectID;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters(TAuthentication.AdminKey);     // Master required
  QueryResource(sInstallations, sInstallations, AQuery, AJSONArray, False);
  LList := TList<TObjectID>.Create;
  try
    for LJSONValue in AJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        // Blank backend class name
        LInstallation := ObjectIDFromObject('', TJSONObject(LJSONValue));
        LList.Add(LInstallation);
      end
      else
        raise EApp42APIError.Create(sJSONObjectExpected);
    end;
    AObjects := LList.ToArray;
  finally
    LList.Free;
  end;
end;

destructor TApp42Api.Destroy;
begin
  FRESTClient.Free;
  FRequest.Free;
  if FOwnsResponse then
    FResponse.Free;
  inherited;
end;


procedure TApp42Api.QueryResource(const AResource: string; ACollection: string; const AQuery: array of string; const AJSONArray: TJSONArray; AReset: Boolean);
var
  LRoot: TJSONArray;
  S: string;
  LSignature: string;
  I: Integer;
  LJSONValue: TJSONValue;
  LResponse,LApp42,LSuccess,LStorage: TJSONObject;

  LQueryString: string;
  LExpressionJson: TJSONObject;
  LExpressionJson2: TJSONObject;
  LExpressionJson3: TJSONObject;
  LExpressionJsonArray: TJSONArray;
  LCompoundExpressionArray: TJSONArray;
  LApp42Utils: TApp42Utils;
  LNotRepeated: Boolean;

  procedure AddMetaHeaders(Str: string);
  var
  J:Integer;
  begin
 // J:=0;
   J := S.IndexOf('=');
   if J > 0 then
    Request.Params.AddHeader(S.Substring(0, J).Trim, S.Substring(J+1).Trim);
   end;
begin
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmGET;
  LApp42Utils := TApp42Utils.Create;
 LExpressionJsonArray:= TJSONArray.Create;
// LCompoundExpressionArray := TJSONArray.Create;
 LExpressionJson2 := nil;
try
 LNotRepeated := true;
 I:=0;
   if Length(AQuery) > 1 then
 begin
   for S in AQuery do
  begin
  if S.Contains('orderByAscending=') then
  AddMetaHeaders(S)
  else if S.Contains('orderByDescending=') then
  AddMetaHeaders(S)
  else if S.Contains('max=') then
  AddMetaHeaders(S)
  else if S.Contains('offset=') then
  AddMetaHeaders(S)
  else if I<=2 then
  begin
  I:=I+1;
 // LExpressionJson := TJSONObject.Create;
  LExpressionJson := LApp42Utils.BuildQueryString(S);
  LExpressionJsonArray.AddElement(LExpressionJson);
  end
  else
  begin
  if LNotRepeated  then
  begin
  LNotRepeated := false;
 // LExpressionJson2 := TJSONObject.Create;
  LExpressionJson2 := LApp42Utils.BuildQueryString(S);
  end
  else
  begin
 // LExpressionJson3 := TJSONObject.Create;
  LExpressionJson3 := LApp42Utils.BuildQueryString(S);
  LNotRepeated := true;
  LCompoundExpressionArray := LApp42Utils.BuildCompoundQueryString(LExpressionJsonArray,LExpressionJson2,LExpressionJson3);
  LExpressionJsonArray := LCompoundExpressionArray;

 end;
  end;
  end;

   end
   else
   begin
    for S in AQuery do
  begin
  if S.Contains('orderByAscending=') then
  AddMetaHeaders(S)
  else if S.Contains('orderByDescending=') then
  AddMetaHeaders(S)
  else if S.Contains('max=') then
  AddMetaHeaders(S)
  else if S.Contains('offset=') then
  AddMetaHeaders(S)
  else
  begin
  //  LExpressionJson := TJSONObject.Create;
    LExpressionJson := LApp42Utils.BuildQueryString(S);
    LExpressionJsonArray.AddElement(LExpressionJson);
  end;

  end;
   end;
  LQueryString := LExpressionJsonArray.ToString;
finally
 LExpressionJsonArray.Free;
end;

if LQueryString.Equals('[]') then
begin    // findAll
  FRequest.Resource := AResource.Replace('findDocsByQuery','findAll');
end
else
begin
    FRequest.Resource := AResource;
    SignParamsDics.Add('jsonQuery',LQueryString);
    Request.Params.AddHeader('jsonQuery', LQueryString);
end;
try
    SignParamsDics.Add('collectionName',ACollection);
    SignParamsDics.Add('dbName',sDBName);
    LApp42Utils := TApp42Utils.Create;
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);

  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    // {"results":[{"Age":1,"age":42,"name":"Elmo","createdAt":"2013-11-02T18:09:30.751Z","updatedAt":"2013-11-02T18:11:27.910Z","objectId":"dB9jr8Su8u"},{"age":43,"name":"Elmo","createdAt":"2013-11-02T18:17:48.564Z","updatedAt":"2013-11-02T18:18:03.863Z","objectId":"cT7blzwGxV"},
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LApp42    := LResponse.Get('app42').JsonValue as TJSONObject;
    LSuccess := LApp42.Get('response').JsonValue as TJSONObject;
    LStorage := LSuccess.Get('storage').JsonValue as TJSONObject;
    LRoot := LStorage.Get('jsonDoc').JsonValue as TJSONArray; // Do not localize
    for LJSONValue in LRoot do
      AJSONArray.AddElement(TJSONValue(LJSONValue.Clone))
  end;
finally
 SignParamsDics.Free;
end;
end;

procedure TApp42Api.QueryClass(const ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray);
var
  LResource: string;
begin
  LResource:= sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + ABackendClassName;
  QueryResource(LResource, ABackendClassname, AQuery, AJSONArray, True);
end;

procedure TApp42Api.QueryClass(const ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>);
var
  LJSONValue: TJSONValue;
  LList: TList<TObjectID>;
  LObjectID: TObjectID;
  LResource: string;
begin
  CheckBackendClass(ABackendClassName);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  LResource:= sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + ABackendClassName;
  QueryResource(LResource, ABackendClassname, AQuery, AJSONArray, False);
  LList := TList<TObjectID>.Create;
  try
    for LJSONValue in AJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LObjectID := ObjectIDFromObject(ABackendClassName, TJSONObject(LJSONValue));
        LList.Add(LObjectID);
      end
      else
        raise EApp42APIError.Create(sJSONObjectExpected);
    end;
    AObjects := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function ValueToJsonValue(AValue: TValue): TJSONValue;
begin
  if AValue.IsType<Int64> then
    Result := TJSONNumber.Create(AValue.AsInt64)
  else if AValue.IsType<Extended> then
    Result := TJSONNumber.Create(AValue.AsExtended)
  else if AValue.IsType<string> then
    Result := TJSONString.Create(AValue.AsString)
  else
    Result := TJSONString.Create(AValue.ToString)
end;

function TApp42Api.FindClass(const ABackendClassName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray; AProc: TFindObjectProc): Boolean;
var
  LResponse: TJSONObject;
  LSignature: string;
  LApp42Utils: TApp42Utils;
begin
try
  CheckBackendClass(ABackendClassName);
  CheckObjectID(AObjectID);
  Result := False;
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('collectionName',ABackendClassName);
  SignParamsDics.Add('docId',AObjectID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sStorage + '/findDocById/dbName/' + sDBName + '/collectionName/' + ABackendClassName + '/docId/' + AObjectID;
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    // '{"app42":{"response":{"success":true,"storage":{"dbName":"queryTest","collectionName":"MyCollection","jsonDoc":{"_id":{"$oid":"538edd84ae5975ed944c3407"},"address":"sample address1","name":"sample name1","_$createdAt":"2014-06-04T08:49:08.302Z","_$updatedAt":"2014-06-04T08:49:08.302Z"}}}}}'
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
    AFoundObject := ObjectIDFromObject(ABackendClassName, LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
    begin
      AProc(AFoundObject, LResponse);
    end;
  end;
finally
  SignParamsDics.Free;
end;
end;

function TApp42Api.FindClass(const ABackendClassName, AObjectID: string; AProc: TFindObjectProc): Boolean;
var
  LObjectID: TObjectID;
begin
  Result := FindClass(ABackendClassName, AObjectID, LObjectID, nil, AProc);
end;

function TApp42Api.FindClass(const ABackendClassName, AObjectID: string; out AFoundObjectID: TObjectID; const AFoundJSON: TJSONArray): Boolean;
begin
  Result := FindClass(ABackendClassName, AObjectID, AFoundObjectID, AFoundJSON, nil);
end;

function TApp42Api.FindClass(const AID: TObjectID; out AFoundObjectID: TObjectID; const AFoundJSON: TJSONArray): Boolean;
begin
  Result := FindClass(AID.BackendClassName, AID.ObjectID, AFoundObjectID, AFoundJSON, nil);
end;

function TApp42Api.FindClass(const AID: TObjectID; AProc: TFindObjectProc): Boolean;
var
  LObjectID: TObjectID;
begin
  Result := FindClass(AID.BackendClassName, AID.ObjectID, LObjectID, nil, AProc);
end;

function TApp42Api.GetLoggedIn: Boolean;
begin
  Result := FSessionToken <> '';
end;

procedure TApp42Api.PushBody(const AMessage: TJSONObject);
begin
 FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sPush;
  FRequest.AddBody(AMessage);
  FRequest.Execute;
  CheckForResponseError;
end;



procedure TApp42Api.PushBroadcast(const AData: TJSONObject);
begin
  PushToDevices(TArray<string>.Create(TDeviceNames.Android, TDeviceNames.IOS), AData);
end;


procedure TApp42Api.PushToChannels(const AChannels: array of string; const AData: TJSONObject);
var
  LJSON: TJSONObject;
  LChannels: TJSONArray;
  S: string;
begin
  if Length(AChannels) = 0 then
    raise EApp42APIError.Create(sChannelNamesExpected);
  LJSON := TJSONObject.Create;
  try
    LChannels := TJSONArray.Create;
    for S in AChannels do
      LChannels.Add(S);
    LJSON.AddPair('channels', LChannels);                    // Do not localize
    LJSON.AddPair('data', AData.Clone as TJSONObject);       // Do not localize
    PushBody(LJSON);
  finally
    LJSON.Free;
  end;
end;


procedure TApp42Api.PushWhere(const AWhere: TJSONObject; const AData: TJSONObject);
var
  LJSON: TJSONObject;
  LDevices : TJSONArray;
  Today : TDateTime;
//  TimeZone: TTimeZone;
  LTimeStampStr: string;
  LSignature, LBody: string;
  LApp42Utils: TApp42Utils;
begin
  LApp42Utils := TApp42Utils.Create;
  Today:= TTimeZone.Local.ToUniversalTime(Now);
  LTimeStampStr:= LApp42Utils.GetUTCFormattedTime(Today);
  LJSON := TJSONObject.Create;
  LDevices := TJSONArray.Create;
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sPush+ '/sendTargetPush/' + sDBName + '/' + sUserCollectionName;
  try
    if AWhere <> nil then
   LDevices.AddElement(AWhere.Clone as TJSONObject);
  FRequest.Execute;
  CheckForResponseError;
    if AData <> nil then
      LJSON.AddPair('payload', AData.Clone as TJSONObject);           // Do not localize
      LJSON.AddPair('expiry', LTimeStampStr);                        // Do not localize
      LBody := '{"app42":{"push":{"message":'+LJSON.ToString+'}}';  // Do not localize
  // Adding Information About Request for creating client signature.
  SignParamsDics.Add('body',LBody);
  SignParamsDics.Add('jsonQuery',LDevices.ToString);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  // Adding Signature To The Headers Of Request.
  Request.Params.AddHeader('signature',LSignature);
  FRequest.AddParameter('jsonQuery',LDevices.ToString);
  FRequest.AddBody(LBody, ctAPPLICATION_JSON);
  FRequest.Execute;
  CheckForResponseError;
    PushBody(LJSON);
  finally
    LJSON.Free;
  end;
end;


procedure TApp42Api.PushToDevices(const ADevices: array of string; const AData: TJSONObject);
var
  LExpression : TJSONObject;
  S : string;
  LString : TStringBuilder;
begin
  if Length(ADevices) = 0 then
    raise EApp42APIError.Create(sDeviceNamesExpected);
    LString := TStringBuilder.Create('[');
    for S in ADevices do
    LString.Append(S);
    LString.Append(']');

  LExpression := TJSONObject.Create;
  LExpression.AddPair('key','pushDeviceType');
  LExpression.AddPair('operator','$in');
  LExpression.AddPair('value', LString.ToString);
  try
    PushWhere(LExpression, AData);
  finally
    LExpression.Free;
  end;
end;

function TApp42Api.ObjectIDFromObject(const ABackendClassName: string; const AJSONObject: TJSONObject): TObjectID;
var
  LIdObj: TJSONObject;
  LObjectID: string;
begin
  LIdObj := AJSONObject.Get('_id').JsonValue as TJSONObject;    // Do not localize
  LObjectID := LIdObj.Get('$oid').JsonValue.Value;              // Do not localize
  Result := ObjectIDFromObject(ABackendClassName, LObjectID, AJSONObject);
end;

function TApp42Api.ObjectIDFromObject(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject): TObjectID;
begin
  Result := TObjectID.Create(ABackendClassName, AObjectID);
  if AJSONObject.GetValue('_$createdAt') <> nil then            // Do not localize
    Result.FCreatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$createdAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);    // Do not localize
  if AJSONObject.GetValue('_$updatedAt') <> nil then            // Do not localize
    Result.FUpdatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$updatedAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);    // Do not localize
end;

function TApp42Api.FileIDFromObject(const AFileName: string; const AJSONObject: TJSONObject): TFile;
var
  LName: string;
begin
  if AJSONObject.GetValue('name') <> nil then        // Do not localize
    LName := AJSONObject.GetValue('name').Value;      // Do not localize
  Result := TFile.Create(LName);
  Result.FFileName := AFileName;
  if AJSONObject.GetValue('url') <> nil then           // Do not localize
    Result.FDownloadURL := AJSONObject.GetValue('url').Value;      // Do not localize
end;

procedure TApp42Api.Login(const ALogin: TLogin);
begin
  Login(ALogin.SessionToken);
end;

procedure TApp42Api.Login(const ASessionToken: string);
begin
  FSessionToken := ASessionToken;
  FAuthentication := TAuthentication.Session;
end;

function TApp42Api.LoginFromObject(const AUserName: string; const AJSONObject: TJSONObject): TLogin;
var
  LUser: TUser;
  LSessionToken: string;
  LUserObject : TJSONObject;
begin
  if AJSONObject.GetValue('sessionId') <> nil then               // Do not localize
  LSessionToken := AJSONObject.GetValue('sessionId').Value;    // Do not localize
  LUserObject := UserFromUserName(AUserName);
  LUser := UserFromObject(AUserName, LUserObject);
  Assert(LSessionToken <> '');
  CreateSessionFromLogin(AUserName, LSessionToken, LUser);
  Result := TLogin.Create(LSessionToken, LUser);
end;

function TApp42Api.UpdatedAtFromObject(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject): TUpdatedAt;
var
  LUpdatedAt: TDateTime;
begin
  if AJSONObject.GetValue('_$updatedAt') <> nil then                 // Do not localize
    LUpdatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$updatedAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC)  // Do not localize
  else
    LUpdatedAt := 0;
  Result := TUpdatedAt.Create(ABackendClassName, AObjectID, LUpdatedAt);
end;

function TApp42Api.UserFromObject(const AUserName: string; const AJSONObject: TJSONObject): TUser;
var
LUserObjectId: TJSONObject;
begin
  LUserObjectId := TJSONObject.Create;
  Result := TUser.Create(AUserName);
  if AJSONObject.GetValue('_$createdAt') <> nil then      // Do not localize
    Result.FCreatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$createdAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);   // Do not localize
  if AJSONObject.GetValue('_$updatedAt') <> nil then
    Result.FUpdatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$updatedAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);   // Do not localize
  if AJSONObject.GetValue('_id') <> nil then
    LUserObjectId := AJSONObject.Get('_id').JsonValue as TJSONObject;                                                                         // Do not localize
    Result.FObjectID := LUserObjectId.GetValue('$oid').Value;                                                                 // Do not localize
end;

function TApp42Api.UserFromObject(const AJSONObject: TJSONObject): TUser;
var
  LUserName: string;
begin
  if AJSONObject.GetValue('userName') <> nil then            // Do not localize
    LUserName := AJSONObject.GetValue('userName').Value;     // Do not localize
  Assert(LUserName <> '');
  Result := UserFromObject(LUserName, AJSONObject);
end;

procedure TApp42Api.PostResource(const AResource: string; const AJSON: TJSONObject; AReset: Boolean);
begin
  CheckJSONObject(AJSON);
  // NEW : POST
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := AResource;
  FRequest.AddBody(AJSON.ToString, ctAPPLICATION_JSON);
  FRequest.Execute;
  CheckForResponseError;
end;

procedure TApp42Api.CreateClass(const ABackendClassName: string; const AJSON: TJSONObject;
  out ANewObject: TObjectID);
begin
  CreateClass(ABackendClassName, nil, AJSON, ANewObject);
end;

procedure TApp42Api.CreateClass(const ABackendClassName: string; const AACL, AJSON: TJSONObject;
  out ANewObject: TObjectID);
var
  LResponse,LJSON: TJSONObject;
  LBody, LJsonString, LSignature, LResource: string;
  LApp42Utils: TApp42Utils;

//Applying ACL if found.
  procedure ApplyACL(ACL: TJSONObject);
  var
  LACLArray: TJSONArray;
  LACLObj: TJSONObject;
  LACLPair: TJSONPair;
  I: Integer;
  LList: TList<TJSONPair>;
  begin

// Creating ACL JSONObjects Array as App42 Accepts. [{"PUBLIC":"R"},{"PUBLIC":"W"},{"userName":"W"},{"userName":"R"}].
    LACLArray := TJSONArray.Create;
      for I := 0 to AACL.Count - 1 do
    begin
      LACLPair := AACL.Pairs[I];
      LACLObj := TJSONObject.Create;
      LList := TList<TJSONPair>.Create;
      try
      LList.Add(LACLPair);
      LACLObj.SetPairs(LList);
      LACLArray.AddElement(LACLObj);
      finally
        LList.Free;
      end;
    end;
    Request.Params.AddHeader('dataACL',LACLArray.ToString);     // Do not localize
  end;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  CheckBackendClass(ABackendClassName);
  LJSON := nil;
  try
    if (AACL <> nil) and (AJSON <> nil) then
    begin
      LJSON := AJSON.Clone as TJSONObject;
      ApplyACL(AACL);
      LJsonString:= LJSON.ToString;
    end
    else if AACL <> nil then
    begin ApplyACL(AACL);
   // Sending Blank Json.
    LJsonString:='{}';
    end
    else
    begin
    LJSON :=  AJSON;
    LJsonString:= LJSON.ToString;
    end;
    LBody := '{"app42":{"storage":{"jsonDoc":'+LJsonString+'}}}';
    LResource := sStorage + '/insert/dbName/' + sDBName + '/collectionName/' + ABackendClassName;
    // Adding Information About Request for creating client signature.
    SignParamsDics.Add('body',LBody);
    SignParamsDics.Add('collectionName',ABackendClassName);
    SignParamsDics.Add('dbName',sDBName);
    LApp42Utils := TApp42Utils.Create;
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    // Adding Signature To The Headers Of Request.
    Request.Params.AddHeader('signature',LSignature);
    PostResource(LResource, TJSONObject.ParseJSONValue(LBody) as TJSONObject, False);
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
    // {"app42":{"response":{"success":true,"storage":{"dbName":"queryTest","collectionName":"MyCollection","jsonDoc":{"address":"sample address3","name":"sample name3","_$createdAt":"2014-06-04T06:07:17.295Z","_$updatedAt":"2014-06-04T06:07:17.295Z","_id":{"$oid":"538eb795ae5975ed944c33d8"}}}}}}
    ANewObject := ObjectIDFromObject(ABackendClassName, LResponse);
  finally
    if (LJSON <> AACL) and (LJSON <> AJSON) then
      LJSON.Free;
      SignParamsDics.Free;
  end;
end;

procedure TApp42Api.PutResource(const AResource: string; const AJSONObject: TJSONObject; AReset: Boolean);
begin
  CheckJSONObject(AJSONObject);
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmPUT;
  FRequest.Resource := AResource;
  FRequest.AddBody(AJSONObject.ToString, ctAPPLICATION_JSON);
  FRequest.Execute;
  CheckForResponseError;
end;

procedure TApp42Api.UpdateClass(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
  LBody, LSignature, LResource: string;
  LApp42Utils : TApp42Utils;
begin
try
  CheckBackendClass(ABackendClassName);
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  LBody := '{"app42":{"storage":{"jsonDoc":'+AJSONObject.ToString+'}}}';  // Do not localize
  SignParamsDics.Add('body',LBody);
  SignParamsDics.Add('collectionName',ABackendClassName);
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('docId',AObjectID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  LResource := sStorage + '/updateKeysByDocId/dbName/' + sDBName + '/collectionName/' + ABackendClassName + '/docId/' + AObjectID;
  PutResource(LResource, TJSONObject.ParseJSONValue(LBody) as TJSONObject, False);
 //  '{"app42":{"response":{"success":true,"storage":{"dbName":"queryTest","collectionName":"MyCollection","jsonDoc":{"_id":{"$oid":"538ee218ae5975ed944c340d"},"address":"new york","name":"sample name1","_$createdAt":"2014-06-04T09:08:40.169Z","_$updatedAt":"2014-06-04T09:09:01.545Z"}}}}}'
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
  // "_$updatedAt":"2014-06-04T09:09:01.545Z"
  AUpdatedAt := UpdatedAtFromObject(ABackendClassName, AObjectID, LResponse);
finally
  SignParamsDics.Free;
end;
end;

procedure TApp42Api.UpdateClass(const AID: TObjectID; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
begin
  UpdateClass(AID.BackendClassName, AID.ObjectID, AJSONObject, AUpdatedAt);
end;

procedure TApp42Api.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
  FRESTClient.BaseURL := Value;
end;

procedure TApp42Api.SetConnectionInfo(const Value: TConnectioninfo);
begin
  FConnectionInfo := Value;
  ApplyConnectionInfo;
end;

procedure TApp42Api.UploadFile(const AFileName: string; const AContentType: string;  out ANewFile: TFile);
var
  LStream: TFileStream;
begin
  LStream := TFileStream.Create(AFileName, 0);
  try
    UploadFile(AFileName, LStream, AContentType, ANewFile);
  finally
    LStream.Free;
  end;
end;

//Method- MultiPart Post
//url - https://api.shephertz.com/cloud/1.0/upload/
procedure TApp42Api.UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string; out ANewFile: TFile);
var
  LResponse, LFile: TJSONObject;
  LApp42Utils: TApp42Utils;
  LSignature, LTimeStampStr, LMultiPartBaseUrl, LUniqeFileId, LResponseStr: string;
  Params: TIdMultipartFormDataStream;
  http: TIdHTTP;
  Today : TDateTime;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  LContentType: TRESTContentType;
begin
  http:=TIdHTTP.Create(nil);
  Today:= TTimeZone.Local.ToUniversalTime(Now);
  LApp42Utils := TApp42Utils.Create;
  LTimeStampStr:= LApp42Utils.GetUTCFormattedTime(Today);
  http.Request.CustomHeaders.AddValue(sTimestamp,LTimeStampStr);
  SignParamsDics:= TDictionary<string,string>.create;
  if FSessionToken <> '' then
  begin
  SignParamsDics.Add(sSessionToken, FSessionToken);
  http.Request.CustomHeaders.AddValue(sSessionToken,FSessionToken);
  end
  else
  begin
  SignParamsDics.Add(sAdminKey, FConnectionInfo.AdminKey);
  http.Request.CustomHeaders.AddValue(sAdminKey,FConnectionInfo.AdminKey);
  end;
  SignParamsDics.Add(sApiKey,FConnectionInfo.ApiKey);
  SignParamsDics.Add(sTimestamp,LTimeStampStr);
  SignParamsDics.Add(sApiVersion,FConnectionInfo.ApiVersion);
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
 Params:=Tidmultipartformdatastream.Create;
try
  LUniqeFileId := LTimeStampStr.Replace(':','e').Replace('-','a').Replace('.','b').Replace('20','f').Replace('1','i').Replace('4','');

  if AContentType = '' then
    LContentType := TRESTContentType.ctAPPLICATION_OCTET_STREAM
  else
    LContentType :=  ContentTypeFromString(AContentType);
  SignParamsDics.Add('type', ContentTypeToString(LContentType));
  SignParamsDics.Add('name',LUniqeFileId);
  SignParamsDics.Add('description',AFileName);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics, FConnectionInfo.SecretKey);
  http.Request.CustomHeaders.AddValue('signature',LSignature);

   Params.AddFormField('uploadFile', ContentTypeToString(LContentType), '', AStream, AFileName);
   Params.AddFormField('name',LUniqeFileId);
   Params.AddFormField('type', ContentTypeToString(LContentType));
   Params.AddFormField('description',AFileName);
  http.IOHandler:=LHandler;
  http.Request.Accept := 'application/json';
  http.Request.CustomHeaders.AddValue(sApiKey, FConnectionInfo.ApiKey);
  http.Request.CustomHeaders.AddValue(sApiVersion, FConnectionInfo.ApiVersion);
  LMultiPartBaseUrl := cDefaultBaseURL+sFiles;
  LResponseStr := http.Post(LMultiPartBaseUrl,Params);
  LResponse := TJsonObject.ParseJsonValue(LResponseStr) as TJSONObject;
  LFile := LApp42Utils.RootNodeFromResponse(LResponse);
  ANewFile := FileIDFromObject(AFileName, LFile);
finally
  http.Free;
  SignParamsDics.Free;
  Params.Free;
  LHandler.Free;
end;
end;

//Method- DELETE
//url - https://api.shephertz.com/cloud/1.0/upload/FileName
function TApp42Api.DeleteFile(const AFileID: TFile): Boolean;
var
  LApp42Utils: TApp42Utils;
  LSignature: string;
begin
try
  FRequest.ResetToDefaults;
   AddAuthParameters;
   AddAdminKey(FConnectionInfo.AdminKey);
    SignParamsDics.Add('name',AFileID.Name);
    LApp42Utils := TApp42Utils.Create;
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
  Result := DeleteResource(sFiles + '/' + AFileID.Name, False);
finally
 SignParamsDics.Free;
end;
end;


procedure TApp42Api.UploadInstallation(const AJSON: TJSONObject; out ANewObject: TObjectID);
var
  LResponse: TJSONObject;
begin
  PostResource(sInstallations, AJSON, True);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  ANewObject := ObjectIDFromObject('', LResponse);
end;


procedure TApp42Api.UpdateInstallation(const AObjectID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
begin
  CheckObjectID(AObjectID);
  PutResource(sInstallations + '/' + AObjectID, AJSONObject, True);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  // '{"updatedAt":"2013-10-16T20:21:57.326Z"}'
  AUpdatedAt := UpdatedAtFromObject('', AObjectID, LResponse);
end;



function TApp42Api.DeleteUser(const AObjectID: string): Boolean;
var
LResource, LSignature, LUserName : string;
LApp42Utils: TApp42Utils;
LResponse: TJSONObject;
begin
try
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  // This operation require AdminKey or session authentication
  CheckAuthentication([TAuthentication.AdminKey, TAuthentication.Session]);
  SignParamsDics.Add('dbName', sDBName);
  SignParamsDics.Add('collectionName', sUserCollectionName);
  SignParamsDics.Add('docId', AObjectID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  LResource := sStorage + '/deleteDocById/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + AObjectID;
  Result := DeleteResource(LResource, False);
  if Result then
  begin
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
  LUserName := LResponse.GetValue('userName').Value;
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('userName', LUserName);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  Request.Params.AddHeader('deletePermanent','true');
  Result := DeleteResource(sUsers + '/' + LUserName, False);
  end;
finally
SignParamsDics.Free;
end;
end;

function TApp42Api.DeleteUser(const ALogin: TLogin): Boolean;
var
LResource, LSignature, LUserName : string;
LApp42Utils: TApp42Utils;
LResponse: TJSONObject;
begin
try
  CheckObjectID(ALogin.User.ObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  AddSessionToken(ALogin.SessionToken);
  SignParamsDics.Add('dbName', sDBName);
  SignParamsDics.Add('collectionName', sUserCollectionName);
  SignParamsDics.Add('docId', ALogin.User.ObjectID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  LResource := sStorage + '/deleteDocById/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + ALogin.User.ObjectID;
  // This operation require AdminKey or session authentication
  Result := DeleteResource(LResource, False);
  if Result then
  begin
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
  LUserName := LResponse.GetValue('userName').Value;
  FRequest.ResetToDefaults;
  AddAuthParameters;
  AddSessionToken(ALogin.SessionToken);
  SignParamsDics.Add('userName', LUserName);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  Request.Params.AddHeader('deletePermanent','true');
  Result := DeleteResource(sUsers + '/' + LUserName, False);
  end;
finally
  SignParamsDics.Free;
end;
end;


function TApp42API.RetrieveUser(const ASessionID, AObjectID: string; out AUser: TUser; const AJSON: TJSONArray;  AProc: TRetrieveUserProc; AReset: Boolean): Boolean;
var
  LResponse: TJSONObject;
  LSignature: string;
  LApp42Utils: TApp42Utils;
begin
try
  Result := False;
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  if ASessionID <> '' then
  AddSessionToken(ASessionID);
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sStorage + '/findDocById/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + AObjectID;
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('collectionName', sUserCollectionName);
  SignParamsDics.Add('docId',AObjectID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
    AUser := UserFromObject(LResponse);
    if AJSON <> nil then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LResponse);
  end;
finally
 SignParamsDics.Free;
end;
end;

//Method - GET
//URL - https://api.shephertz.com/cloud/1.0/storage/findDocById/dbName/{DBName}/collectionName/{CollectionName}/docId/{AObjectID};
function TApp42API.RetrieveLoggedInUser(const ASessionID, AObjectID: string; out AUser: TUser; const AJSON: TJSONArray;  AProc: TRetrieveUserProc; AReset: Boolean): Boolean;
var
  LResponse, LUser: TJSONObject;
  LSessionId, LSignature: string;
  LApp42Utils: TApp42Utils;
begin
try
  Result := False;
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  if ASessionID <> '' then
  LSessionId:= ASessionID
  else
  LSessionId:= FSessionToken;
  FRequest.Resource := sSession + '/id/' + LSessionId;
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LResponse :=  LApp42Utils.RootNodeFromResponse(LResponse);
    AUser := UserFromObject(LResponse);
    LUser := UserFromUserName(AUser.FUserName);
    if AJSON <> nil then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LUser);
  end;
finally
 SignParamsDics.Free;
end;
end;

function TApp42API.RetrieveUser(const AObjectID: string; AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser('', AObjectID, LUser, nil, AProc, True);
end;

function TApp42API.RetrieveUser(const ALogin: TLogin; AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser(ALogin.SessionToken, ALogin.User.ObjectID, LUser, nil, AProc, True);
end;

function TApp42API.RetrieveUser(const ALogin: TLogin;  out AUser: TUser; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser(ALogin.SessionToken, ALogin.User.ObjectID, AUser, AJSON, nil, True);
end;

function TApp42API.RetrieveUser(const AObjectID: string; out AUser: TUser; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser('', AObjectID, AUser, AJSON, nil, True);
end;



function TApp42API.RetrieveCurrentUser(const ASessionToken: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean;
begin
  Result := RetrieveLoggedInUser(ASessionToken, 'currentUser', AUser, AJSON, AProc, True);    // Do not localize
end;

function TApp42API.RetrieveCurrentUser(AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveCurrentUser('', LUser, nil, AProc);
end;

function TApp42API.RetrieveCurrentUser(const ALogin: TLogin; AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveCurrentUser(ALogin.SessionToken, LUser, nil, AProc);
end;

function TApp42API.RetrieveCurrentUser(const ALogin: TLogin; const AJSON: TJSONArray): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveCurrentUser(ALogin.SessionToken, LUser, AJSON, nil);
end;

function TApp42API.RetrieveCurrentUser(out AUser: TUser; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveCurrentUser('', AUser, AJSON, nil);
end;

function TApp42Api.QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean;
var
  LUser: TJSONObject;
begin
    LUser := UserFromUserName(AUserName);
    if LUser <> nil then
//    Result := LUser <> nil
//    else
    begin
     AUser := UserFromObject(AUserName, LUser);
    if Assigned(AJSON) then
      AJSON.AddElement(LUser.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LUser);
    end;
      Result := LUser <> nil;
end;

function TApp42Api.QueryUserName(const AUserName: string; AProc: TQueryUserNameProc): Boolean;
var
  LUser: TUser;
begin
  Result := QueryUserName(AUserName, LUser, nil, AProc);
end;

function TApp42Api.QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray = nil): Boolean;
begin
  Result := QueryUserName(AUserName, AUser, AJSON, nil);
end;



procedure TApp42Api.LoginUser(const AUserName, APassword: string; AProc: TLoginProc);
var
  LUser, LResponse: TJsonObject;
  LApp42Utils: TApp42Utils;
  LLogin: TLogin;
  LSignature, LBody : string;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUsers+'/authenticateAndCreateSession'; // do not localize
  LUser := TJSONObject.Create;
  LApp42Utils := TApp42Utils.Create;
try
  LUser.AddPair('userName', AUserName); // Do not localize
  LUser.AddPair('password', APassword); // Do not localize
  LBody := '{"app42":{"user":'+LUser.ToString+'}}';
  SignParamsDics.Add('body',LBody);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.AddBody(LBody, ctAPPLICATION_JSON);
  FRequest.Execute;
  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
  if Assigned(AProc) then
  begin
    LLogin := LoginFromObject(AUserName, LResponse);
    AProc(LLogin, LResponse);
  end;
finally
 LUser.Free;
 SignParamsDics.Free;
end;
end;

procedure TApp42Api.Logout;
begin
  FSessionToken := '';
  if FAuthentication = TAuthentication.Session then
    FAuthentication := TAuthentication.Default;
end;

procedure TApp42Api.LoginUser(const AUserName, APassword: string; out ALogin: TLogin; const AJSONArray: TJSONArray);
var
  LLogin: TLogin;
begin
  LoginUser(AUserName, APassword,
    procedure(const ALocalLogin: TLogin; const AUserObject: TJSONObject)
    begin
      LLogin := ALocalLogin;
      if Assigned(AJSONArray) then
        AJSONArray.Add(AUserObject);
    end);
  ALogin := LLogin;
end;


procedure TApp42Api.SignupUser(const AUserName, APassword: string; const AUserFields: TJSONObject;
  out ANewUser: TLogin);
var
  LUser, LUserFields, LResponse, LDBCredentials: TJSONObject;
  LApp42Utils: TApp42Utils;
  LSignature, LBody : string;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUsers;
  LUser := TJSONObject.Create;
  LDBCredentials:= TJSONObject.Create;
  if AUserFields <> nil then
  begin
    LUserFields := AUserFields.Clone as TJSONObject;
    LUserFields.AddPair('userName', AUserName);
  end
  else
  begin
    LUserFields := TJSONObject.Create;
    LUserFields.AddPair('userName', AUserName);
  end;
try
    LDBCredentials.AddPair('dbName', sDBName);  // Do not localize
    LDBCredentials.AddPair('collectionName', sUserCollectionName); // Do not localize
    // Adding UserDetails to headers With DBName And Collection Name.
    Request.Params.AddHeader('jsonObject', LUserFields.ToString);
    Request.Params.AddHeader('dbCredentials',LDBCredentials.ToString);
    LUser.AddPair('userName', AUserName); // Do not localize
    LUser.AddPair('password', APassword); // Do not localize
    LUser.AddPair('email', AUserName); // Do not localize
   // Creating JSON Body for User Post Request.
    LBody := '{"app42":{"user":'+LUser.ToString+'}}';  // Do not localize
    FRequest.AddBody(LBody, ctAPPLICATION_JSON);
    SignParamsDics.Add('body',LBody);
    LApp42Utils := TApp42Utils.Create;
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
    FRequest.Execute;
    CheckForResponseError([201]);
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
    ANewUser := LoginFromObject(AUserName, LResponse);
  finally
    LUser.Free;
    LUserFields.Free;
    LDBCredentials.Free;
    SignParamsDics.Free;
  end;
end;


procedure TApp42Api.UpdateUser(const ASessionID, AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
  LBody, LSignature, LResource: string;
  LApp42Utils: TApp42Utils;
begin
try
  FRequest.ResetToDefaults;
  AddAuthParameters;
  LBody := '{"app42":{"storage":{"jsonDoc":'+AUserObject.ToString+'}}}';
  // Check session or master
  if ASessionID <> '' then
    AddSessionToken(ASessionID);

   SignParamsDics.Add('body',LBody);
   SignParamsDics.Add('collectionName',sUserCollectionName);
   SignParamsDics.Add('dbName',sDBName);
   SignParamsDics.Add('docId',AObjectID);
   LApp42Utils := TApp42Utils.Create;
   LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
   Request.Params.AddHeader('signature',LSignature);
  // FRequest.Method := TRESTRequestMethod.rmPUT;
  LResource:= sStorage + '/updateKeysByDocId/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + AObjectID;
  PutResource(LResource, TJSONObject.ParseJSONValue(LBody) as TJSONObject, False);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
  // '{"updatedAt":"2013-10-16T20:21:57.326Z"}'
  AUpdatedAt := UpdatedAtFromObject(sUserCollectionName, AObjectID, LResponse);
finally
SignParamsDics.Free;
end;
end;

procedure TApp42Api.UpdateUser(const AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
begin
  UpdateUser('', AObjectID, AUserObject, AUpdatedAt);
end;

procedure TApp42Api.UpdateUser(const ALogin: TLogin; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
begin
  UpdateUser(ALogin.SessionToken, ALogin.User.ObjectID, AUserObject, AUpdatedAt);
end;


procedure TApp42Api.QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray);
var
LResource : string;
begin
  LResource := sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + sUserCollectionName;
  QueryResource(LResource, sUserCollectionName, AQuery, AJSONArray, True);
end;

procedure TApp42Api.QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AUsers: TArray<TUser>);
var
  LJSONValue: TJSONValue;
  LList: TList<TUser>;
  LUser: TUser;
begin
  QueryResource(sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + sUserCollectionName, sUserCollectionName, AQuery, AJSONArray, True);
  LList := TList<TUser>.Create;
  try
    for LJSONValue in AJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LUser := UserFromObject(TJSONObject(LJSONValue));
        LList.Add(LUser);
      end
      else
        raise EApp42APIError.Create(sJSONObjectExpected);
    end;
    AUsers := LList.ToArray;
  finally
    LList.Free;
  end;
end;





{ EApp42Exception }

constructor EApp42APIError.Create(ACode: Integer; const AError: string);
begin
  FCode := ACode;
  FError := AError;
  inherited CreateFmt('App42 Error: %0:s. %1:s', [Self.Error, Self.Code]);
end;

{ TApp42Api.TConnectionInfo }

constructor TApp42Api.TConnectionInfo.Create(const AApiVersion, AApiKey: string);
begin
  ApiVersion := AApiVersion;
  ApiKey := AApiKey;
end;

{ TApp42Api.TObjectID }

constructor TApp42Api.TObjectID.Create(const ABackendClassName: string;
  AObjectID: string);
begin
  FBackendClassName := ABackendClassName;
  FObjectID := AObjectID;
end;

{ TApp42Api.TFileID }

constructor TApp42Api.TFile.Create(const AName: string);
begin
  FName := AName;
end;

{ TApp42Api.TUserID }

constructor TApp42Api.TUser.Create(const AUserName: string);
begin
  FUserName := AUserName;
end;

{ TApp42Api.TLogin }

constructor TApp42Api.TLogin.Create(const ASessionToken: string;
  const AUser: TUser);
begin
  FSessionToken := ASessionToken;
  FUser := AUser;
end;

{ TApp42Api.TUpdatedAt}

constructor TApp42Api.TUpdatedAt.Create(const ABackendClassName, AObjectID: string; AUpdatedAt: TDateTime);
begin
  FUpdatedAt := AUpdatedAt;
  FBackendClassName := ABackendClassName;
  FObjectID := AObjectID;
end;

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//






procedure TApp42Api.PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID,
  AUserID: string);
var
  LJSONObject : TJSONObject;
  LSignature, LBody: string;
  LApp42Utils: TApp42Utils;
  LUserObject: TJSONObject;
  LUpdatedAt : TUpdatedAt;

  function PlatformTypeToString(ADeviceType: TApp42API.TPlatformType): string;
begin
  case ADeviceType of
    TApp42API.TPlatformType.Android:
      Result := 'ANDROID';
    TApp42API.TPlatformType.IOS:
      Result := 'iOS';
  else
    Assert(False);
  end;
end;

begin
  CheckObjectID(AUserID);
  LUserObject := TJSONObject.Create;
  try
  LUserObject.AddPair('pushDeviceId',ADeviceID);
  LUserObject.AddPair('pushDeviceType',PlatformTypeToString(APlatformType));
  UpdateUser(AUserID, LUserObject, LUpdatedAt);
  finally
   LUserObject.Free;
  end;

  FRequest.ResetToDefaults;
  AddAuthParameters(TAuthentication.AdminKey);
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sPush + '/storeDeviceToken/' + AUserID;
  LJSONObject:= TJSONObject.Create;
  try
    LJSONObject.AddPair( 'type', PlatformTypeToString(APlatformType));                    // Do not localize
    LJSONObject.AddPair( 'deviceToken', ADeviceID );           // Do not localize
    if AUserId <> '' then
      LJSONObject.AddPair( 'userName', AUserId );            // Do not localize
  LBody := '{"app42":{"push":'+LJSONObject.ToString+'}}';   // Do not localize
  SignParamsDics.Add('body',LBody);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.AddBody(LBody, ctAPPLICATION_JSON);
  finally
    LJSONObject.Free;
  end;
  FRequest.Execute;
  if FRequest.Response.StatusCode >= 300 then
    raise EApp42APIError.Create(FRequest.Response.StatusText);
end;

procedure TApp42Api.PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string);
var
LUser: TUser;
LUserObject : TJSONObject;
begin
  LUserObject := UserFromUserName(FConnectionInfo.UserName);
  LUser := UserFromObject(LUserObject);
  PushRegisterDevice(APlatformType, ADeviceID, LUser.FObjectID);
end;

procedure TApp42Api.PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string;
  const AUser: TUser);
begin
  PushRegisterDevice(APlatformType, ADeviceID, AUser.FObjectID);
end;


procedure TApp42Api.PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID,
  AUserID: string);
var
  LSignature : string;
  LApp42Utils: TApp42Utils;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := sPush;
  SignParamsDics.Add('userName',AUserID);
  SignParamsDics.Add('deviceToken',ADeviceID);
  FRequest.AddParameter('userName',AUserID);
  FRequest.AddParameter('deviceToken',ADeviceID);
  LApp42Utils := TApp42Utils.Create;
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  FRequest.Params.AddHeader('signature',LSignature);
  FRequest.Execute;
  if FRequest.Response.StatusCode >= 300 then
    raise EApp42APIError.Create(FRequest.Response.StatusText);
end;

procedure TApp42Api.PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string);
begin
  PushUnregisterDevice(APlatformType, ADeviceID, '');
end;

procedure TApp42Api.PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string;
  const AUser: TUser);
begin
  PushUnregisterDevice(APlatformType, ADeviceID, AUser.ObjectID);
end;





 //
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


// Creates the Session For Current LoggedIn User.
function TApp42Api.CreateSessionFromLogin(const AUserName: string; ASessionId: string; AUser: TUser) : Boolean;
var
LApp42Utils : TApp42Utils;
LSignature, LBody : string;
LSessionObject, LJObject, LId : TJSONObject;
begin
  Result := false;
  FRequest.ResetToDefaults;
  AddAuthParameters;
   LSessionObject:= TJSONObject.Create;
   LJObject:= TJSONObject.Create;
   LApp42Utils := TApp42Utils.Create;
try
   LId := TJsonObject.Create.AddPair('$oid', AUser.ObjectID);
   LSessionObject.AddPair('userName',AUserName);
   LSignature := DateToISO8601(AUser.FCreatedAt);
   LSessionObject.AddPair('_$createdAt', DateToISO8601(AUser.FCreatedAt));
   LSessionObject.AddPair('_$updatedAt', DateToISO8601(AUser.FUpdatedAt));
   LSessionObject.AddPair('_id', LId);
  LJObject.AddPair('name', 'sessionEntities'); // Do not localize
  LJObject.AddPair('value', LSessionObject.ToString); // Do not localize
  // Creating JSON Body for Session Post Request.
  LBody := '{"app42":{"session":'+LJObject.ToString+'}}';  // Do not localize
  SignParamsDics.Add('sessionId',ASessionId);
  SignParamsDics.Add('body',LBody);

  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.AddBody(LBody, ctAPPLICATION_JSON);
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sSession + '/id/' + ASessionId;
    FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  finally
  LJObject.Free;
  LSessionObject.Free;
  end;
  if FRequest.Response.StatusCode <> 404 then
  Result := true;
end;

// Creating User Object
function TApp42Api.UserFromUserName(const AUserName: string): TJSONObject;
var
  LUsers: TJSONArray;
  LSignature, LQueryString: string;
  LIsSuccess : Boolean;
  LApp42Utils: TApp42Utils;
  LQuery, LResponse, LUser: TJSONObject;
  LQueryArray : TJSONArray;
  LDBCredentials : TJSONObject;
begin
  CheckUserName(AUserName);
  LApp42Utils := TApp42Utils.Create;
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sUsers + '/' + AUserName;
  LQueryString := 'userName=='+AUserName;
  LQuery := LApp42Utils.BuildQueryString(LQueryString);
  LQueryArray:= TJSONArray.Create;
  LDBCredentials:= TJSONObject.Create;
try
  LQueryArray.AddElement(LQuery);
  Request.Params.AddHeader('metaQuery',LQueryArray.ToString);
  LDBCredentials.AddPair('dbName', sDBName);  // Do not localize
  LDBCredentials.AddPair('collectionName', sUserCollectionName); // Do not localize
    // Adding UserDetails to headers With DBName And Collection Name.
  Request.Params.AddHeader('dbCredentials',LDBCredentials.ToString);
  SignParamsDics.Add('userName',AUserName);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  finally
  LDBCredentials.Free;
  // LQueryArray.Fr  ee;
  end;
  LIsSuccess := FRequest.Response.StatusCode <> 404;
  if LIsSuccess then
  begin
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LResponse := LApp42Utils.RootNodeFromResponse(LResponse);
    LUsers := LResponse.Get('jsonDoc').JsonValue as TJSONArray;
  if LUsers.Count > 1 then
    raise Exception.Create('Multiple users');
  if LUsers.Count = 1 then
  begin
    LUser := LUsers.Items[0] as TJSONObject;
    Result := LUser;
  end
  else
  Result := nil;
  end
  else
  Result := nil;

end;

// Signing.
function TApp42Utils.Sign(const SignParamsDic: TDictionary<string,string>; AKey: string) : string;
var
  SigningParamsStr: string;
  LSignature:string;
begin
  SigningParamsStr:= ConverAndSortParamsToString(SignParamsDic);
  LSignature := CreateSignature(SigningParamsStr, AKey);
  Result:= LSignature;
end;

// Creating Signature.
function TApp42Utils.CreateSignature(const AData, AKey: string) : string;
var
  ResBytes: TIdBytes;
begin
  with TIdHMACSHA1.Create do
  try
    Key := ToBytes(AKey);
    ResBytes := HashValue(ToBytes(AData));
    Result := string(EncodeBase64(ResBytes,Length(ResBytes)));
  finally
    Free;
  end;
end;


// Converting the Dictionary Params to key value string with sorting (For creating the Signature).
function TApp42Utils.ConverAndSortParamsToString(const SignParamsDic: TDictionary<string,string>): string;
var
 I: Integer;
 list: TList<string>;
 StringBuilder: TStringBuilder;
begin
 StringBuilder := TStringBuilder.Create;
 list := TList<string>.Create(SignParamsDic.Keys);
 list.Sort;
 try
  for I := 0 to list.Count-1 do
  begin
  StringBuilder.Append(list[I]+SignParamsDic[list[I]]);
  end;
   Result:= StringBuilder.ToString;
 finally
    StringBuilder.Free;
  end;
end;

// Creating UTCFormattedTimeStamp.
function TApp42Utils.GetUTCFormattedTime(const ACurrentTime: TDateTime) : string;
var
 UTCTime: string;
begin
  UTCTime:= DateToISO8601(ACurrentTime);
  Result:= UTCTime;
end;


 // Obtaining Root Node from the Responses of different services.
function TApp42Utils.RootNodeFromResponse(const AResponse: TJSONObject) : TJSONObject;
var
LApp42, LSuccess, LNodeObj, LUploadObj, LSessionObj, LAttributesObj: TJSONObject;
begin
    LApp42 :=  AResponse.Get('app42').JsonValue as TJSONObject;
    LSuccess := LApp42.Get('response').JsonValue as TJSONObject;
if LSuccess.GetValue('users') <> nil then
    begin
    LNodeObj := LSuccess.Get('users').JsonValue as TJSONObject;
    Result := LNodeObj.Get('user').JsonValue as TJSONObject;
    end
else if LSuccess.GetValue('storage') <> nil then
    begin
    LNodeObj := LSuccess.Get('storage').JsonValue as TJSONObject;
    Result := LNodeObj.Get('jsonDoc').JsonValue as TJSONObject;
    end
else if LSuccess.GetValue('upload') <> nil then
    begin
    LNodeObj := LSuccess.Get('upload').JsonValue as TJSONObject;
    LUploadObj := LNodeObj.Get('files').JsonValue as TJSONObject;
    Result := LUploadObj.Get('file').JsonValue as TJSONObject;
    end
else if LSuccess.GetValue('session') <> nil then
    begin
    LNodeObj := LSuccess.Get('session').JsonValue as TJSONObject;
    LAttributesObj := LNodeObj.Get('attributes').JsonValue as TJSONObject;
    LSessionObj := LAttributesObj.Get('attribute').JsonValue as TJSONObject;
    Result := LSessionObj.Get('value').JsonValue as TJSONObject;
    end
else
   Result := AResponse;
end;


// Builds the Query String.
function TApp42Utils.BuildQueryString(const q1: string) : TJSONObject;
var
  S: string;
  I: Integer;
  LExpression: TJSONObject;
begin
 LExpression := TJSONObject.Create;
  S:= q1;
 if S.Contains('==') then
  begin
   I := S.IndexOf('==');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$eq');
         LExpression.AddPair('value',S.Substring(I+2).Trim);
   end;
   end;

   if S.Contains('!=') then
  begin
   I := S.IndexOf('!=');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$ne');
         LExpression.AddPair('value',S.Substring(I+2).Trim);
   end;
   end;

   if S.Contains('>') then
  begin
   I := S.IndexOf('>');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$gt');
         LExpression.AddPair('value',S.Substring(I+1).Trim);
   end;
   end;

   if S.Contains('<') then
  begin
   I := S.IndexOf('<');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$lt');
         LExpression.AddPair('value',S.Substring(I+1).Trim);
   end;
   end;

   if S.Contains('>=') then
  begin
   I := S.IndexOf('>=');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$gte');
         LExpression.AddPair('value',S.Substring(I+2).Trim);
   end;
   end;

   if S.Contains('<=') then
  begin
   I := S.IndexOf('<=');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$lte');
         LExpression.AddPair('value',S.Substring(I+2).Trim);
   end;
   end;

   if S.Contains('LIKE') then
  begin
   I := S.IndexOf('LIKE');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$lk');
         LExpression.AddPair('value',S.Substring(I+4).Trim);
   end;
   end;

   if S.Contains('INLIST') then
  begin
   I := S.IndexOf('INLIST');
   if I > 0 then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('key',S.Substring(0, I).Trim);
         LExpression.AddPair('operator','$in');
         LExpression.AddPair('value',S.Substring(I+6).Trim);
   end;
   end;

    if S.Contains('AND') then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('compoundOpt','$and');
   end;

   if S.Contains('OR') then
   begin
    LExpression := TJSONObject.Create;
         LExpression.AddPair('compoundOpt','$or');
   end;
Result := LExpression;
end;

// Builds the Compound Query String.
function TApp42Utils.BuildCompoundQueryString(const q1: TJSONArray; q2: TJSONObject; q3: TJSONObject ) : TJSONArray;
var
  LExpressionJsonArray: TJSONArray;
begin
 LExpressionJsonArray:= TJSONArray.Create;
 LExpressionJsonArray.AddElement(q1);
 LExpressionJsonArray.AddElement(q2);
 LExpressionJsonArray.AddElement(q3);
 Result := LExpressionJsonArray;
end;

end.




