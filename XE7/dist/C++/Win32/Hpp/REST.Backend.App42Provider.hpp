// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'REST.Backend.App42Provider.pas' rev: 28.00 (Windows)

#ifndef Rest_Backend_App42providerHPP
#define Rest_Backend_App42providerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Generics.Collections.hpp>	// Pascal unit
#include <REST.Backend.Providers.hpp>	// Pascal unit
#include <REST.Backend.App42Api.hpp>	// Pascal unit
#include <REST.Client.hpp>	// Pascal unit
#include <REST.Backend.ServiceTypes.hpp>	// Pascal unit
#include <REST.Backend.MetaTypes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Generics.Defaults.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
#pragma link "REST.Backend.App42Provider"

namespace Rest
{
namespace Backend
{
namespace App42provider
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCustomApp42ConnectionInfo;
class PASCALIMPLEMENTATION TCustomApp42ConnectionInfo : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	class DELPHICLASS TNotifyList;
	#pragma pack(push,4)
	class PASCALIMPLEMENTATION TNotifyList : public System::TObject
	{
		typedef System::TObject inherited;
		
private:
		System::Generics::Collections::TList__1<System::Classes::TNotifyEvent>* FList;
		void __fastcall Notify(System::TObject* Sender);
		
public:
		__fastcall TNotifyList(void);
		__fastcall virtual ~TNotifyList(void);
		void __fastcall Add(const System::Classes::TNotifyEvent ANotify);
		void __fastcall Remove(const System::Classes::TNotifyEvent ANotify);
	};
	
	#pragma pack(pop)
	
	class DELPHICLASS TAndroidPush;
	#pragma pack(push,4)
	class PASCALIMPLEMENTATION TAndroidPush : public System::Classes::TPersistent
	{
		typedef System::Classes::TPersistent inherited;
		
private:
		System::UnicodeString FGCMAppID;
		
protected:
		virtual void __fastcall AssignTo(System::Classes::TPersistent* AValue);
		
__published:
		__property System::UnicodeString GCMAppID = {read=FGCMAppID, write=FGCMAppID};
public:
		/* TPersistent.Destroy */ inline __fastcall virtual ~TAndroidPush(void) { }
		
public:
		/* TObject.Create */ inline __fastcall TAndroidPush(void) : System::Classes::TPersistent() { }
		
	};
	
	#pragma pack(pop)
	
	
private:
	Rest::Backend::App42api::TApp42Api::TConnectionInfo FConnectionInfo;
	TNotifyList* FNotifyOnChange;
	TAndroidPush* FAndroidPush;
	void __fastcall SetApiVersion(const System::UnicodeString Value);
	void __fastcall SetApiKey(const System::UnicodeString Value);
	void __fastcall SetSecretKey(const System::UnicodeString Value);
	void __fastcall SetAdminKey(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetApiVersion(void);
	System::UnicodeString __fastcall GetSecretKey(void);
	System::UnicodeString __fastcall GetAdminKey(void);
	System::UnicodeString __fastcall GetApiKey(void);
	void __fastcall SetAndroidPush(TAndroidPush* const Value);
	System::UnicodeString __fastcall GetUserName(void);
	void __fastcall SetUserName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetProxyPassword(void);
	int __fastcall GetProxyPort(void);
	System::UnicodeString __fastcall GetProxyServer(void);
	System::UnicodeString __fastcall GetProxyUsername(void);
	void __fastcall SetProxyPassword(const System::UnicodeString Value);
	void __fastcall SetProxyPort(const int Value);
	void __fastcall SetProxyServer(const System::UnicodeString Value);
	void __fastcall SetProxyUsername(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall DoChanged(void);
	__property TNotifyList* NotifyOnChange = {read=FNotifyOnChange};
	
public:
	__fastcall virtual TCustomApp42ConnectionInfo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomApp42ConnectionInfo(void);
	void __fastcall UpdateApi(Rest::Backend::App42api::TApp42Api* const AApp42Api);
	__property System::UnicodeString ApiVersion = {read=GetApiVersion, write=SetApiVersion};
	__property System::UnicodeString ApiKey = {read=GetApiKey, write=SetApiKey};
	__property System::UnicodeString SecretKey = {read=GetSecretKey, write=SetSecretKey};
	__property System::UnicodeString AdminKey = {read=GetAdminKey, write=SetAdminKey};
	__property TAndroidPush* AndroidPush = {read=FAndroidPush, write=SetAndroidPush};
	__property System::UnicodeString UserName = {read=GetUserName, write=SetUserName};
	__property System::UnicodeString ProxyPassword = {read=GetProxyPassword, write=SetProxyPassword};
	__property int ProxyPort = {read=GetProxyPort, write=SetProxyPort, default=0};
	__property System::UnicodeString ProxyServer = {read=GetProxyServer, write=SetProxyServer};
	__property System::UnicodeString ProxyUsername = {read=GetProxyUsername, write=SetProxyUsername};
};


class DELPHICLASS TCustomApp42Provider;
class PASCALIMPLEMENTATION TCustomApp42Provider : public TCustomApp42ConnectionInfo
{
	typedef TCustomApp42ConnectionInfo inherited;
	
public:
	#define TCustomApp42Provider_ProviderID L"App42"
	
	
protected:
	System::UnicodeString __fastcall GetProviderID(void);
public:
	/* TCustomApp42ConnectionInfo.Create */ inline __fastcall virtual TCustomApp42Provider(System::Classes::TComponent* AOwner) : TCustomApp42ConnectionInfo(AOwner) { }
	/* TCustomApp42ConnectionInfo.Destroy */ inline __fastcall virtual ~TCustomApp42Provider(void) { }
	
private:
	void *__IRESTIPComponent;	// Rest::Client::IRESTIPComponent 
	void *__IBackendProvider;	// Rest::Backend::Providers::IBackendProvider 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A0424865-78AE-47CA-A063-DAEF76C78004}
	operator Rest::Client::_di_IRESTIPComponent()
	{
		Rest::Client::_di_IRESTIPComponent intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Client::IRESTIPComponent*(void) { return (Rest::Client::IRESTIPComponent*)&__IRESTIPComponent; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C563AC66-8AF4-45D8-906C-161B061B912F}
	operator Rest::Backend::Providers::_di_IBackendProvider()
	{
		Rest::Backend::Providers::_di_IBackendProvider intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendProvider*(void) { return (Rest::Backend::Providers::IBackendProvider*)&__IBackendProvider; }
	#endif
	
};


class DELPHICLASS TApp42Provider;
class PASCALIMPLEMENTATION TApp42Provider : public TCustomApp42Provider
{
	typedef TCustomApp42Provider inherited;
	
__published:
	__property ApiVersion = {default=0};
	__property ApiKey = {default=0};
	__property SecretKey = {default=0};
	__property AdminKey = {default=0};
	__property UserName = {default=0};
	__property AndroidPush;
	__property ProxyPassword = {default=0};
	__property ProxyPort = {default=0};
	__property ProxyServer = {default=0};
	__property ProxyUsername = {default=0};
public:
	/* TCustomApp42ConnectionInfo.Create */ inline __fastcall virtual TApp42Provider(System::Classes::TComponent* AOwner) : TCustomApp42Provider(AOwner) { }
	/* TCustomApp42ConnectionInfo.Destroy */ inline __fastcall virtual ~TApp42Provider(void) { }
	
};


class DELPHICLASS TApp42BackendService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42BackendService : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TCustomApp42ConnectionInfo* FConnectionInfo;
	void __fastcall SetConnectionInfo(TCustomApp42ConnectionInfo* const Value);
	void __fastcall OnConnectionChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall DoAfterConnectionChanged(void);
	__property TCustomApp42ConnectionInfo* ConnectionInfo = {read=FConnectionInfo, write=SetConnectionInfo};
	
public:
	__fastcall virtual TApp42BackendService(const Rest::Backend::Providers::_di_IBackendProvider AProvider);
	__fastcall virtual ~TApp42BackendService(void);
};

#pragma pack(pop)

__interface IGetApp42API;
typedef System::DelphiInterface<IGetApp42API> _di_IGetApp42API;
__interface  INTERFACE_UUID("{9EFB309D-6A53-4F3B-8B7F-D9E7D92998E8}") IGetApp42API  : public System::IInterface 
{
	
public:
	virtual Rest::Backend::App42api::TApp42Api* __fastcall GetApp42API(void) = 0 ;
	__property Rest::Backend::App42api::TApp42Api* App42API = {read=GetApp42API};
};

class DELPHICLASS TApp42ServiceAPI;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42ServiceAPI : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Rest::Backend::App42api::TApp42Api* FApp42API;
	Rest::Backend::App42api::TApp42Api* __fastcall GetApp42API(void);
	
protected:
	__property Rest::Backend::App42api::TApp42Api* App42API = {read=FApp42API};
	
public:
	__fastcall TApp42ServiceAPI(void);
	__fastcall virtual ~TApp42ServiceAPI(void);
private:
	void *__IGetApp42API;	// IGetApp42API 
	void *__IBackendApi;	// Rest::Backend::Providers::IBackendApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {9EFB309D-6A53-4F3B-8B7F-D9E7D92998E8}
	operator _di_IGetApp42API()
	{
		_di_IGetApp42API intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGetApp42API*(void) { return (IGetApp42API*)&__IGetApp42API; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B2608078-946B-475D-B2DD-8523FDC1C773}
	operator Rest::Backend::Providers::_di_IBackendApi()
	{
		Rest::Backend::Providers::_di_IBackendApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendApi*(void) { return (Rest::Backend::Providers::IBackendApi*)&__IBackendApi; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42ServiceAPIAuth;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42ServiceAPIAuth : public TApp42ServiceAPI
{
	typedef TApp42ServiceAPI inherited;
	
protected:
	void __fastcall Login(const Rest::Backend::Metatypes::TBackendEntityValue &ALogin);
	void __fastcall Logout(void);
	void __fastcall SetDefaultAuthentication(Rest::Backend::Providers::TBackendDefaultAuthentication ADefaultAuthentication);
	Rest::Backend::Providers::TBackendDefaultAuthentication __fastcall GetDefaultAuthentication(void);
	void __fastcall SetAuthentication(Rest::Backend::Providers::TBackendAuthentication AAuthentication);
	Rest::Backend::Providers::TBackendAuthentication __fastcall GetAuthentication(void);
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42ServiceAPIAuth(void) : TApp42ServiceAPI() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42ServiceAPIAuth(void) { }
	
private:
	void *__IBackendAuthenticationApi;	// Rest::Backend::Servicetypes::IBackendAuthenticationApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {4C0D2ADD-B6B7-40ED-B6B5-5DB66B7ECE9D}
	operator Rest::Backend::Servicetypes::_di_IBackendAuthenticationApi()
	{
		Rest::Backend::Servicetypes::_di_IBackendAuthenticationApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendAuthenticationApi*(void) { return (Rest::Backend::Servicetypes::IBackendAuthenticationApi*)&__IBackendAuthenticationApi; }
	#endif
	
};

#pragma pack(pop)

template<typename TAPI> class DELPHICLASS TApp42BackendService__1;
#pragma pack(push,4)
// Template declaration generated by Delphi parameterized types is
// used only for accessing Delphi variables and fields.
// Don't instantiate with new type parameters in user code.
template<typename TAPI> class PASCALIMPLEMENTATION TApp42BackendService__1 : public TApp42BackendService
{
	typedef TApp42BackendService inherited;
	
private:
	TAPI FBackendAPI;
	System::_di_IInterface FBackendAPIIntf;
	void __fastcall ReleaseBackendApi(void);
	Rest::Backend::App42api::TApp42Api* __fastcall GetApp42API(void);
	
protected:
	virtual TAPI __fastcall CreateBackendApi(void);
	void __fastcall EnsureBackendApi(void);
	virtual void __fastcall DoAfterConnectionChanged(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42BackendService__1(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : TApp42BackendService(AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42BackendService__1(void) { }
	
private:
	void *__IGetApp42API;	// IGetApp42API 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {9EFB309D-6A53-4F3B-8B7F-D9E7D92998E8}
	operator _di_IGetApp42API()
	{
		_di_IGetApp42API intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGetApp42API*(void) { return (IGetApp42API*)&__IGetApp42API; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace App42provider */
}	/* namespace Backend */
}	/* namespace Rest */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST_BACKEND_APP42PROVIDER)
using namespace Rest::Backend::App42provider;
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
#endif	// Rest_Backend_App42providerHPP
