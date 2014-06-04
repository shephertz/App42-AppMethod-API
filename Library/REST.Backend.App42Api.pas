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
  IdHMACSHA1, IdGlobal, System.Classes, System.SysUtils, System.Generics.Collections, System.JSON,
  REST.Client, EncdDecd, REST.Json, REST.Types, REST.Backend.Consts, IdMultipartFormData, IdHTTP;

{$SCOPEDENUMS ON}

type

  EApp42Exception = class(Exception)
  private
    FCode: Integer;
    FError: string;
  public
    constructor Create(ACode: Integer; const AError: String); overload;
    property Code: Integer read FCode write FCode;
    property Error: string read FError write FError;
  end;

  /// <summary>
  /// <para>
  /// TApp42Api implements REST requests based on App42's REST API.
  /// </para>
  /// </summary>
  TApp42Api = class(TComponent)
  private const
    sStorage = 'storage';
    sDBName = 'App42DB';
    sUserCollectionName = 'App42Users';
    sInstallations = 'installations';
    sFiles = 'upload';
    sUsers = 'user';
    sPush = 'push';
    sApiKey = 'apiKey';
    sApiVersion = 'version';
    sTimestamp = 'timeStamp';
  public const
    cDefaultApiVersion = '1.0';
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
  //    DBName: string;
      constructor Create(const AApiKey, ASecretKey: string);
    end;

//    TIncrement = TPair<string, Integer>;
//    TIncrements = TArray<TIncrement>;

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

    TAuthentication = (ApiKey, ApiVersion);
    TAuthentications = set of TAuthentication;
    TDefaultAuthentication = (ApiKey, ApiVersion);

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
    procedure ApplyConnectionInfo;

    function GetLoggedIn: Boolean;

  // AddAPIKey(const AKey: string); overload;
  //  procedure AddAPIKey; overload;

  //    procedure AddDBName(const ADBName: string); overload;
  //    procedure AddDBName; overload;

 //   procedure AddSECRETKey(const AKey: string); overload;
 //   procedure AddSECRETKey; overload;

    procedure CheckAuthentication(AAuthentication: TAuthentications);
 //   function GetActualAuthentication: TAuthentication;

  protected
    procedure CheckForResponseError(AValidStatusCodes: array of Integer); overload;
    procedure CheckForResponseError; overload;

    procedure PostResource(const AResource: string;
      const AJSON: string; AReset: Boolean);

    procedure PutResource(const AResource: string;
      const AJSONObject: string; AReset: Boolean);

    function DeleteResource(const AResource: string; AReset: Boolean): Boolean; overload;

    function ObjectIDFromObject(const ABackendClassName, AObjectID: string;
    const AJSONObject: TJSONObject): TObjectID; overload;

    function FileIDFromObject(const AFileName: string; const AJSONObject: TJSONObject): TFile;


//    procedure AddSessionToken; overload;
//    procedure AddSessionToken(const AAPIKey, ASessionToken: string); overload;

    procedure AddAuthParameters;

    function FindClass(const ABackendClassName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray; AProc: TFindObjectProc): Boolean; overload;

    function QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean; overload;

    function LoginFromObject(const AUserName: string; const AJSONObject: TJSONObject): TLogin;

    function UserFromObject(const AUserName: string; const AJSONObject: TJSONObject): TUser; overload;

    function UpdatedAtFromObject(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject): TUpdatedAt;

    procedure QueryResource(const AResource: string; ACollection: string; const AQuery: array of string; const AJSONArray: TJSONArray; AReset: Boolean);

    function RetrieveCurrentUser(const ASessionToken: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean; overload;

    function RetrieveUser(const ASessionID, AObjectID: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc; AReset: Boolean): Boolean; overload;

    procedure UpdateUser(const ASessionID, AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;

    property RestClient: TRESTClient read FRESTClient;

    property Request: TRESTRequest read FRequest;
  public
    constructor Create(AOwner: TComponent; const AResponse: TRESTResponse = nil); reintroduce; overload;

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
//  private
  protected
  public
    function BuildCompoundQueryString(const q1: TJSONArray; q2: TJSONObject; q3: TJSONObject) : TJSONArray;
    function BuildQueryString(const q1: string) : TJSONObject;
    function Sign(const SignParamsDic: TDictionary<string,string>; AKey: string) : string;
    function ComputeHmac(const AData, Akey: string): string;
    function ConverAndSortParamsToString(const SignParamsDic: TDictionary<string,string>): string;
    function GetUTCFormattedTime(const ACurrentTime: TDateTime): string;
    function RootFromResponse(const AResponse: TJSONObject) : TJSONObject;
  //  procedure ClientRequestParams(const ApiKey: string; const ApiVersion: string; Request: TRESTRequest);
  published
  end;

var
 SignParamsDics: TDictionary<string, string>;
 QueryParamsDics: TDictionary<string, string>;



implementation

uses System.DateUtils, System.Rtti, REST.Exception, REST.JSON.Types, System.TypInfo;

procedure CheckObjectID(const AObjectID: string);
begin
  if AObjectID = '' then
    raise EApp42Exception.Create('ObjectID required');
end;

procedure CheckSecretKey(const ASecretKey: string);
begin
  if ASecretKey = '' then
    raise EApp42Exception.Create('SecretKey required');
end;

procedure CheckSessionID(const SessionID: string);
begin
  if SessionID = '' then
    raise EApp42Exception.Create('SessionID required');
end;

procedure CheckAPIKey(const AKey: string);
begin
  if AKey = '' then
    raise EApp42Exception.Create('API Key required');
end;

procedure CheckBackendClass(const ABackendClassName: string);
begin
  if ABackendClassName = '' then
    raise EApp42Exception.Create('BackendClassName required');
end;

procedure CheckJSONObject(const AJSON: TJSONObject);
begin
  if AJSON = nil then
    raise EApp42Exception.Create('JSON object required');
end;

constructor TApp42Api.Create(AOwner: TComponent;
  const AResponse: TRESTResponse);
begin
  inherited Create(AOwner);
  FConnectionInfo := TConnectionInfo.Create('', '');
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

// App42 installation json
//deviceType "ios" or "android"
//installationId android
//deviceToken ios
//badge ios
//timeZone both
//channels  both

function TApp42Api.CreateIOSInstallationObject(const ADeviceToken: string; ABadge: Integer;
  AChannels: array of string): TJSONObject;
var
  LArray: TJSONArray;
  S: string;
begin
  Result := TJSONObject.Create;
  Result.AddPair('deviceType', TJSONString.Create(TDeviceNames.IOS));
  Result.AddPair('deviceToken', TJSONString.Create(ADeviceToken));
  Result.AddPair('badge', TJSONNumber.Create(ABadge));
  LArray := TJSONArray.Create;
  for S in AChannels do
    LArray.AddElement(TJSONString.Create(S));

  // Result.AddPair('timeZone', TJSONString.Create(????));
  Result.AddPair('channels', LArray);   // empty channels
end;

function TApp42Api.CreateAndroidInstallationObject(const AInstallationID: string; AChannels: array of string): TJSONObject;
var
  LArray: TJSONArray;
  S: string;
begin
  Result := TJSONObject.Create;
  Result.AddPair('deviceType', TJSONString.Create(TDeviceNames.Android));
  Result.AddPair('deviceToken', TJSONString.Create(AInstallationID));
  LArray := TJSONArray.Create;
  for S in AChannels do
    LArray.AddElement(TJSONString.Create(S));

  // Result.AddPair('timeZone', TJSONString.Create(????));
  Result.AddPair('channels', LArray);   // empty channels
end;

const
  sApiVersion = 'version';
  sApiKey = 'apiKey';
  sTimestamp = 'timestamp';
//  sSecretKey = 'X-App42-SECRET-KEY';
//  sMasterKey = 'X-App42-Master-Key';
//  sSessionToken = 'X-App42-Session-Token';

procedure TApp42Api.ApplyConnectionInfo;
begin
 // FRESTClient.Params.AddUrlSegment(sApiVersion, FConnectionInfo.ApiVersion);
  FRESTClient.Params.AddHeader(sApiKey, FConnectionInfo.ApiKey);
  FRESTClient.Params.AddHeader(sApiVersion, FConnectionInfo.ApiVersion);
 // FRESTClient.Params.AddHeader(sTimestamp, 'sdfdsfgfghgfjg');
 // FRESTClient.Accept := 'application/json';
end;

//procedure TApp42Api.AddSECRETKey(const AKey: string);
//begin
//  CheckSecretKey(AKey);
//  FRequest.Params.AddHeader(sSecretKey, AKey);
//end;

//procedure TApp42Api.AddSECRETKey;
//begin
//  AddSECRETKey(ConnectionInfo.SecretKey);
//end;

//procedure TApp42Api.AddApiVersion(const AKey: string);
//begin
//  CheckSecretKey(AKey);
//  FRequest.Params.AddHeader(sSecretKey, AKey);
//end;
//
//procedure TApp42Api.AddApiVersion;
//begin
//  AddSECRETKey(ConnectionInfo.SecretKey);
//end;

//procedure TApp42Api.AddDBName(const ADBName: string);
//begin
//  //CheckDBName(ADBName);
////  FRequest.Params.AddHeader(sSecretKey, ADBName);
//end;

//procedure TApp42Api.AddDBName;
//begin
// // AddSECRETKey(ConnectionInfo.DBName);
//end;

//procedure TApp42Api.AddSessionToken;
//begin
//  AddSessionToken(ConnectionInfo.ApiKey, FSessionToken);
//end;

//procedure TApp42Api.AddSessionToken(const AAPIKey, ASessionToken: string);
//begin
//  CheckSessionID(ASessionToken);
//  FRequest.Params.AddHeader(sSessionToken, ASessionToken);
//  AddAPIKey(AAPIKey); // Need REST API Key with session token
//end;

//procedure TApp42Api.AddAPIKey(const AKey: string);
//begin
//  CheckAPIKey(AKey);
//  FRequest.Params.AddHeader(sApiKey, AKey);
//end;
//
//procedure TApp42Api.AddAPIKey;
//begin
//  AddAPIKey(ConnectionInfo.ApiKey);;
//end;

procedure TApp42API.CheckAuthentication(AAuthentication: TAuthentications);
var
  LAuthentication: TAuthentication;
  LInvalid: string;
  LValid: string;
  LValidItems: TStrings;
begin
 // LAuthentication := GetActualAuthentication;
  if not (LAuthentication in AAuthentication) then
  begin
    LInvalid :=  System.TypInfo.GetEnumName(TypeInfo(TAuthentication), Integer(LAuthentication));
    LValidItems := TStringList.Create;
    try
      for LAuthentication in AAuthentication do
        LValidItems.Add(System.TypInfo.GetEnumName(TypeInfo(TAuthentication), Integer(LAuthentication)));
      if LValidItems.Count = 1 then
        LValid := Format('Use %s.', [LValidItems[0]])
      else
      begin
        LValid := LValidItems[LValidItems.Count - 1];
        LValidItems.Delete(LValidItems.Count-1);
        LValidItems.Delimiter := ',';
        LValid := Format('Use %0:s or %1:s.', [LValidItems.DelimitedText, LValid])
      end;

    finally
      LValidItems.Free;
    end;

    raise Exception.CreateFmt('Invalid authentication (%0:s) for this operation. %1:s', [LInvalid, LValid]);
  end;
end;

//function TApp42API.GetActualAuthentication: TAuthentication;
//var
//  LAuthentication: TAuthentication;
//begin
//  LAuthentication := FAuthentication;
//  if LAuthentication = TAuthentication.Default then
//    case FDefaultAuthentication of
//      TDefaultAuthentication.SecretKey:
//        LAuthentication := TAuthentication.SecretKey;
//      TDefaultAuthentication.APIKey:
//        LAuthentication := TAuthentication.ApiKey;
//      TApp42Api.TDefaultAuthentication.Session:
//        LAuthentication := TAuthentication.Session;
//    else
//      Assert(False);
//    end;
//  Result := LAuthentication;
//end;

procedure TApp42Api.AddAuthParameters;
var
  Today : TDateTime;
  TimeZone: TTimeZone;
  LApp42Utils: TApp42Utils;
  LTimeStampStr: string;
begin
  Today:= TimeZone.Local.ToUniversalTime(Now);
  LTimeStampStr:= LApp42Utils.GetUTCFormattedTime(Today);
  Request.Accept := 'application/json';
  //Request.Params.AddHeader(sApiKey,ApiKey);
  Request.Params.AddHeader(sTimestamp,LTimeStampStr);
  //Request.Params.AddHeader(sApiVersion,ApiVersion);
  SignParamsDics:= TDictionary<string,string>.create;
  SignParamsDics.Add(sApiKey,FConnectionInfo.ApiKey);
  SignParamsDics.Add(sTimestamp,LTimeStampStr);
  SignParamsDics.Add(sApiVersion,FConnectionInfo.ApiVersion);

//  LAuthentication := GetActualAuthentication;
//  case LAuthentication of
//    TApp42Api.TAuthentication.APIKey:
 //     AddAPIKey;
//    TApp42Api.TAuthentication.ApiVersion:
//      AddSECRETKey;
////    TApp42Api.TAuthentication.Session:
////      AddSessionToken;
//  else
//    Assert(False);
//  end;
end;

procedure TApp42Api.CheckForResponseError;
var
  LCode: Integer;
  LMessage: string;
  LJSONCode: TJSONValue;
  LJSONMessage: TJSONValue;
begin
  if FRequest.Response.StatusCode >= 300 then
  begin
    if (FRequest.Response.StatusCode >= 400) and (FRequest.Response.StatusCode < 500)
       and (FRequest.Response.JSONValue <> nil) then
    begin
      LJSONCode := (FRequest.Response.JSONValue as TJSONObject).GetValue('code');
      if LJSONCode <> nil then
        LCode := StrToInt(LJSONCode.Value)
      else
        LCode := 0;
      LJSONMessage := (FRequest.Response.JSONValue as TJSONObject).GetValue('error');
      if LJSONMessage <> nil then
        LMessage := LJSONMessage.Value;
      if (LJSONCode <> nil) and (LJSONMessage <> nil) then
        raise EApp42Exception.Create(LCode, LMessage)
      else if LJSONMessage <> nil then
        raise EApp42Exception.Create(LMessage)
      else
        raise EApp42Exception.Create(FRequest.Response.Content);
    end;
    if FRequest.Response.StatusCode = 403 then
      raise EApp42Exception.Create('Access denied');
    raise EApp42Exception.Create(FRequest.Response.Content);
  end
end;

procedure TApp42Api.CheckForResponseError(AValidStatusCodes: array of Integer);
var
  LCode: Integer;
  LResponseCode: Integer;
begin
  LResponseCode := FRequest.Response.StatusCode;

  for LCode in AValidStatusCodes do
    if LResponseCode = LCode then
      Exit; // Code is valid, exit with no exception
  CheckForResponseError;
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

function TApp42Api.DeleteClass(const ABackendClassName: string; const AObjectID: string): Boolean;
var
 LSignature: string;
 LApp42Utils: TApp42Utils;
begin
  CheckBackendClass(ABackendClassName);
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('collectionName',ABackendClassName);
  SignParamsDics.Add('docId',AObjectID);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  Result := DeleteResource(sStorage + '/deleteDocById/dbName/' + sDBName + '/collectionName/' + ABackendClassName + '/docId/' + AObjectID, False);
end;

function TApp42Api.DeleteInstallation(const AObjectID: string): Boolean;
begin
  Result := DeleteResource(sInstallations + '/' + AObjectID, True);
end;

////curl -X GET \
////  -H "X-App42-Application-Id: cIj01OkQeJ8LUzFZjMnFyJQD6qx0OehYep0mMdak" \
////  -H "X-App42-Master-Key: CiQo8BgzcyoYuSwfG6ILYHluLnkizb4wQh4bbsr7" \
////  https://api.parse.com/1/installations
//function TApp42Api.QueryInstallation(const AQuery: TJSONObject;
procedure TApp42Api.QueryInstallation(const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  QueryResource(sInstallations, sUserCollectionName, AQuery, AJSONArray, False);
end;

procedure TApp42Api.QueryInstallation(const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>);
var
  LJSONValue: TJSONValue;
  LList: TList<TObjectID>;
  LInstallation: TObjectID;
begin
  FRequest.ResetToDefaults;
  //AddAuthParameters;
 // AddSECRETKey;
  QueryResource(sInstallations, sUserCollectionName, AQuery, AJSONArray, False);
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
        raise Exception.Create('Not object');
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

function TApp42Utils.BuildQueryString(const q1: string) : TJSONObject;
var
  S: string;
  I: Integer;
  LExpression: TJSONObject;
begin
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


procedure TApp42Api.QueryResource(const AResource: string; ACollection: string; const AQuery: array of string; const AJSONArray: TJSONArray; AReset: Boolean);
var
  LRoot: TJSONArray;
  S: string;
  LSignature: string;
  I: Integer;
  LJSONValue: TJSONValue;
  LResponse,LApp42,LSuccess,LStorage,LJsonDoc,LId: TJSONObject;

  LQueryString: string;
  LExpressionJson: TJSONObject;
  LExpressionJson2: TJSONObject;
  LExpressionJson3: TJSONObject;
  LExpressionJsonArray: TJSONArray;
  LCompoundExpressionArray: TJSONArray;
  LApp42Utils: TApp42Utils;
  LNotRepeated: Boolean;
begin
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := AResource;
try
 LExpressionJsonArray:= TJSONArray.Create;
 LCompoundExpressionArray := TJSONArray.Create;
 LNotRepeated := true;
 I:=0;
   if Length(AQuery) > 1 then
 begin
   for S in AQuery do
  begin
  if I<=2 then
  begin
  I:=I+1;
  LExpressionJson := TJSONObject.Create;
    LExpressionJson := LApp42Utils.BuildQueryString(S);
    LExpressionJsonArray.AddElement(LExpressionJson);
  end
  else
  begin
  if LNotRepeated  then
  begin
  LNotRepeated := false;
  LExpressionJson2 := TJSONObject.Create;
  LExpressionJson2 := LApp42Utils.BuildQueryString(S);
  end
  else
  begin
  LExpressionJson3 := TJSONObject.Create;
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
    LExpressionJson := TJSONObject.Create;
    LExpressionJson := LApp42Utils.BuildQueryString(S);
    LExpressionJsonArray.AddElement(LExpressionJson);
  end;
   end;
  LQueryString := LExpressionJsonArray.ToString;
finally
 LExpressionJsonArray.Free;
end;
    SignParamsDics.Add('collectionName',ACollection);
    SignParamsDics.Add('dbName',sDBName);
    SignParamsDics.Add('jsonQuery',LQueryString);
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
    Request.Params.AddHeader('jsonQuery', LQueryString);

  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    // {"app42":{"response":{"success":true,"storage":{"dbName":"queryTest","collectionName":"App42AppUsers","recordCount":2,"jsonDoc":[{"_id":{"$oid":"538ec34eae5975ed944c33eb"},"_$owner":{"owner":"DFD2"},"FirstName":"ABCD2","userName":"DFD2","_$createdAt":"2014-06-04T06:57:18.043Z","_$updatedAt":"2014-06-04T06:57:18.043Z","LastName":"XYZ2"},{"_id":{"$oid":"538ec34fae5975ed944c33ec"},"_$owner":{"owner":"DFD1"},"FirstName":"ABCD1","userName":"DFD1","_$createdAt":"2014-06-04T06:57:19.045Z","_$updatedAt":"2014-06-04T06:57:19.045Z","LastName":"XYZ1"}]}}}}
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LApp42    := LResponse.Get('app42').JsonValue as TJSONObject;
    LSuccess := LApp42.Get('response').JsonValue as TJSONObject;
    LStorage := LSuccess.Get('storage').JsonValue as TJSONObject;
    LRoot := LStorage.Get('jsonDoc').JsonValue as TJSONArray;
    for LJSONValue in LRoot do
    AJSONArray.AddElement(TJSONValue(LJSONValue.Clone))
  end;
end;

procedure TApp42Api.QueryClass(const ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  QueryResource(sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + ABackendClassName, ABackendClassName, AQuery, AJSONArray, True);
end;

procedure TApp42Api.QueryClass(const ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>);
var
  LJSONValue: TJSONValue;
  LList: TList<TObjectID>;
  LObjectID: TObjectID;
begin
  CheckBackendClass(ABackendClassName);
  FRequest.ResetToDefaults;
  AddAuthParameters;

  QueryResource(sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + ABackendClassName, ABackendClassName, AQuery, AJSONArray, False);
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
        raise Exception.Create('Not object');
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
  LResponse, LRoot: TJSONObject;
  LSignature: string;
  LApp42Utils: TApp42Utils;
begin
  CheckBackendClass(ABackendClassName);
  CheckObjectID(AObjectID);
  Result := False;
  FRequest.ResetToDefaults;
  AddAuthParameters;
    SignParamsDics.Add('dbName',sDBName);
    SignParamsDics.Add('collectionName',ABackendClassName);
    SignParamsDics.Add('docId',AObjectID);
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
    LRoot := LApp42Utils.RootFromResponse(LResponse);
    AFoundObject := ObjectIDFromObject(ABackendClassName, LRoot);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
    begin
      AProc(AFoundObject, LRoot);
    end;
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


//curl -X POST \
//  -H "X-App42-Application-Id: cIj01OkQeJ8LUzFZjMnFyJQD6qx0OehYep0mMdak" \
//  -H "X-App42-REST-API-Key: yVVIeShrcZrdr3e4hMLodfnvLckWBZfTonCYlBsq" \
//  -H "Content-Type: application/json" \
//  -d '{
//        "where": {
//          "devicetype": "ios,android",
///        },
//        "data": {
//          "alert": "The Giants won against the Mets 2-3."
//        }
//      }' \
//  https://api.App42.com/1/push
procedure TApp42Api.PushBroadcast(const AData: TJSONObject);
begin
  PushToDevices(TArray<string>.Create(TDeviceNames.Android, TDeviceNames.IOS), AData);
  //PushToDevices(TArray<string>.Create(TDeviceNames.IOS), AData);
end;

//curl -X POST \
//  -H "X-App42-Application-Id: cIj01OkQeJ8LUzFZjMnFyJQD6qx0OehYep0mMdak" \
//  -H "X-App42-REST-API-Key: yVVIeShrcZrdr3e4hMLodfnvLckWBZfTonCYlBsq" \
//  -H "Content-Type: application/json" \
//  -d '{
//        "channels": [
//          "Giants",
//          "Mets"
//        ],
//        "data": {
//          "alert": "The Giants won against the Mets 2-3."
//        }
//      }' \
//  https://api.App42.com/1/push
procedure TApp42Api.PushToChannels(const AChannels: array of string; const AData: TJSONObject);
var
  LJSON: TJSONObject;
  LChannels: TJSONArray;
  S: string;
begin
  if Length(AChannels) = 0 then
    raise Exception.Create('No channels');
  LJSON := TJSONObject.Create;
  try
    LChannels := TJSONArray.Create;
    for S in AChannels do
      LChannels.Add(S);
    LJSON.AddPair('channels', LChannels);
    LJSON.AddPair('data', AData.Clone as TJSONObject);
    PushBody(LJSON);
  finally
    LJSON.Free;
  end;
end;


procedure TApp42Api.PushWhere(const AWhere: TJSONObject; const AData: TJSONObject);
var
  LJSON: TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    if AWhere <> nil then
      LJSON.AddPair('where', AWhere.Clone as TJSONObject);
    if AData <> nil then
      LJSON.AddPair('data', AData.Clone as TJSONObject);
    PushBody(LJSON);
  finally
    LJSON.Free;
  end;
end;


procedure TApp42Api.PushToDevices(const ADevices: array of string; const AData: TJSONObject);
var
  LDevices: TJSONArray;
  LWhere: TJSONObject;
  LQuery: TJSONObject;
  S: string;
begin
  if Length(ADevices) = 0 then
    raise Exception.Create('No devices');
  LDevices := TJSONArray.Create;
  for S in ADevices do
    LDevices.Add(S);
  LQuery := TJSONObject.Create;
  LQuery.AddPair('$in', LDevices);
  LWhere := TJSONObject.Create;
  try
    LWhere.AddPair('deviceType', LQuery);
    PushWhere(LWhere, AData);
  finally
    LWhere.Free;
  end;
end;

function TApp42Api.ObjectIDFromObject(const ABackendClassName: string; const AJSONObject: TJSONObject): TObjectID;
var
  LObjectID: string;
  LApp42Utils: TApp42Utils;
  LApp42,LId: TJSONObject;
begin
    if AJSONObject.GetValue('_id') <> nil then
    begin
      LId := AJSONObject.Get('_id').JsonValue as TJSONObject;
      LObjectID := LId.Get('$oid').JsonValue.Value;
      Result := ObjectIDFromObject(ABackendClassName, LObjectID, AJSONObject);
    end
    else
    begin
    LApp42:= LApp42Utils.RootFromResponse(AJSONObject);
    LId := LApp42.Get('_id').JsonValue as TJSONObject;
    LObjectID := LId.Get('$oid').JsonValue.Value;
    Result := ObjectIDFromObject(ABackendClassName, LObjectID, LApp42);
    end;
end;

function TApp42Api.ObjectIDFromObject(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject): TObjectID;
begin
  Result := TObjectID.Create(ABackendClassName, AObjectID);
  if AJSONObject.GetValue('_$createdAt') <> nil then
    Result.FCreatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$createdAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
  if AJSONObject.GetValue('_$updatedAt') <> nil then
    Result.FUpdatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$updatedAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
end;

function TApp42Api.FileIDFromObject(const AFileName: string; const AJSONObject: TJSONObject): TFile;
var
  LName: string;
begin
  if AJSONObject.GetValue('name') <> nil then
    LName := AJSONObject.GetValue('name').Value;
  Result := TFile.Create(LName);
  Result.FFileName := AFileName;
  if AJSONObject.GetValue('url') <> nil then
    Result.FDownloadURL := AJSONObject.GetValue('url').Value;
end;

procedure TApp42Api.Login(const ALogin: TLogin);
begin
  Login(ALogin.SessionToken);
end;

procedure TApp42Api.Login(const ASessionToken: string);
begin
  FSessionToken := ASessionToken;
 // FAuthentication := TAuthentication.Session;
end;

function TApp42Api.LoginFromObject(const AUserName: string; const AJSONObject: TJSONObject): TLogin;
var
  LUser: TUser;
  LSessionToken: string;
  LJsonDoc : TJSONObject;
begin
    TUser.Create(AUserName);
  if AJSONObject.GetValue('sessionId') <> nil then
    LSessionToken := AJSONObject.GetValue('sessionId').Value;
  if AJSONObject.GetValue('jsonDoc') <> nil then
  begin
    LJsonDoc :=  AJSONObject.Get('jsonDoc').JsonValue as TJSONObject;
    LUser := UserFromObject(AUserName, LJsonDoc);
  end
  else
  LUser := UserFromObject(AUserName, AJSONObject);
  Assert(LSessionToken <> '');
  Result := TLogin.Create(LSessionToken, LUser);
end;

function TApp42Api.UpdatedAtFromObject(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject): TUpdatedAt;
var
  LUpdatedAt: TDateTime;
  LResponse: TJSONObject;
  LApp42Utils : TApp42Utils;
begin
    LResponse:= LApp42Utils.RootFromResponse(AJSONObject);
  if LResponse.GetValue('_$updatedAt') <> nil then
    LUpdatedAt := TJSONDates.AsDateTime(LResponse.GetValue('_$updatedAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC)
  else
    LUpdatedAt := 0;
  Result := TUpdatedAt.Create(ABackendClassName, AObjectID, LUpdatedAt);
end;

function TApp42Api.UserFromObject(const AUserName: string; const AJSONObject: TJSONObject): TUser;
var
LUserObjectId: TJSONObject;
begin
  Result := TUser.Create(AUserName);
  if AJSONObject.GetValue('_id') <> nil then
   begin
      LUserObjectId := AJSONObject.Get('_id').JsonValue as TJSONObject;
  if LUserObjectId.GetValue('$oid') <> nil then
      Result.FObjectID := LUserObjectId.GetValue('$oid').Value;
   end;
  if AJSONObject.GetValue('_$createdAt') <> nil then
    Result.FCreatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$createdAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
  if AJSONObject.GetValue('_$updatedAt') <> nil then
    Result.FUpdatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue('_$updatedAt'), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
end;

function TApp42Api.UserFromObject(const AJSONObject: TJSONObject): TUser;
var
  LUserName: string;
begin
if AJSONObject.GetValue('userName') <> nil then
   LUserName := AJSONObject.GetValue('userName').Value;
   Assert(LUserName <> '');
   Result := UserFromObject(LUserName, AJSONObject);
end;

procedure TApp42Api.PostResource(const AResource: string; const AJSON: string; AReset: Boolean);
begin
  // CheckJSONObject(AJSON);
  // NEW : POST
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := AResource;
  FRequest.AddBody(AJSON, ctAPPLICATION_JSON);
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
  LResponse: TJSONObject;
  LJSON: TJSONObject;
  LApp42Utils: TApp42Utils;
  LMessage: string;
  LSignature: string;
  LObjectToSave: TJSONObject;
  LJArrayVal: TJSONArray;
begin
  CheckBackendClass(ABackendClassName);
  LJSON := nil;
  try
    if (AACL <> nil) and (AJSON <> nil) then
    begin
      LJSON := AJSON.Clone as TJSONObject;
      LJSON.AddPair('ACL', AACL.Clone as TJSONObject);
    end
    else if AACL <> nil then
      LJSON := AACL
    else
      LJSON :=  AJSON;

      LMessage := '{"app42":{"storage":{"jsonDoc":'+LJSON.ToString+'}}}';
    FRequest.ResetToDefaults;
  //  LApp42Utils.ClientRequestParams();
    AddAuthParameters;
    SignParamsDics.Add('body',LMessage);
    SignParamsDics.Add('collectionName',ABackendClassName);
    SignParamsDics.Add('dbName',sDBName);
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
    PostResource(sStorage + '/insert/dbName/' + sDBName + '/collectionName/' + ABackendClassName, LMessage, False);
   // {"app42":{"response":{"success":true,"storage":{"dbName":"queryTest","collectionName":"MyCollection","jsonDoc":{"address":"sample address3","name":"sample name3","_$createdAt":"2014-06-04T06:07:17.295Z","_$updatedAt":"2014-06-04T06:07:17.295Z","_id":{"$oid":"538eb795ae5975ed944c33d8"}}}}}}
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    ANewObject := ObjectIDFromObject(ABackendClassName, LResponse);
  finally
    if (LJSON <> AACL) and (LJSON <> AJSON) then
      LJSON.Free;
  end;
end;

procedure TApp42Api.PutResource(const AResource: string; const AJSONObject: string; AReset: Boolean);
begin
 // CheckJSONObject(AJSONObject);
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmPUT;
  FRequest.Resource := AResource;
  FRequest.AddBody(AJSONObject, ctAPPLICATION_JSON);
  FRequest.Execute;
  CheckForResponseError;
end;

procedure TApp42Api.UpdateClass(const ABackendClassName, AObjectID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
  LBody, LSignature: string;
  LApp42Utils : TApp42Utils;
begin
  CheckBackendClass(ABackendClassName);
  CheckObjectID(AObjectID);
   LBody := '{"app42":{"storage":{"jsonDoc":'+AJSONObject.ToString+'}}}';
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('body',LBody);
  SignParamsDics.Add('collectionName',ABackendClassName);
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('docId',AObjectID);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  PutResource(sStorage + '/updateKeysByDocId/dbName/' + sDBName + '/collectionName/' + ABackendClassName + '/docId/' + AObjectID, LBody, False);
//  '{"app42":{"response":{"success":true,"storage":{"dbName":"queryTest","collectionName":"MyCollection","jsonDoc":{"_id":{"$oid":"538ee218ae5975ed944c340d"},"address":"new york","name":"sample name1","_$createdAt":"2014-06-04T09:08:40.169Z","_$updatedAt":"2014-06-04T09:09:01.545Z"}}}}}'
  LResponse := FRequest.Response.JSONValue as TJSONObject;
// "_$updatedAt":"2014-06-04T06:07:17.295Z"
  AUpdatedAt := UpdatedAtFromObject(ABackendClassName, AObjectID, LResponse);
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


 //Method- POST multifart/form-data.
//url-https://api.shephertz.com/cloud/1.0/upload
procedure TApp42Api.UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string; out ANewFile: TFile);
var
  LResponse: TJSONObject;
  LApp42Utils: TApp42Utils;
  LSignature: string;
  Params: TIdMultipartFormDataStream;
  http: TIdHTTP;

  Today : TDateTime;
  TimeZone: TTimeZone;
  LTimeStampStr: string;
  LMultiPartBaseUrl: string;
  LUniqeFileId: string;
  LResponseStr: string;
  LFile: TJSONObject;
begin
  AddAuthParameters;
  FRequest.Resource  := sFiles;
try
  Today:= TimeZone.Local.ToUniversalTime(Now);
  LTimeStampStr:= LApp42Utils.GetUTCFormattedTime(Today);
  LUniqeFileId := LTimeStampStr.Replace(':','e').Replace('-','a').Replace('.','b');

  SignParamsDics.Add('name',LUniqeFileId);
  SignParamsDics.Add('type',AContentType);
  SignParamsDics.Add('description',AFileName);
  LSignature := LApp42Utils.Sign(SignParamsDics, FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);

   Params:=Tidmultipartformdatastream.Create;
   Params.AddFormField('uploadFile', AContentType, '', AStream, AFileName);
   Params.AddFormField('name',LUniqeFileId);
   Params.AddFormField('type', AContentType);
   Params.AddFormField('description',AFileName);

   http:=TIdHTTP.Create(nil);
   http.Request.CustomHeaders.AddValue('signature',LSignature);
  http.Request.Accept := 'application/json';
  http.Request.CustomHeaders.AddValue(sTimestamp,LTimeStampStr);
  http.Request.CustomHeaders.AddValue(sApiKey, FConnectionInfo.ApiKey);
  http.Request.CustomHeaders.AddValue(sApiVersion, FConnectionInfo.ApiVersion);

  LMultiPartBaseUrl := cDefaultBaseURL+sFiles;
  LResponseStr := http.Post(LMultiPartBaseUrl,Params);
  LResponse := TJsonObject.ParseJsonValue(LResponseStr) as TJSONObject;
  LFile := LApp42Utils.RootFromResponse(LResponse);
  ANewFile := FileIDFromObject(AFileName, LFile);

    finally
  http.Free;
  SignParamsDics.Free;
  Params.Free;
   end;
end;

//Method- DELETE
//url-https://api.shephertz.com/cloud/1.0/upload/{fileName}
function TApp42Api.DeleteFile(const AFileID: TFile): Boolean;
var
  LApp42Utils: TApp42Utils;
  LSignature: string;
begin
  FRequest.ResetToDefaults;
   AddAuthParameters;
    SignParamsDics.Add('name',AFileID.Name);
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
  Result := DeleteResource(sFiles + '/' + AFileID.Name, False);
end;


procedure TApp42Api.UploadInstallation(const AJSON: TJSONObject; out ANewObject: TObjectID);
var
  LResponse: TJSONObject;
begin
  PostResource(sInstallations, AJSON.ToString, True);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  ANewObject := ObjectIDFromObject('', LResponse);
end;


procedure TApp42Api.UpdateInstallation(const AObjectID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
   LMessage: string;
begin
  CheckObjectID(AObjectID);
  LMessage := '{"app42":{"storage":{"jsonDoc":'+AJSONObject.ToString+'}}}';
  PutResource(sInstallations + '/' + AObjectID, LMessage, True);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUpdatedAt := UpdatedAtFromObject('', AObjectID, LResponse);
end;


//Method - DELETE
//URL - api.shephertz.com/cloud/1.0/user/{username}
function TApp42Api.DeleteUser(const AObjectID: string): Boolean;
var
LApp42Utils : TApp42Utils;
LSignature, LUserName : string;
LResponse, LStorageObj: TJSONObject;
begin
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('dbName', sDBName);
  SignParamsDics.Add('collectionName', sUserCollectionName);
  SignParamsDics.Add('docId', AObjectID);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := sStorage + '/deleteDocById/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + AObjectID;
  FRequest.Execute;
  CheckForResponseError([404]);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LStorageObj := LApp42Utils.RootFromResponse(LResponse);
  LUserName := LStorageObj.GetValue('userName').Value;
  FRequest.ResetToDefaults;
  AddAuthParameters;
  SignParamsDics.Add('userName', LUserName);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  Result := DeleteResource(sUsers + '/' + LUserName, False);
end;

function TApp42Api.DeleteUser(const ALogin: TLogin): Boolean;
var
LApp42Utils : TApp42Utils;
LSignature, LUserName : string;
LResponse, LStorageObj: TJSONObject;
begin
  CheckObjectID(ALogin.User.ObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameters;
 // AddSessionToken(ConnectionInfo.ApiKey, ALogin.SessionToken);
  // This operation require AdminKey or session authentication
  SignParamsDics.Add('dbName', sDBName);
  SignParamsDics.Add('collectionName', sUserCollectionName);
  SignParamsDics.Add('docId', ALogin.User.ObjectID);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature', LSignature);
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := sStorage + '/deleteDocById/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + ALogin.User.ObjectID;
  FRequest.Execute;
  CheckForResponseError([404]);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LStorageObj := LApp42Utils.RootFromResponse(LResponse);
  LUserName := LStorageObj.GetValue('userName').Value;
  Result := DeleteResource(sUsers + '/' + LUserName, False);
end;

//Method - GET
//URL - https://api.shephertz.com/cloud/1.0/storage/findDocById/dbName/{DBName}/collectionName/{CollectionName}/docId/{AObjectID};
function TApp42API.RetrieveUser(const ASessionID, AObjectID: string; out AUser: TUser; const AJSON: TJSONArray;  AProc: TRetrieveUserProc; AReset: Boolean): Boolean;
var
  LResponse: TJSONObject;
  LSignature: string;
  LApp42Utils: TApp42Utils;
  LUserQuery: string;
  LUser: TJSONObject;
begin
  Result := False;
  CheckObjectID(AObjectID);
  if AReset then
  begin
    FRequest.ResetToDefaults;
    if ASessionID <> '' then
 // AddSessionToken(ConnectionInfo.ApiKey, ASessionID)
    else
      AddAuthParameters;
 end;
 try
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sStorage + '/findDocById/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + AObjectID;
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('collectionName', sUserCollectionName);
  SignParamsDics.Add('docId',AObjectID);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LUser :=  LApp42Utils.RootFromResponse(LResponse);
    AUser := UserFromObject(LUser);
    if AJSON <> nil then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LResponse);
  end
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
//  FRequest.ResetToDefaults;
//  // TODO: Check for authentication
//  AddAuthParameters;
  Result := RetrieveUser(ASessionToken, 'me', AUser, AJSON, AProc, True);    // Do not localize
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

//Method - GET
//URL - https://api.shephertz.com/cloud/1.0/storage/updateKeysByDocId/dbName/{DBNAME}/collectionName/{CollectionName}/docId/{DOCID}
function TApp42Api.QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean;
var
  LUsers: TJSONArray;
  LUser: TJSONObject;
  LSignature: string;
  LApp42Utils: TApp42Utils;
  LResponse,LApp42,LSuccess,LStorage,LJsonDoc: TJSONObject;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sStorage + '/findDocByKV/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/userName/' + AUserName;
  SignParamsDics.Add('dbName',sDBName);
  SignParamsDics.Add('collectionName',sUserCollectionName);
  SignParamsDics.Add('key','userName');
  SignParamsDics.Add('value',AUserName);
  LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
  Request.Params.AddHeader('signature',LSignature);
  FRequest.Execute;
  CheckForResponseError;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LApp42    := LResponse.Get('app42').JsonValue as TJSONObject;
    LSuccess := LApp42.Get('response').JsonValue as TJSONObject;
    LStorage := LSuccess.Get('storage').JsonValue as TJSONObject;
    LUsers := LStorage.Get('jsonDoc').JsonValue as TJSONArray;
  if LUsers.Count > 1 then
    raise Exception.Create('Multiple users');
  Result := LUsers.Count = 1;
  if Result then
  begin
    LUser := LUsers.Items[0] as TJSONObject;
    AUser := UserFromObject(LUser);
    if Assigned(AJSON) then
      AJSON.AddElement(LUser.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LUser);
  end;
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


//Method - POST
//URL - https://api.shephertz.com/cloud/1.0/user/authenticateAndCreateSession
procedure TApp42Api.LoginUser(const AUserName, APassword: string; AProc: TLoginProc);
var
  LResponse: TJsonObject;
  LLogin: TLogin;
  LApp42Utils: TApp42Utils;
  LUser: TJSONObject;
  LMessage: string;
  LSignature: string;
  LApp42, LSuccess, LUsersObj, LUserObj: TJSONObject;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUsers+'/authenticateAndCreateSession'; // do not localize
  try
    LUser := TJSONObject.Create;
    LUser.AddPair('userName', AUserName); // Do not localize
    LUser.AddPair('password', APassword); // Do not localize

    LMessage := '{"app42":{"user":'+LUser.ToString+'}}';
    FRequest.AddBody(LMessage, ctAPPLICATION_JSON);
    SignParamsDics.Add('body',LMessage);
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
    FRequest.Execute;
  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  LApp42:= LResponse.Get('app42').JsonValue as TJSONObject;
  LSuccess := LApp42.Get('response').JsonValue as TJSONObject;
  LUsersObj := LSuccess.Get('users').JsonValue as TJSONObject;
  LUserObj := LUsersObj.Get('user').JsonValue as TJSONObject;
  if Assigned(AProc) then
  begin
    LLogin := LoginFromObject(AUserName, LUserObj);
    AProc(LLogin, LUserObj);
  end;
  finally
      FreeAndNil(LUser);
  end;
end;

procedure TApp42Api.Logout;
begin
  FSessionToken := '';
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

//Method - POST
//URL - https://api.shephertz.com/cloud/1.0/user
procedure TApp42Api.SignupUser(const AUserName, APassword: string; const AUserFields: TJSONObject;
  out ANewUser: TLogin);
var
  LResponse, LUserObj, LUserDetails, LUser, LDBCredentials : TJSONObject;
  LApp42Utils: TApp42Utils;
  LSignature, LBody : string;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUsers;
  if AUserFields <> nil then
  begin
    LDBCredentials:= TJSONObject.Create;
    LUserDetails := TJSONObject.Create;
    AUserFields.AddPair('userName', AUserName);
    LUserDetails := AUserFields.Clone as TJSONObject;
    LDBCredentials.AddPair('dbName', sDBName); // Do not localize
    LDBCredentials.AddPair('collectionName', sUserCollectionName); // Do not localize
    // Adding UserDetails to headers With DBName And Collection Name.
    Request.Params.AddHeader('jsonObject', LUserDetails.ToString);
    Request.Params.AddHeader('Delphi_DbCredentials',LDBCredentials.ToString);
    LUser := TJSONObject.Create;
  end
  else
    LUser := TJSONObject.Create;
  try
    LUser.AddPair('userName', AUserName); // Do not localize
    LUser.AddPair('password', APassword); // Do not localize
    LUser.AddPair('email', AUserName); // Do not localize

    // Creating JSON Body for User Post Request.
    LBody := '{"app42":{"user":'+LUser.ToString+'}}';  // Do not localize
    FRequest.AddBody(LBody, ctAPPLICATION_JSON);
    SignParamsDics.Add('body',LBody);
    LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
    Request.Params.AddHeader('signature',LSignature);
    FRequest.Execute;
    CheckForResponseError([201]);
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    LUserObj := LApp42Utils.RootFromResponse(LResponse);
    ANewUser := LoginFromObject(AUserName, LUserObj);
  finally
    LUser.Free;
    SignParamsDics.Free;
  end;
end;

//Method - PUT
//URL - https://api.shephertz.com/cloud/1.0/storage/updateKeysByDocId/dbName/{DBNAME}/collectionName/{CollectionName}/docId/{DOCID}
procedure TApp42Api.UpdateUser(const ASessionID, AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
  LBody, LSignature: string;
  LApp42Utils: TApp42Utils;
begin
  FRequest.ResetToDefaults;
  AddAuthParameters;
   LBody := '{"app42":{"storage":{"jsonDoc":'+AUserObject.ToString+'}}}';
try
   SignParamsDics.Add('body',LBody);
   SignParamsDics.Add('collectionName',sUserCollectionName);
   SignParamsDics.Add('dbName',sDBName);
   SignParamsDics.Add('docId',AObjectID);

   LSignature := LApp42Utils.Sign(SignParamsDics,FConnectionInfo.SecretKey);
   Request.Params.AddHeader('signature',LSignature);
   FRequest.Method := TRESTRequestMethod.rmPUT;
   PutResource(sStorage + '/updateKeysByDocId/dbName/' + sDBName + '/collectionName/' + sUserCollectionName + '/docId/' + AObjectID, LBody, False);
   LResponse := FRequest.Response.JSONValue as TJSONObject;
   AUpdatedAt := UpdatedAtFromObject('', AObjectID, LResponse);
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

 //Method - GET
//URL - https://api.shephertz.com/cloud/1.0/storage/findDocsByQuery/dbName/{DBNAME}/collectionName/{CollectionName}
procedure TApp42Api.QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  QueryResource(sStorage + '/findDocsByQuery/dbName/' + sDBName + '/collectionName/' + sUserCollectionName, sUserCollectionName, AQuery, AJSONArray, True);
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
        raise Exception.Create('Not object');
    end;
    AUsers := LList.ToArray;
  finally
    LList.Free;
  end;
end;


{ EApp42Exception }

constructor EApp42Exception.Create(ACode: Integer; const AError: string);
begin
  FCode := ACode;
  FError := AError;
 // inherited CreateFmt(sFormatApp42Error, [Self.Error, Self.Code]);
end;


{ TApp42Api.TConnectionInfo }

constructor TApp42Api.TConnectionInfo.Create(const AApiKey, ASecretKey: string);
begin
//  ApiVersion := AApiVersion;
  ApiKey := AApiKey;
  SecretKey := ASecretKey;
 // ApplicationID := AApplicationID;
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


function TApp42Utils.Sign(const SignParamsDic: TDictionary<string,string>; AKey: string) : string;
var
  SigningParamsStr: string;
  LSignature:string;
begin
  SigningParamsStr:= ConverAndSortParamsToString(SignParamsDic);
  LSignature := ComputeHmac(SigningParamsStr, AKey);
  Result:= LSignature;
end;

function TApp42Utils.ComputeHmac(const AData, AKey: string) : string;
var
  Key: TIdBytes;
  ResBytes: TIdBytes;
begin
  with TIdHMACSHA1.Create do
  try
    Key := ToBytes(AKey);
    ResBytes := HashValue(ToBytes(AData));
    Result := EncodeBase64(ResBytes,Length(ResBytes));
  finally
    Free;
  end;
end;

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


function TApp42Utils.GetUTCFormattedTime(const ACurrentTime: TDateTime) : string;
var
 UTCTime: string;
begin
  UTCTime:= DateToISO8601(ACurrentTime);
  Result:= UTCTime;
end;



function TApp42Utils.RootFromResponse(const AResponse: TJSONObject) : TJSONObject;
var
LApp42, LSuccess, LNodeObj, LUploadObj: TJSONObject;
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
else
   Result := AResponse;
end;
end.

