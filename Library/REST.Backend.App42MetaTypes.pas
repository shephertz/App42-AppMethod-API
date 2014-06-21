{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2014 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}
unit REST.Backend.App42MetaTypes;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Backend.Providers,
  REST.Backend.MetaTypes,
  REST.Backend.App42Provider,
  REST.Backend.App42Api;

type

  // Describe an object
  TMetaObject = class(TInterfacedObject, IBackendMetaObject)
  private
    FObjectID: TApp42API.TObjectID;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetClassName: string;
  public
    constructor Create(const AObjectID: TApp42API.TObjectID);
    property ObjectID: TApp42API.TObjectID read FObjectID;
  end;

  // Define MetaObject with ObjectID and CreatedAt properties
  TMetaCreatedObject = class(TMetaObject, IBackendMetaObject,
     IBackendObjectID, IBackendClassName, IBackendCreatedAt)
  end;

  // Define MetaObject with ObjectID and BackendClassName properties
  TMetaClassObject = class(TMetaObject, IBackendMetaObject, IBackendClassName,
     IBackendObjectID)
  end;

  // Define MetaObject with UpdatedAt properties
  TMetaUpdatedObject = class(TInterfacedObject, IBackendMetaObject)
  private
    FUpdatedAt: TApp42API.TUpdatedAt;
  protected
    function GetObjectID: string;
    function GetUpdatedAt: TDateTime;
    function GetClassName: string;
  public
    constructor Create(const AUpdatedAt: TApp42API.TUpdatedAt);
    property ObjectID: TApp42API.TUpdatedAt read FUpdatedAt;
  end;

  // Describe a user object
  TMetaUser = class(TInterfacedObject, IBackendMetaObject)
  private
    FUser: TApp42API.TUser;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetUserName: string;
  public
    constructor Create(const AUser: TApp42API.TUser);
    property User: TApp42API.TUser read FUser;
  end;

  // Describe an uploaded file
  TMetaFile = class(TInterfacedObject, IBackendMetaObject)
  private
    FFile: TApp42API.TFile;
  protected
    function GetDownloadURL: string;
    function GetFileName: string;
    function GetFileID: string;
  public
    constructor Create(const AFile: TApp42API.TFile); overload;
    constructor Create(const AFileID: string); overload;
    property FileValue: TApp42API.TFile read FFile;
  end;

  // Define MetaObject with ObjectID and BackendClassName properties
  TMetaUserObject = class(TMetaUser, IBackendMetaObject,
     IBackendObjectID)
  end;

  // Describe an logged in user
  TMetaLogin = class(TMetaUser)
  private
    FLogin: TApp42API.TLogin;
  protected
    function GetAuthTOken: string;
  public
    constructor Create(const ALogin: TApp42API.TLogin);
    property Login: TApp42API.TLogin read FLogin;
  end;

  TMetaFoundObject = class(TMetaObject, IBackendMetaObject, IBackendClassName,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt)
  end;

  TMetaUploadedFile = class(TMetaFile, IBackendMetaObject, IBackendFileID, IBackendFileName,
     IBackendDownloadURL)
  end;

  TMetaFileObject = class(TMetaFile, IBackendMetaObject, IBackendFileID)
  end;

  // Define MetaObject with UpdatedAt properties
  TMetaUpdatedUser = class(TMetaUser, IBackendMetaObject, IBackendUpdatedAt, IBackendUserName)
  end;

  TMetaFoundUser = class(TMetaUser, IBackendMetaObject,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt, IBackendUserName)
  end;

  TMetaLoginUser = class(TMetaLogin, IBackendMetaObject,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt, IBackendUserName, IBackendAuthToken)
  end;

  TMetaSignupUser = class(TMetaLogin, IBackendMetaObject,
     IBackendObjectID, IBackendCreatedAt, IBackendUserName, IBackendAuthToken)
  end;

  // Describe a backend class
  TMetaClass = class(TInterfacedObject, IBackendMetaObject)
  private
    FClassName: string;
    FDataType: string;
  protected
    function GetClassName: string;
    function GetDataType: string;
  public
    constructor Create(const AClassName: string); overload;
    constructor Create(const ADataType, AClassName: string); overload;
  end;

  // Defined backend class with ClassName property
  TMetaClassName = class(TMetaClass, IBackendMetaClass, IBackendClassName)
  end;

  // Defined backend class with ClassName and DataType property
  TMetaDataType = class(TMetaClass, IBackendMetaClass, IBackendClassName, IBackendDataType)
  end;

  TMetaFactory = class(TInterfacedObject, IBackendMetaFactory, IBackendMetaClassFactory,
    IBackendMetaClassObjectFactory, IBackendMetaDataTypeFactory, IBackendMetaFileFactory)
  protected
    { IBackendMetaClassFactory }
    function CreateMetaClass(const AClassName: string): TBackendMetaClass;
    { IBackendMetaClassObjectFactory }
    function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue;
    { IBackendMetaDataTypeFactory }
    function CreateMetaDataType(const ADataType, ABackendClassName: string): TBackendMetaClass;
    { IBackendMetaFileFactory }
    function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
  end;

  TApp42MetaFactory = class
  public
    // Class
    class function CreateMetaClass(const AClassName: string): TBackendMetaClass; static;
    class function CreateMetaDataType(const ADataType, AClassName: string): TBackendMetaClass; overload; static;
    // Object
     class function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue; overload;static;
    class function CreateMetaClassObject(const AObjectID: TApp42API.TObjectID): TBackendEntityValue; overload;static;
    class function CreateMetaCreatedObject(
      const AObjectID: TApp42API.TObjectID): TBackendEntityValue; static;
    class function CreateMetaFoundObject(const AObjectID: TApp42API.TObjectID): TBackendEntityValue; static;
    class function CreateMetaUpdatedObject(const AUpdatedAt: TApp42API.TUpdatedAt): TBackendEntityValue; static;
   // User
    class function CreateMetaUpdatedUser(const AUpdatedAt: TApp42API.TUpdatedAt): TBackendEntityValue; overload; static;
    class function CreateMetaSignupUser(const ALogin: TApp42API.TLogin): TBackendEntityValue; overload; static;
    class function CreateMetaLoginUser(const ALogin: TApp42API.TLogin): TBackendEntityValue; overload; static;
    class function CreateMetaFoundUser(const AUser: TApp42API.TUser): TBackendEntityValue; static;
    // Files
    class function CreateMetaUploadedFile(const AFile: TApp42API.TFile): TBackendEntityValue; static;
    class function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
  end;

implementation

{ TMetaCreatedObject }

constructor TMetaObject.Create(const AObjectID: TApp42API.TObjectID);
begin
  inherited Create;
  FObjectID := AObjectID;
end;

function TMetaObject.GetCreatedAt: TDateTime;
begin
  Result := FObjectID.CreatedAt;
end;

function TMetaObject.GetObjectID: string;
begin
  Result := FObjectID.ObjectID;
end;

function TMetaObject.GetUpdatedAt: TDateTime;
begin
  Result := FObjectID.UpdatedAt;
end;

function TMetaObject.GetClassName: string;
begin
  Result := FObjectID.BackendClassName;
end;

{ TMetaClass }

constructor TMetaClass.Create(const AClassName: string);
begin
  inherited Create;
  FClassName := AClassName;
end;

constructor TMetaClass.Create(const ADataType, AClassName: string);
begin
  Create(AClassName);
  FDataType := ADataType;
end;

function TMetaClass.GetClassName: string;
begin
  Result := FClassName;
end;

function TMetaClass.GetDataType: string;
begin
  Result := FDataType;
end;

{ TMetaFactory }

function TMetaFactory.CreateMetaClass(
  const AClassName: string): TBackendMetaClass;
begin
  Result := TApp42MetaFactory.CreateMetaClass(AClassName);
end;

function TMetaFactory.CreateMetaClassObject(
  const AClassName: string; const AObjectID: string): TBackendEntityValue;
begin
  Result := TApp42MetaFactory.CreateMetaClassObject(AClassName, AObjectID);
end;

function TMetaFactory.CreateMetaDataType(const ADataType,
  ABackendClassName: string): TBackendMetaClass;
begin
  Result := TApp42MetaFactory.CreateMetaDataType(ADataType, ABackendClassName);
end;

function TMetaFactory.CreateMetaFileObject(
  const AFileID: string): TBackendEntityValue;
begin
  Result := TApp42MetaFactory.CreateMetaFileObject(AFileID);
end;

{ TApp42MetaFactory }

class function TApp42MetaFactory.CreateMetaClass(
  const AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaClassName.Create(AClassName);
  Assert(Supports(LIntf, IBackendClassName));
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaClassObject(
  const AClassName: string; const AObjectID: string): TBackendEntityValue;
var
  LObjectID: TApp42API.TObjectID;
begin
  LObjectID := TApp42API.TObjectID.Create(AClassName, AObjectID);
  Result := CreateMetaClassObject(LObjectID);
end;

class function TApp42MetaFactory.CreateMetaClassObject(
  const AObjectID: TApp42API.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaClassObject.Create(AObjectID);
  Assert(Supports(LIntf, IBackendClassName));
  Assert(Supports(LIntf, IBackendObjectID));
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaCreatedObject(
  const AObjectID: TApp42API.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaCreatedObject.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaDataType(const ADataType,
  AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaDataType.Create(ADataType, AClassName);
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaFileObject(
  const AFileID: string): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFileObject.Create(AFileID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaFoundObject(
  const AObjectID: TApp42API.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundObject.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaFoundUser(
  const AUser: TApp42API.TUser): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundUser.Create(AUser);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaLoginUser(
  const ALogin: TApp42API.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaLoginUser.Create(ALogin);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaSignupUser(
  const ALogin: TApp42API.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaSignupUser.Create(ALogin);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaUpdatedObject(
  const AUpdatedAt: TApp42API.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedObject.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaUpdatedUser(
  const AUpdatedAt: TApp42API.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedObject.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TApp42MetaFactory.CreateMetaUploadedFile(
  const AFile: TApp42API.TFile): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUploadedFile.Create(AFile);
  Result := TBackendEntityValue.Create(LIntf);
end;

{ TMetaUpdateObject }

constructor TMetaUpdatedObject.Create(const AUpdatedAt: TApp42API.TUpdatedAt);
begin
  FUpdatedAt := AUpdatedAt;
end;

function TMetaUpdatedObject.GetClassName: string;
begin
  Result := FUpdatedAt.BackendClassName;
end;

function TMetaUpdatedObject.GetObjectID: string;
begin
  Result := FUpdatedAt.ObjectID;
end;

function TMetaUpdatedObject.GetUpdatedAt: TDateTime;
begin
  Result := FUpdatedAt.UpdatedAt;
end;

{ TMetaUser }

constructor TMetaUser.Create(const AUser: TApp42API.TUser);
begin
  FUser := AUser;
end;

function TMetaUser.GetCreatedAt: TDateTime;
begin
  Result := FUser.CreatedAt;
end;

function TMetaUser.GetObjectID: string;
begin
  Result := FUser.ObjectID;
end;

function TMetaUser.GetUpdatedAt: TDateTime;
begin
  Result := FUser.UpdatedAt;
end;

function TMetaUser.GetUserName: string;
begin
  Result := FUser.UserName;
end;

{ TMetaLogin }

constructor TMetaLogin.Create(const ALogin: TApp42API.TLogin);
begin
  inherited Create(ALogin.User);
  FLogin := ALogin;
end;

function TMetaLogin.GetAuthTOken: string;
begin
  Result := FLogin.SessionToken;
end;

{ TMetaFile }

constructor TMetaFile.Create(const AFile: TApp42API.TFile);
begin
  FFile := AFile;
end;

function TMetaFile.GetFileID: string;
begin
  Result := FFile.Name;
end;

function TMetaFile.GetFileName: string;
begin
  Result := FFile.FileName;
end;

constructor TMetaFile.Create(const AFileID: string);
begin
  FFile := TApp42API.TFile.Create(AFileID);
end;

function TMetaFile.GetDownloadURL: string;
begin
  Result := FFile.DownloadURL;
end;

end.

