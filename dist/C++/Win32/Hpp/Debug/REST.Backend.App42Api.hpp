// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'REST.Backend.App42Api.pas' rev: 27.00 (Windows)

#ifndef Rest_Backend_App42apiHPP
#define Rest_Backend_App42apiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Generics.Collections.hpp>	// Pascal unit
#include <System.JSON.hpp>	// Pascal unit
#include <REST.Client.hpp>	// Pascal unit
#include <REST.Types.hpp>	// Pascal unit
#include <REST.Backend.Exception.hpp>	// Pascal unit
#include <System.Generics.Defaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rest
{
namespace Backend
{
namespace App42api
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EApp42APIError;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EApp42APIError : public Rest::Backend::Exception::EBackendError
{
	typedef Rest::Backend::Exception::EBackendError inherited;
	
private:
	int FCode;
	System::UnicodeString FError;
	
public:
	__fastcall EApp42APIError(int ACode, const System::UnicodeString AError)/* overload */;
	__property int Code = {read=FCode, nodefault};
	__property System::UnicodeString Error = {read=FError};
public:
	/* Exception.CreateFmt */ inline __fastcall EApp42APIError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High) : Rest::Backend::Exception::EBackendError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EApp42APIError(NativeUInt Ident)/* overload */ : Rest::Backend::Exception::EBackendError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EApp42APIError(System::PResStringRec ResStringRec)/* overload */ : Rest::Backend::Exception::EBackendError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EApp42APIError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High)/* overload */ : Rest::Backend::Exception::EBackendError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EApp42APIError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High)/* overload */ : Rest::Backend::Exception::EBackendError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EApp42APIError(const System::UnicodeString Msg, int AHelpContext) : Rest::Backend::Exception::EBackendError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EApp42APIError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High, int AHelpContext) : Rest::Backend::Exception::EBackendError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EApp42APIError(NativeUInt Ident, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EApp42APIError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EApp42APIError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EApp42APIError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EApp42APIError(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TApp42APIErrorClass;

class DELPHICLASS TApp42Api;
class PASCALIMPLEMENTATION TApp42Api : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	enum class DECLSPEC_DENUM TPlatformType : unsigned char { IOS, Android };
	
	struct DECLSPEC_DRECORD TDeviceNames
	{
public:
		#define TApp42Api_TDeviceNames_IOS L"ios"
		
		#define TApp42Api_TDeviceNames_Android L"android"
		
	};
	
	
	struct DECLSPEC_DRECORD TConnectionInfo
	{
public:
		System::UnicodeString ApiVersion;
		System::UnicodeString ApiKey;
		System::UnicodeString SecretKey;
		System::UnicodeString AdminKey;
		System::UnicodeString UserName;
		System::UnicodeString ProxyPassword;
		int ProxyPort;
		System::UnicodeString ProxyServer;
		System::UnicodeString ProxyUsername;
		__fastcall TConnectionInfo(const System::UnicodeString AApiVersion, const System::UnicodeString AApiKey);
		TConnectionInfo() {}
	};
	
	
	struct DECLSPEC_DRECORD TUpdatedAt
	{
private:
		System::TDateTime FUpdatedAt;
		System::UnicodeString FObjectID;
		System::UnicodeString FBackendClassName;
		
public:
		__fastcall TUpdatedAt(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, System::TDateTime AUpdatedAt);
		__property System::TDateTime UpdatedAt = {read=FUpdatedAt};
		__property System::UnicodeString ObjectID = {read=FObjectID};
		__property System::UnicodeString BackendClassName = {read=FBackendClassName};
		TUpdatedAt() {}
	};
	
	
	struct DECLSPEC_DRECORD TObjectID
	{
private:
		System::TDateTime FCreatedAt;
		System::TDateTime FUpdatedAt;
		System::UnicodeString FObjectID;
		System::UnicodeString FBackendClassName;
		
public:
		__fastcall TObjectID(const System::UnicodeString ABackendClassName, System::UnicodeString AObjectID);
		__property System::TDateTime CreatedAt = {read=FCreatedAt};
		__property System::TDateTime UpdatedAt = {read=FUpdatedAt};
		__property System::UnicodeString ObjectID = {read=FObjectID};
		__property System::UnicodeString BackendClassName = {read=FBackendClassName};
		TObjectID() {}
	};
	
	
	struct DECLSPEC_DRECORD TUser
	{
private:
		System::TDateTime FCreatedAt;
		System::TDateTime FUpdatedAt;
		System::UnicodeString FObjectID;
		System::UnicodeString FUserName;
		
public:
		__fastcall TUser(const System::UnicodeString AUserName);
		__property System::TDateTime CreatedAt = {read=FCreatedAt};
		__property System::TDateTime UpdatedAt = {read=FUpdatedAt};
		__property System::UnicodeString ObjectID = {read=FObjectID};
		__property System::UnicodeString UserName = {read=FUserName};
		TUser() {}
	};
	
	
	struct DECLSPEC_DRECORD TLogin
	{
private:
		System::UnicodeString FSessionToken;
		TApp42Api::TUser FUser;
		
public:
		__fastcall TLogin(const System::UnicodeString ASessionToken, const TApp42Api::TUser &AUser);
		__property System::UnicodeString SessionToken = {read=FSessionToken};
		__property TApp42Api::TUser User = {read=FUser};
		TLogin() {}
	};
	
	
	struct DECLSPEC_DRECORD TFile
	{
private:
		System::UnicodeString FName;
		System::UnicodeString FFileName;
		System::UnicodeString FDownloadURL;
		
public:
		__fastcall TFile(const System::UnicodeString AName);
		__property System::UnicodeString FileName = {read=FFileName};
		__property System::UnicodeString DownloadURL = {read=FDownloadURL};
		__property System::UnicodeString Name = {read=FName};
		TFile() {}
	};
	
	
	enum class DECLSPEC_DENUM TAuthentication : unsigned char { Default, AdminKey, APIKey, Session, None };
	
	typedef System::Set<TAuthentication, TAuthentication::Default, TAuthentication::None> TAuthentications;
	
	enum class DECLSPEC_DENUM TDefaultAuthentication : unsigned char { APIKey, AdminKey, Session, None };
	
	__interface TFindObjectProc;
	typedef System::DelphiInterface<TFindObjectProc> _di_TFindObjectProc;
	__interface TFindObjectProc  : public System::IInterface 
	{
		
public:
		virtual void __fastcall Invoke(const TApp42Api::TObjectID &AID, System::Json::TJSONObject* const AObj) = 0 ;
	};
	
	__interface TQueryUserNameProc;
	typedef System::DelphiInterface<TQueryUserNameProc> _di_TQueryUserNameProc;
	__interface TQueryUserNameProc  : public System::IInterface 
	{
		
public:
		virtual void __fastcall Invoke(const TApp42Api::TUser &AUser, System::Json::TJSONObject* const AUserObject) = 0 ;
	};
	
	__interface TLoginProc;
	typedef System::DelphiInterface<TLoginProc> _di_TLoginProc;
	__interface TLoginProc  : public System::IInterface 
	{
		
public:
		virtual void __fastcall Invoke(const TApp42Api::TLogin &ALogin, System::Json::TJSONObject* const AUserObject) = 0 ;
	};
	
	__interface TRetrieveUserProc;
	typedef System::DelphiInterface<TRetrieveUserProc> _di_TRetrieveUserProc;
	__interface TRetrieveUserProc  : public System::IInterface 
	{
		
public:
		virtual void __fastcall Invoke(const TApp42Api::TUser &AUser, System::Json::TJSONObject* const AUserObject) = 0 ;
	};
	
	
private:
	#define TApp42Api_sStorage L"storage"
	
	#define TApp42Api_sFiles L"upload"
	
	#define TApp42Api_sUsers L"user"
	
	#define TApp42Api_sPush L"push"
	
	#define TApp42Api_sSession L"session"
	
	
public:
	#define TApp42Api_cDefaultApiVersion L"1.0"
	
	#define TApp42Api_cDefaultBaseURL L"https://api.shephertz.com/cloud/1.0/"
	
	static const bool DateTimeIsUTC = true;
	
	static TConnectionInfo EmptyConnectionInfo;
	
private:
	Rest::Client::TRESTClient* FRESTClient;
	Rest::Client::TRESTRequest* FRequest;
	Rest::Client::TRESTResponse* FResponse;
	bool FOwnsResponse;
	System::UnicodeString FBaseURL;
	TConnectionInfo FConnectionInfo;
	System::UnicodeString FSessionToken;
	TAuthentication FAuthentication;
	TDefaultAuthentication FDefaultAuthentication;
	void __fastcall SetConnectionInfo(const TConnectionInfo &Value);
	void __fastcall SetBaseURL(const System::UnicodeString Value);
	bool __fastcall GetLoggedIn(void);
	
protected:
	void __fastcall AddAdminKey(const System::UnicodeString AKey)/* overload */;
	void __fastcall AddAPIKey(const System::UnicodeString AKey)/* overload */;
	void __fastcall AddDefaultAuth(const System::UnicodeString ADefault)/* overload */;
	void __fastcall AddSessionToken(const System::UnicodeString ASessionToken)/* overload */;
	void __fastcall ApplyConnectionInfo(void);
	void __fastcall CheckAuthentication(TAuthentications AAuthentication);
	TAuthentication __fastcall GetActualAuthentication(void);
	EApp42APIError* __fastcall CreateException(Rest::Client::TRESTRequest* const ARequest, const TApp42APIErrorClass AClass);
	void __fastcall CheckForResponseError(int *AValidStatusCodes, const int AValidStatusCodes_High)/* overload */;
	void __fastcall CheckForResponseError(void)/* overload */;
	void __fastcall CheckForResponseError(Rest::Client::TRESTRequest* const ARequest)/* overload */;
	void __fastcall CheckForResponseError(Rest::Client::TRESTRequest* const ARequest, int *AValidStatusCodes, const int AValidStatusCodes_High)/* overload */;
	void __fastcall PostResource(const System::UnicodeString AResource, System::Json::TJSONObject* const AJSON, bool AReset);
	void __fastcall PutResource(const System::UnicodeString AResource, System::Json::TJSONObject* const AJSONObject, bool AReset);
	bool __fastcall DeleteResource(const System::UnicodeString AResource, bool AReset)/* overload */;
	TObjectID __fastcall ObjectIDFromObject(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, System::Json::TJSONObject* const AJSONObject)/* overload */;
	TFile __fastcall FileIDFromObject(const System::UnicodeString AFileName, System::Json::TJSONObject* const AJSONObject);
	void __fastcall AddAuthParameters(void)/* overload */;
	void __fastcall AddAuthParameters(TAuthentication AAuthentication)/* overload */;
	bool __fastcall FindClass(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, /* out */ TObjectID &AFoundObject, System::Json::TJSONArray* const AJSON, _di_TFindObjectProc AProc)/* overload */;
	bool __fastcall QueryUserName(const System::UnicodeString AUserName, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON, _di_TQueryUserNameProc AProc)/* overload */;
	TLogin __fastcall LoginFromObject(const System::UnicodeString AUserName, System::Json::TJSONObject* const AJSONObject);
	TUser __fastcall UserFromObject(const System::UnicodeString AUserName, System::Json::TJSONObject* const AJSONObject)/* overload */;
	TUpdatedAt __fastcall UpdatedAtFromObject(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, System::Json::TJSONObject* const AJSONObject);
	void __fastcall QueryResource(const System::UnicodeString AResource, System::UnicodeString ACollection, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, bool AReset);
	bool __fastcall RetrieveCurrentUser(const System::UnicodeString ASessionToken, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON, _di_TRetrieveUserProc AProc)/* overload */;
	bool __fastcall RetrieveUser(const System::UnicodeString ASessionID, const System::UnicodeString AObjectID, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON, _di_TRetrieveUserProc AProc, bool AReset)/* overload */;
	bool __fastcall RetrieveLoggedInUser(const System::UnicodeString ASessionID, const System::UnicodeString AObjectID, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON, _di_TRetrieveUserProc AProc, bool AReset);
	void __fastcall UpdateUser(const System::UnicodeString ASessionID, const System::UnicodeString AObjectID, System::Json::TJSONObject* const AUserObject, /* out */ TUpdatedAt &AUpdatedAt)/* overload */;
	__property Rest::Client::TRESTClient* RestClient = {read=FRESTClient};
	__property Rest::Client::TRESTRequest* Request = {read=FRequest};
	
public:
	__fastcall TApp42Api(System::Classes::TComponent* AOwner, Rest::Client::TRESTResponse* const AResponse)/* overload */;
	__fastcall virtual ~TApp42Api(void);
	TUser __fastcall UserFromObject(System::Json::TJSONObject* const AJSONObject)/* overload */;
	TObjectID __fastcall ObjectIDFromObject(const System::UnicodeString ABackendClassName, System::Json::TJSONObject* const AJSONObject)/* overload */;
	void __fastcall CreateClass(const System::UnicodeString ABackendClassName, System::Json::TJSONObject* const AJSON, /* out */ TObjectID &ANewObject)/* overload */;
	void __fastcall CreateClass(const System::UnicodeString ABackendClassName, System::Json::TJSONObject* const AACL, System::Json::TJSONObject* const AJSON, /* out */ TObjectID &ANewObject)/* overload */;
	bool __fastcall DeleteClass(const TObjectID &AID)/* overload */;
	bool __fastcall DeleteClass(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID)/* overload */;
	bool __fastcall FindClass(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, _di_TFindObjectProc AProc)/* overload */;
	bool __fastcall FindClass(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, /* out */ TObjectID &AFoundObjectID, System::Json::TJSONArray* const AFoundJSON = (System::Json::TJSONArray*)(0x0))/* overload */;
	bool __fastcall FindClass(const TObjectID &AID, _di_TFindObjectProc AProc)/* overload */;
	bool __fastcall FindClass(const TObjectID &AID, /* out */ TObjectID &AFoundObjectID, System::Json::TJSONArray* const AFoundJSON = (System::Json::TJSONArray*)(0x0))/* overload */;
	void __fastcall UpdateClass(const System::UnicodeString ABackendClassName, const System::UnicodeString AObjectID, System::Json::TJSONObject* const AJSONObject, /* out */ TUpdatedAt &AUpdatedAt)/* overload */;
	void __fastcall UpdateClass(const TObjectID &AID, System::Json::TJSONObject* const AJSONObject, /* out */ TUpdatedAt &AUpdatedAt)/* overload */;
	void __fastcall QueryClass(const System::UnicodeString ABackendClassName, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray)/* overload */;
	void __fastcall QueryClass(const System::UnicodeString ABackendClassName, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, /* out */ System::DynamicArray<TObjectID> &AObjects)/* overload */;
	System::Json::TJSONObject* __fastcall CreateAndroidInstallationObject(const System::UnicodeString AInstallationID, System::UnicodeString *AChannels, const int AChannels_High);
	System::Json::TJSONObject* __fastcall CreateIOSInstallationObject(const System::UnicodeString ADeviceToken, int ABadge, System::UnicodeString *AChannels, const int AChannels_High);
	void __fastcall UploadInstallation(System::Json::TJSONObject* const AJSON, /* out */ TObjectID &ANewObject);
	void __fastcall UpdateInstallation(const System::UnicodeString AObjectID, System::Json::TJSONObject* const AJSONObject, /* out */ TUpdatedAt &AUpdatedAt);
	bool __fastcall DeleteInstallation(const System::UnicodeString AObjectID)/* overload */;
	void __fastcall QueryInstallation(System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray)/* overload */;
	void __fastcall QueryInstallation(System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, /* out */ System::DynamicArray<TObjectID> &AObjects)/* overload */;
	void __fastcall PushRegisterDevice(TPlatformType APlatformType, const System::UnicodeString ADeviceID, const System::UnicodeString AUserID)/* overload */;
	void __fastcall PushRegisterDevice(TPlatformType APlatformType, const System::UnicodeString ADeviceID)/* overload */;
	void __fastcall PushRegisterDevice(TPlatformType APlatformType, const System::UnicodeString ADeviceID, const TUser &AUser)/* overload */;
	void __fastcall PushUnregisterDevice(TPlatformType APlatformType, const System::UnicodeString ADeviceID, const System::UnicodeString AUserID)/* overload */;
	void __fastcall PushUnregisterDevice(TPlatformType APlatformType, const System::UnicodeString ADeviceID, const TUser &AUser)/* overload */;
	void __fastcall PushUnregisterDevice(TPlatformType APlatformType, const System::UnicodeString ADeviceID)/* overload */;
	void __fastcall PushBody(System::Json::TJSONObject* const AMessage);
	void __fastcall PushToDevices(System::UnicodeString const *ADevices, const int ADevices_High, System::Json::TJSONObject* const AData);
	void __fastcall PushBroadcast(System::Json::TJSONObject* const AData);
	void __fastcall PushToChannels(System::UnicodeString const *AChannels, const int AChannels_High, System::Json::TJSONObject* const AData);
	void __fastcall PushWhere(System::Json::TJSONObject* const AWhere, System::Json::TJSONObject* const AData);
	void __fastcall UploadFile(const System::UnicodeString AFileName, const System::UnicodeString AContentType, /* out */ TFile &ANewFile)/* overload */;
	void __fastcall UploadFile(const System::UnicodeString AFileName, System::Classes::TStream* const AStream, const System::UnicodeString AContentType, /* out */ TFile &ANewFile)/* overload */;
	bool __fastcall DeleteFile(const TFile &AFileID);
	bool __fastcall CreateSessionFromLogin(const System::UnicodeString AUserName, System::UnicodeString ASessionId, const TUser &AUser);
	System::Json::TJSONObject* __fastcall UserFromUserName(const System::UnicodeString AUserName);
	bool __fastcall QueryUserName(const System::UnicodeString AUserName, _di_TQueryUserNameProc AProc)/* overload */;
	bool __fastcall QueryUserName(const System::UnicodeString AUserName, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON = (System::Json::TJSONArray*)(0x0))/* overload */;
	bool __fastcall RetrieveUser(const System::UnicodeString AObjectID, _di_TRetrieveUserProc AProc)/* overload */;
	bool __fastcall RetrieveUser(const System::UnicodeString AObjectID, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON = (System::Json::TJSONArray*)(0x0))/* overload */;
	bool __fastcall RetrieveUser(const TLogin &ALogin, _di_TRetrieveUserProc AProc)/* overload */;
	bool __fastcall RetrieveUser(const TLogin &ALogin, /* out */ TUser &AUser, System::Json::TJSONArray* const AJSON)/* overload */;
	void __fastcall SignupUser(const System::UnicodeString AUserName, const System::UnicodeString APassword, System::Json::TJSONObject* const AUserFields, /* out */ TLogin &ANewUser);
	void __fastcall LoginUser(const System::UnicodeString AUserName, const System::UnicodeString APassword, _di_TLoginProc AProc)/* overload */;
	void __fastcall LoginUser(const System::UnicodeString AUserName, const System::UnicodeString APassword, /* out */ TLogin &ALogin, System::Json::TJSONArray* const AJSONArray = (System::Json::TJSONArray*)(0x0))/* overload */;
	bool __fastcall RetrieveCurrentUser(_di_TRetrieveUserProc AProc)/* overload */;
	bool __fastcall RetrieveCurrentUser(/* out */ TUser &AUser, System::Json::TJSONArray* const AJSON = (System::Json::TJSONArray*)(0x0))/* overload */;
	bool __fastcall RetrieveCurrentUser(const TLogin &ALogin, _di_TRetrieveUserProc AProc)/* overload */;
	bool __fastcall RetrieveCurrentUser(const TLogin &ALogin, System::Json::TJSONArray* const AJSON)/* overload */;
	void __fastcall UpdateUser(const System::UnicodeString AObjectID, System::Json::TJSONObject* const AUserObject, /* out */ TUpdatedAt &AUpdatedAt)/* overload */;
	void __fastcall UpdateUser(const TLogin &ALogin, System::Json::TJSONObject* const AUserObject, /* out */ TUpdatedAt &AUpdatedAt)/* overload */;
	bool __fastcall DeleteUser(const System::UnicodeString AObjectID)/* overload */;
	bool __fastcall DeleteUser(const TLogin &ALogin)/* overload */;
	void __fastcall QueryUsers(System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray)/* overload */;
	void __fastcall QueryUsers(System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, /* out */ System::DynamicArray<TUser> &AUsers)/* overload */;
	void __fastcall Login(const System::UnicodeString ASessionToken)/* overload */;
	void __fastcall Login(const TLogin &ALogin)/* overload */;
	void __fastcall Logout(void);
	__property bool LoggedIn = {read=GetLoggedIn, nodefault};
	__property TAuthentication Authentication = {read=FAuthentication, write=FAuthentication, nodefault};
	__property TDefaultAuthentication DefaultAuthentication = {read=FDefaultAuthentication, write=FDefaultAuthentication, nodefault};
	__property Rest::Client::TRESTResponse* Response = {read=FResponse};
	__property System::UnicodeString BaseURL = {read=FBaseURL, write=SetBaseURL};
	__property TConnectionInfo ConnectionInfo = {read=FConnectionInfo, write=SetConnectionInfo};
};


class DELPHICLASS TApp42Utils;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42Utils : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Json::TJSONArray* __fastcall BuildCompoundQueryString(System::Json::TJSONArray* const q1, System::Json::TJSONObject* q2, System::Json::TJSONObject* q3);
	System::Json::TJSONObject* __fastcall BuildQueryString(const System::UnicodeString q1);
	System::UnicodeString __fastcall Sign(System::Generics::Collections::TDictionary__2<System::UnicodeString,System::UnicodeString>* const SignParamsDic, System::UnicodeString AKey);
	System::UnicodeString __fastcall CreateSignature(const System::UnicodeString AData, const System::UnicodeString Akey);
	System::UnicodeString __fastcall ConverAndSortParamsToString(System::Generics::Collections::TDictionary__2<System::UnicodeString,System::UnicodeString>* const SignParamsDic);
	System::UnicodeString __fastcall GetUTCFormattedTime(const System::TDateTime ACurrentTime);
	System::Json::TJSONObject* __fastcall RootNodeFromResponse(System::Json::TJSONObject* const AResponse);
public:
	/* TObject.Create */ inline __fastcall TApp42Utils(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TApp42Utils(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Generics::Collections::TDictionary__2<System::UnicodeString,System::UnicodeString>* SignParamsDics;
}	/* namespace App42api */
}	/* namespace Backend */
}	/* namespace Rest */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST_BACKEND_APP42API)
using namespace Rest::Backend::App42api;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST_BACKEND)
using namespace Rest::Backend;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST)
using namespace Rest;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rest_Backend_App42apiHPP
