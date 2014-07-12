{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2014 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}
{$HPPEMIT LINKUNIT}
unit REST.Backend.App42Services;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.ServiceTypes,
  REST.Backend.MetaTypes,
  REST.Backend.App42Provider,
  REST.Backend.App42Api;

type
  // Files service

  TApp42FilesAPI = class(TApp42ServiceAPIAuth, IBackendFilesApi)
  protected
    { IBackendFilesAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure UploadFile(const AFileName: string; const AContentType: string;
      out AFile: TBackendEntityValue); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string;
      out AFile: TBackendEntityValue); overload;
    function DeleteFile(const AFile: TBackendEntityValue): Boolean;
  end;

  TApp42FilesService = class(TApp42BackendService<TApp42FilesAPI>, IBackendService, IBackendFilesService)
  protected
    { IBackendFilesService }
    function CreateFilesApi: IBackendFilesApi;
    function GetFilesApi: IBackendFilesApi;
  end;

  // Push service

  TApp42PushAPI = class(TApp42ServiceAPIAuth, IBackendPushApi)
  protected
    { IBackendPushAPI }
    procedure PushBroadcast(const AData: TPushData);
  end;

  TApp42PushService = class(TApp42BackendService<TApp42PushAPI>, IBackendService, IBackendPushService)
  protected
    { IBackendPushService }
    function CreatePushApi: IBackendPushApi;
    function GetPushApi: IBackendPushApi;
  end;

  // Query service

  TApp42QueryAPI = class(TApp42ServiceAPIAuth, IBackendQueryApi)
  protected
    { IBackendQueryAPI }
    procedure GetServiceNames(out ANames: TArray<string>);
    function GetMetaFactory: IBackendMetaFactory;
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
  end;

  TApp42QueryService = class(TApp42BackendService<TApp42QueryAPI>, IBackendService, IBackendQueryService)
  protected
    { IBackendQueryService }
    function CreateQueryApi: IBackendQueryApi;
    function GetQueryApi: IBackendQueryApi;
  end;

  // Users service

  TApp42UsersAPI = class(TApp42ServiceAPIAuth, IBackendUsersApi)
  protected
    { IBackendUsersAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure SignupUser(const AUserName, APassword: string; const AUserData: TJSONObject;
      out ACreatedObject: TBackendEntityValue);
    procedure LoginUser(const AUserName, APassword: string; AProc: TFindObjectProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray); overload;

    function DeleteUser(const AObject: TBackendEntityValue): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
    function QueryUserName(const AUserName: string; AProc: TFindObjectProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
  end;

  TApp42UsersService = class(TApp42BackendService<TApp42UsersAPI>, IBackendService, IBackendUsersService)
  protected
    { IBackendUsersService }
    function CreateUsersApi: IBackendUsersApi;
    function GetUsersApi: IBackendUsersApi;
  end;

  // Storage service

  TApp42StorageAPI = class(TApp42ServiceAPIAuth, IBackendStorageAPI)
  protected
    { IBackendStorageAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure CreateObject(const AClass: TBackendMetaClass; const AACL, AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    function DeleteObject(const AObject: TBackendEntityValue): Boolean;
    function FindObject(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateObject(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
  end;

  TApp42StorageService = class(TApp42BackendService<TApp42StorageAPI>, IBackendService, IBackendStorageService)
  protected
    { IBackendStorageService }
    function CreateStorageApi: IBackendStorageApi;
    function GetStorageApi: IBackendStorageApi;
  end;

implementation

uses
  System.TypInfo, System.Generics.Collections, REST.Backend.ServiceFactory,
  REST.Backend.App42MetaTypes, REST.Backend.Consts, REST.Backend.Exception;

type
  TApp42ProviderServiceFactory<T: IBackendService> = class(TProviderServiceFactory<T>)
  var
    FMethod: TFunc<IBackendProvider, IBackendService>;
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; override;
  public
    constructor Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
  end;

{ TApp42ProviderServiceFactory<T> }

constructor TApp42ProviderServiceFactory<T>.Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
begin
  inherited Create(TCustomApp42Provider.ProviderID, 'REST.Backend.App42Services');
  FMethod := AMethod;
end;

function TApp42ProviderServiceFactory<T>.CreateService(
  const AProvider: IBackendProvider; const IID: TGUID): IBackendService;
begin
  Result := FMethod(AProvider);
end;

{ TApp42FilesService }

function TApp42FilesService.CreateFilesApi: IBackendFilesApi;
begin
  Result := CreateBackendApi;
end;

function TApp42FilesService.GetFilesApi: IBackendFilesApi;
begin
  EnsureBackendApi;
  Result := FBackendAPI;
end;

{ TApp42PushAPI }

procedure TApp42PushAPI.PushBroadcast(
  const AData: TPushData);
const
  cMessage = 'message';
var
  LJSON: TJSONObject;
begin
  if AData <> nil then
  begin
    LJSON := TJSONObject.Create;
    try
      // Flat object
      AData.SaveMessage(LJSON, cMessage);
      AData.Extras.Save(LJSON, '');
      AData.GCM.Save(LJSON, '');
      AData.APS.Save(LJSON, '');
      App42API.PushBroadcast(LJSON)
    finally
      LJSON.Free;
    end;
  end
  else
    App42API.PushBroadcast(nil)
end;

{ TApp42PushService }

function TApp42PushService.CreatePushApi: IBackendPushApi;
begin
  Result := CreateBackendApi;
end;

function TApp42PushService.GetPushApi: IBackendPushApi;
begin
  EnsureBackendApi;
  Result := FBackendAPI;
end;

{ TApp42QueryAPI }

procedure TApp42QueryAPI.GetServiceNames(out ANames: TArray<string>);
begin
  ANames := TArray<string>.Create(
    TBackendQueryServiceNames.Storage,
    TBackendQueryServiceNames.Users,
    TBackendQueryServiceNames.Installations);
end;

function TApp42QueryAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TApp42QueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
    App42API.QueryClass(
      AClass.BackendClassName, AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    App42API.QueryUsers(
      AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Installations) then
    App42API.QueryInstallation(
      AQuery, AJSONArray)
  else
    raise EBackendServiceError.CreateFmt(sUnsupportedBackendQueryType, [AClass.BackendDataType]);
end;

procedure TApp42QueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>);
var
  LObjectIDArray: TArray<TApp42API.TObjectID>;
  LUsersArray: TArray<TApp42API.TUser>;
  LObjectID: TApp42API.TObjectID;
  LList: TList<TBackendEntityValue>;
  LUser: TApp42API.TUser;
begin

  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
    App42API.QueryClass(
      AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    App42API.QueryUsers(
      AQuery, AJSONArray, LUsersArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Installations) then
    App42API.QueryInstallation(
      AQuery, AJSONArray, LObjectIDArray)
  else
    raise EBackendServiceError.CreateFmt(sUnsupportedBackendQueryType, [AClass.BackendDataType]);

  if Length(LUsersArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUsersArray do
        LList.Add(TApp42MetaFactory.CreateMetaFoundUser(LUser));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

  if Length(LObjectIDArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LObjectID in LObjectIDArray do
        LList.Add(TApp42MetaFactory.CreateMetaClassObject(LObjectID));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

end;

{ TApp42QueryService }

function TApp42QueryService.CreateQueryApi: IBackendQueryApi;
begin
  Result := CreateBackendApi;
end;

function TApp42QueryService.GetQueryApi: IBackendQueryApi;
begin
  EnsureBackendApi;
  Result := FBackendAPI;
end;

{ TApp42UsersService }

function TApp42UsersService.CreateUsersApi: IBackendUsersApi;
begin
  Result := CreateBackendApi;
end;

function TApp42UsersService.GetUsersApi: IBackendUsersApi;
begin
  EnsureBackendApi;
  Result := FBackendAPI;
end;

{ TApp42StorageAPI }


procedure TApp42StorageAPI.CreateObject(const AClass: TBackendMetaClass;
  const AACL, AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LNewObject: TApp42API.TObjectID;
begin
  App42API.CreateClass(AClass.BackendClassName, AACL, AJSON, LNewObject);
  ACreatedObject := TApp42MetaFactory.CreateMetaCreatedObject(LNewObject)
end;

function TApp42StorageAPI.DeleteObject(
  const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaObject then
    Result := App42API.DeleteClass((AObject.Data as TMetaObject).ObjectID)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TApp42StorageAPI.FindObject(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaObject: TMetaObject;
begin
  if AObject.Data is TMetaObject then
  begin
    LMetaObject := TMetaObject(AObject.Data);
    Result := App42API.FindClass(LMetaObject.ObjectID,
      procedure(const AID: TApp42API.TObjectID; const AObj: TJSONObject)
      begin
        AProc(TApp42MetaFactory.CreateMetaFoundObject(AID), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TApp42StorageAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TApp42StorageAPI.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  App42API.QueryClass(AClass.BackendClassName, AQuery, AJSONArray);
end;

procedure TApp42StorageAPI.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AObjects: TArray<TBackendEntityValue>);
var
  LObjectIDArray: TArray<TApp42API.TObjectID>;
  LObjectID: TApp42API.TObjectID;
  LList: TList<TBackendEntityValue>;
begin
  App42API.QueryClass(AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray);
  if Length(LObjectIDArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LObjectID in LObjectIDArray do
        LList.Add(TApp42MetaFactory.CreateMetaClassObject(LObjectID));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

procedure TApp42StorageAPI.UpdateObject(const AObject: TBackendEntityValue;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LObjectID: TApp42API.TUpdatedAt;
  LMetaObject: TMetaObject;
begin
  if AObject.Data is TMetaObject then
  begin
    LMetaObject := TMetaObject(AObject.Data);
    App42API.UpdateClass(LMetaObject.ObjectID, AJSONObject, LObjectID);
    AUpdatedObject := TApp42MetaFactory.CreateMetaUpdatedObject(LObjectID);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TApp42StorageService }

function TApp42StorageService.CreateStorageApi: IBackendStorageApi;
begin
  Result := CreateBackendApi;
end;

function TApp42StorageService.GetStorageApi: IBackendStorageApi;
begin
  EnsureBackendApi;
  Result := FBackendAPI;
end;

var
  FFactories: TList<TProviderServiceFactory>;

procedure RegisterServices;
var
  LFactory: TProviderServiceFactory;
begin
  FFactories := TObjectList<TProviderServiceFactory>.Create;
  // Files
  LFactory := TApp42ProviderServiceFactory<IBackendFilesService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TApp42FilesService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Users
  LFactory := TApp42ProviderServiceFactory<IBackendUsersService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TApp42UsersService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Storage
  LFactory := TApp42ProviderServiceFactory<IBackendStorageService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TApp42StorageService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Query
  LFactory := TApp42ProviderServiceFactory<IBackendQueryService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TApp42QueryService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Push
  LFactory := TApp42ProviderServiceFactory<IBackendPushService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TApp42PushService.Create(AProvider);
    end);
  FFactories.Add(LFactory);
  for LFactory in FFactories do
    LFactory.Register;
end;

procedure UnregisterServices;
var
  LFactory: TProviderServiceFactory;
begin
  for LFactory in FFactories do
    LFactory.Unregister;
  FreeAndNil(FFactories);
end;

{ TApp42UsersAPI }

function TApp42UsersAPI.DeleteUser(const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaLogin then
    Result := App42API.DeleteUser((AObject.Data as TMetaLogin).Login)
  else if AObject.Data is TMetaUser then
    Result := App42API.DeleteUser((AObject.Data as TMetaUser).User.ObjectID)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TApp42UsersAPI.FindUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
begin
  if AObject.Data is TMetaLogin then
  begin
    Result := App42API.RetrieveUser(TMetaLogin(AObject.Data).Login,
      procedure(const AUser: TApp42API.TUser; const AObj: TJSONObject)
      begin
        AProc(TApp42MetaFactory.CreateMetaFoundUser(AUser), AObj);
      end);
  end
  else if AObject.Data is TMetaUser then
  begin
    Result := App42API.RetrieveUser(TMetaUser(AObject.Data).User.ObjectID,
      procedure(const AUser: TApp42API.TUser; const AObj: TJSONObject)
      begin
        AProc(TApp42MetaFactory.CreateMetaFoundUser(AUser), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TApp42UsersAPI.FindUser(const AObject: TBackendEntityValue;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LUser: TApp42API.TUser;
begin
  if AObject.Data is TMetaLogin then
    Result := App42API.RetrieveUser(TMetaLogin(AObject.Data).Login, LUser, AJSON)
  else if AObject.Data is TMetaUser then
    Result := App42API.RetrieveUser(TMetaUser(AObject.Data).User.ObjectID, LUser, AJSON)
  else
    raise EArgumentException.Create(sParameterNotMetaType);

  AUser := TApp42MetaFactory.CreateMetaFoundUser(LUser);
end;

function TApp42UsersAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

function TApp42UsersAPI.FindCurrentUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaLogin: TMetaLogin;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    App42API.Login(LMetaLogin.Login);
    try
      Result := App42API.RetrieveCurrentUser(
        procedure(const AUser: TApp42API.TUser; const AObj: TJSONObject)
        begin
          AProc(TApp42MetaFactory.CreateMetaFoundUser(AUser), AObj);
        end);
    finally
      App42API.Logout;
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TApp42UsersAPI.FindCurrentUser(const AObject: TBackendEntityValue;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LMetaLogin: TMetaLogin;
  LUser: TApp42API.TUser;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    App42API.Login(LMetaLogin.Login);
    try
      Result := App42API.RetrieveCurrentUser(LUser, AJSON);
      AUser := TApp42MetaFactory.CreateMetaFoundUser(LUser);
    finally
      App42API.Logout;
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

procedure TApp42UsersAPI.LoginUser(const AUserName, APassword: string;
  AProc: TFindObjectProc);
begin
  App42API.LoginUser(AUserName, APassword,
   procedure(const ALogin: TApp42API.TLogin; const AUserObject: TJSONObject)
   begin
      AProc(TApp42MetaFactory.CreateMetaLoginUser(ALogin), AUserObject);
   end);
end;

procedure TApp42UsersAPI.LoginUser(const AUserName, APassword: string;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray);
var
  LLogin: TApp42API.TLogin;
begin
  App42API.LoginUser(AUserName, APassword, LLogin, AJSON);
  AUser := TApp42MetaFactory.CreateMetaLoginUser(LLogin);
end;


function TApp42UsersAPI.QueryUserName(const AUserName: string;
  AProc: TFindObjectProc): Boolean;
begin
  Result := App42API.QueryUserName(AUserName,
    procedure(const AUser: TApp42API.TUser; const AObj: TJSONObject)
    begin
      AProc(TApp42MetaFactory.CreateMetaFoundUser(AUser), AObj);
    end);
end;

function TApp42UsersAPI.QueryUserName(const AUserName: string;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LUser: TApp42API.TUser;
begin
  Result := App42API.QueryUserName(AUserName, LUser, AJSON);
  AUser := TApp42MetaFactory.CreateMetaFoundUser(LUser);
end;


procedure TApp42UsersAPI.QueryUsers(
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  App42API.QueryUsers(
    AQuery, AJSONArray);
end;

procedure TApp42UsersAPI.QueryUsers(
  const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>);
var
  LUserArray: TArray<TApp42API.TUser>;
  LUser: TApp42API.TUser;
  LList: TList<TBackendEntityValue>;
begin
  App42API.QueryUsers(
    AQuery, AJSONArray, LUserArray);
  if Length(LUserArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUserArray do
        LList.Add(TApp42MetaFactory.CreateMetaFoundUser(LUser));
      AMetaArray := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

end;

procedure TApp42UsersAPI.SignupUser(const AUserName, APassword: string;
  const AUserData: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LLogin: TApp42API.TLogin;
begin
  App42API.SignupUser(AUserName, APassword, AUserData, LLogin);
  ACreatedObject := TApp42MetaFactory.CreateMetaSignupUser(LLogin);
end;

procedure TApp42UsersAPI.UpdateUser(const AObject: TBackendEntityValue;
  const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TApp42API.TUpdatedAt;
begin
  if AObject.Data is TMetaLogin then
  begin
    App42API.UpdateUser(TMetaLogin(AObject.Data).Login, AUserData, LUpdated);
    AUpdatedObject := TApp42MetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else if AObject.Data is TMetaUser then
  begin
    App42API.UpdateUser(TMetaUser(AObject.Data).User.ObjectID, AUserData, LUpdated);
    AUpdatedObject := TApp42MetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TApp42FilesAPI }


procedure TApp42FilesAPI.UploadFile(const AFileName, AContentType: string;
  out AFile: TBackendEntityValue);
var
  LFile: TApp42API.TFile;
begin
  // Upload public file
  App42API.UploadFile(AFileName, AContentType,LFile);
  AFile :=  TApp42MetaFactory.CreateMetaUploadedFile(LFile);
end;

function TApp42FilesAPI.DeleteFile(const AFile: TBackendEntityValue): Boolean;
var
  LMetaFile: TMetaFile;
begin
  if AFile.Data is TMetaFile then
  begin
    LMetaFile := TMetaFile(AFile.Data);
    Result := App42API.DeleteFile(LMetaFile.FileValue);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TApp42FilesAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TApp42FilesAPI.UploadFile(const AFileName: string;
  const AStream: TStream; const AContentType: string;
  out AFile: TBackendEntityValue);
var
  LFile: TApp42API.TFile;
begin
  // Upload public file
  App42API.UploadFile(AFileName, AStream, AContentType, LFile);
  AFile :=  TApp42MetaFactory.CreateMetaUploadedFile(LFile);
end;

initialization
  RegisterServices;
finalization
  UnregisterServices;

end.


