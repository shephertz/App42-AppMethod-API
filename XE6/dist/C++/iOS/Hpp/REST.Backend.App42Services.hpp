// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'REST.Backend.App42Services.pas' rev: 27.00 (iOS)

#ifndef Rest_Backend_App42servicesHPP
#define Rest_Backend_App42servicesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.JSON.hpp>	// Pascal unit
#include <REST.Backend.Providers.hpp>	// Pascal unit
#include <REST.Backend.PushTypes.hpp>	// Pascal unit
#include <REST.Backend.ServiceTypes.hpp>	// Pascal unit
#include <REST.Backend.MetaTypes.hpp>	// Pascal unit
#include <REST.Backend.App42Provider.hpp>	// Pascal unit
#include <REST.Backend.App42Api.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
namespace Rest
{
namespace Backend
{
namespace App42services
{
  _INIT_UNIT(Rest_Backend_App42services);
}	/* namespace App42services */
}	/* namespace Backend */
}	/* namespace Rest */

namespace Rest
{
namespace Backend
{
namespace App42services
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TApp42FilesAPI;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42FilesAPI : public Rest::Backend::App42provider::TApp42ServiceAPIAuth
{
	typedef Rest::Backend::App42provider::TApp42ServiceAPIAuth inherited;
	
protected:
	Rest::Backend::Metatypes::_di_IBackendMetaFactory __fastcall GetMetaFactory(void);
	void __fastcall UploadFile(const System::UnicodeString AFileName, const System::UnicodeString AContentType, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AFile)/* overload */;
	void __fastcall UploadFile(const System::UnicodeString AFileName, System::Classes::TStream* const AStream, const System::UnicodeString AContentType, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AFile)/* overload */;
	bool __fastcall DeleteFile(const Rest::Backend::Metatypes::TBackendEntityValue &AFile);
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42FilesAPI(void) : Rest::Backend::App42provider::TApp42ServiceAPIAuth() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42FilesAPI(void) { }
	
private:
	void *__IBackendFilesApi;	// Rest::Backend::Servicetypes::IBackendFilesApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {271C2472-D957-47C5-BC10-F3A15FF5261C}
	operator Rest::Backend::Servicetypes::_di_IBackendFilesApi()
	{
		Rest::Backend::Servicetypes::_di_IBackendFilesApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendFilesApi*(void) { return (Rest::Backend::Servicetypes::IBackendFilesApi*)&__IBackendFilesApi; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42FilesService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42FilesService : public Rest::Backend::App42provider::TApp42BackendService__1<TApp42FilesAPI*> 
{
	typedef Rest::Backend::App42provider::TApp42BackendService__1<TApp42FilesAPI*>  inherited;
	
protected:
	Rest::Backend::Servicetypes::_di_IBackendFilesApi __fastcall CreateFilesApi(void);
	Rest::Backend::Servicetypes::_di_IBackendFilesApi __fastcall GetFilesApi(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42FilesService(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : Rest::Backend::App42provider::TApp42BackendService__1<TApp42FilesAPI*> (AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42FilesService(void) { }
	
private:
	void *__IBackendFilesService;	// Rest::Backend::Servicetypes::IBackendFilesService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A925E828-73A5-41C0-93A4-4E12BC7949FB}
	operator Rest::Backend::Servicetypes::_di_IBackendFilesService()
	{
		Rest::Backend::Servicetypes::_di_IBackendFilesService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendFilesService*(void) { return (Rest::Backend::Servicetypes::IBackendFilesService*)&__IBackendFilesService; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E8BD0783-0E4D-459F-9EEC-11B5F29FE792}
	operator Rest::Backend::Providers::_di_IBackendService()
	{
		Rest::Backend::Providers::_di_IBackendService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendService*(void) { return (Rest::Backend::Providers::IBackendService*)&__IBackendFilesService; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42PushAPI;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42PushAPI : public Rest::Backend::App42provider::TApp42ServiceAPIAuth
{
	typedef Rest::Backend::App42provider::TApp42ServiceAPIAuth inherited;
	
protected:
	void __fastcall PushBroadcast(Rest::Backend::Pushtypes::TPushData* const AData);
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42PushAPI(void) : Rest::Backend::App42provider::TApp42ServiceAPIAuth() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42PushAPI(void) { }
	
private:
	void *__IBackendPushApi;	// Rest::Backend::Pushtypes::IBackendPushApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F7FAC938-CE46-42A9-B4D2-8620365A64B0}
	operator Rest::Backend::Pushtypes::_di_IBackendPushApi()
	{
		Rest::Backend::Pushtypes::_di_IBackendPushApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Pushtypes::IBackendPushApi*(void) { return (Rest::Backend::Pushtypes::IBackendPushApi*)&__IBackendPushApi; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42PushService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42PushService : public Rest::Backend::App42provider::TApp42BackendService__1<TApp42PushAPI*> 
{
	typedef Rest::Backend::App42provider::TApp42BackendService__1<TApp42PushAPI*>  inherited;
	
protected:
	Rest::Backend::Pushtypes::_di_IBackendPushApi __fastcall CreatePushApi(void);
	Rest::Backend::Pushtypes::_di_IBackendPushApi __fastcall GetPushApi(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42PushService(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : Rest::Backend::App42provider::TApp42BackendService__1<TApp42PushAPI*> (AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42PushService(void) { }
	
private:
	void *__IBackendPushService;	// Rest::Backend::Pushtypes::IBackendPushService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {34547227-6E40-40F7-A59D-4961FDBD499B}
	operator Rest::Backend::Pushtypes::_di_IBackendPushService()
	{
		Rest::Backend::Pushtypes::_di_IBackendPushService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Pushtypes::IBackendPushService*(void) { return (Rest::Backend::Pushtypes::IBackendPushService*)&__IBackendPushService; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E8BD0783-0E4D-459F-9EEC-11B5F29FE792}
	operator Rest::Backend::Providers::_di_IBackendService()
	{
		Rest::Backend::Providers::_di_IBackendService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendService*(void) { return (Rest::Backend::Providers::IBackendService*)&__IBackendPushService; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42QueryAPI;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42QueryAPI : public Rest::Backend::App42provider::TApp42ServiceAPIAuth
{
	typedef Rest::Backend::App42provider::TApp42ServiceAPIAuth inherited;
	
protected:
	void __fastcall GetServiceNames(/* out */ System::DynamicArray<System::UnicodeString> &ANames);
	Rest::Backend::Metatypes::_di_IBackendMetaFactory __fastcall GetMetaFactory(void);
	void __fastcall Query(const Rest::Backend::Metatypes::TBackendClassValue &AClass, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray)/* overload */;
	void __fastcall Query(const Rest::Backend::Metatypes::TBackendClassValue &AClass, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, /* out */ System::DynamicArray<Rest::Backend::Metatypes::TBackendEntityValue> &AObjects)/* overload */;
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42QueryAPI(void) : Rest::Backend::App42provider::TApp42ServiceAPIAuth() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42QueryAPI(void) { }
	
private:
	void *__IBackendQueryApi;	// Rest::Backend::Servicetypes::IBackendQueryApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {1F54E3F6-693D-4A25-AC00-7CFFC99D6632}
	operator Rest::Backend::Servicetypes::_di_IBackendQueryApi()
	{
		Rest::Backend::Servicetypes::_di_IBackendQueryApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendQueryApi*(void) { return (Rest::Backend::Servicetypes::IBackendQueryApi*)&__IBackendQueryApi; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42QueryService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42QueryService : public Rest::Backend::App42provider::TApp42BackendService__1<TApp42QueryAPI*> 
{
	typedef Rest::Backend::App42provider::TApp42BackendService__1<TApp42QueryAPI*>  inherited;
	
protected:
	Rest::Backend::Servicetypes::_di_IBackendQueryApi __fastcall CreateQueryApi(void);
	Rest::Backend::Servicetypes::_di_IBackendQueryApi __fastcall GetQueryApi(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42QueryService(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : Rest::Backend::App42provider::TApp42BackendService__1<TApp42QueryAPI*> (AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42QueryService(void) { }
	
private:
	void *__IBackendQueryService;	// Rest::Backend::Servicetypes::IBackendQueryService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {3A22E6DA-7139-4163-B981-DEED365D92B3}
	operator Rest::Backend::Servicetypes::_di_IBackendQueryService()
	{
		Rest::Backend::Servicetypes::_di_IBackendQueryService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendQueryService*(void) { return (Rest::Backend::Servicetypes::IBackendQueryService*)&__IBackendQueryService; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E8BD0783-0E4D-459F-9EEC-11B5F29FE792}
	operator Rest::Backend::Providers::_di_IBackendService()
	{
		Rest::Backend::Providers::_di_IBackendService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendService*(void) { return (Rest::Backend::Providers::IBackendService*)&__IBackendQueryService; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42UsersAPI;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42UsersAPI : public Rest::Backend::App42provider::TApp42ServiceAPIAuth
{
	typedef Rest::Backend::App42provider::TApp42ServiceAPIAuth inherited;
	
protected:
	Rest::Backend::Metatypes::_di_IBackendMetaFactory __fastcall GetMetaFactory(void);
	void __fastcall SignupUser(const System::UnicodeString AUserName, const System::UnicodeString APassword, System::Json::TJSONObject* const AUserData, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &ACreatedObject);
	void __fastcall LoginUser(const System::UnicodeString AUserName, const System::UnicodeString APassword, Rest::Backend::Servicetypes::_di_TFindObjectProc AProc)/* overload */;
	void __fastcall LoginUser(const System::UnicodeString AUserName, const System::UnicodeString APassword, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AUser, System::Json::TJSONArray* const AJSON)/* overload */;
	bool __fastcall DeleteUser(const Rest::Backend::Metatypes::TBackendEntityValue &AObject)/* overload */;
	bool __fastcall FindUser(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, Rest::Backend::Servicetypes::_di_TFindObjectProc AProc)/* overload */;
	bool __fastcall FindUser(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AUser, System::Json::TJSONArray* const AJSON)/* overload */;
	bool __fastcall FindCurrentUser(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, Rest::Backend::Servicetypes::_di_TFindObjectProc AProc)/* overload */;
	bool __fastcall FindCurrentUser(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AUser, System::Json::TJSONArray* const AJSON)/* overload */;
	void __fastcall UpdateUser(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, System::Json::TJSONObject* const AUserData, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AUpdatedObject);
	bool __fastcall QueryUserName(const System::UnicodeString AUserName, Rest::Backend::Servicetypes::_di_TFindObjectProc AProc)/* overload */;
	bool __fastcall QueryUserName(const System::UnicodeString AUserName, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AUser, System::Json::TJSONArray* const AJSON)/* overload */;
	void __fastcall QueryUsers(System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray)/* overload */;
	void __fastcall QueryUsers(System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, /* out */ System::DynamicArray<Rest::Backend::Metatypes::TBackendEntityValue> &AMetaArray)/* overload */;
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42UsersAPI(void) : Rest::Backend::App42provider::TApp42ServiceAPIAuth() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42UsersAPI(void) { }
	
private:
	void *__IBackendUsersApi;	// Rest::Backend::Servicetypes::IBackendUsersApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FD6D169C-07E8-4738-9B9A-BB50E5D423FC}
	operator Rest::Backend::Servicetypes::_di_IBackendUsersApi()
	{
		Rest::Backend::Servicetypes::_di_IBackendUsersApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendUsersApi*(void) { return (Rest::Backend::Servicetypes::IBackendUsersApi*)&__IBackendUsersApi; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42UsersService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42UsersService : public Rest::Backend::App42provider::TApp42BackendService__1<TApp42UsersAPI*> 
{
	typedef Rest::Backend::App42provider::TApp42BackendService__1<TApp42UsersAPI*>  inherited;
	
protected:
	Rest::Backend::Servicetypes::_di_IBackendUsersApi __fastcall CreateUsersApi(void);
	Rest::Backend::Servicetypes::_di_IBackendUsersApi __fastcall GetUsersApi(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42UsersService(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : Rest::Backend::App42provider::TApp42BackendService__1<TApp42UsersAPI*> (AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42UsersService(void) { }
	
private:
	void *__IBackendUsersService;	// Rest::Backend::Servicetypes::IBackendUsersService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B6A9B066-E6C0-4A01-B70B-5A5A19C816AF}
	operator Rest::Backend::Servicetypes::_di_IBackendUsersService()
	{
		Rest::Backend::Servicetypes::_di_IBackendUsersService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendUsersService*(void) { return (Rest::Backend::Servicetypes::IBackendUsersService*)&__IBackendUsersService; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E8BD0783-0E4D-459F-9EEC-11B5F29FE792}
	operator Rest::Backend::Providers::_di_IBackendService()
	{
		Rest::Backend::Providers::_di_IBackendService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendService*(void) { return (Rest::Backend::Providers::IBackendService*)&__IBackendUsersService; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42StorageAPI;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42StorageAPI : public Rest::Backend::App42provider::TApp42ServiceAPIAuth
{
	typedef Rest::Backend::App42provider::TApp42ServiceAPIAuth inherited;
	
protected:
	Rest::Backend::Metatypes::_di_IBackendMetaFactory __fastcall GetMetaFactory(void);
	void __fastcall CreateObject(const Rest::Backend::Metatypes::TBackendClassValue &AClass, System::Json::TJSONObject* const AACL, System::Json::TJSONObject* const AJSON, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &ACreatedObject)/* overload */;
	bool __fastcall DeleteObject(const Rest::Backend::Metatypes::TBackendEntityValue &AObject);
	bool __fastcall FindObject(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, Rest::Backend::Servicetypes::_di_TFindObjectProc AProc);
	void __fastcall UpdateObject(const Rest::Backend::Metatypes::TBackendEntityValue &AObject, System::Json::TJSONObject* const AJSONObject, /* out */ Rest::Backend::Metatypes::TBackendEntityValue &AUpdatedObject);
	void __fastcall QueryObjects(const Rest::Backend::Metatypes::TBackendClassValue &AClass, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray)/* overload */;
	void __fastcall QueryObjects(const Rest::Backend::Metatypes::TBackendClassValue &AClass, System::UnicodeString const *AQuery, const int AQuery_High, System::Json::TJSONArray* const AJSONArray, /* out */ System::DynamicArray<Rest::Backend::Metatypes::TBackendEntityValue> &AObjects)/* overload */;
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42StorageAPI(void) : Rest::Backend::App42provider::TApp42ServiceAPIAuth() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42StorageAPI(void) { }
	
private:
	void *__IBackendStorageApi;	// Rest::Backend::Servicetypes::IBackendStorageApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F4CBE0D9-5AAD-49EE-9D2E-3178E5DF2425}
	operator Rest::Backend::Servicetypes::_di_IBackendStorageApi()
	{
		Rest::Backend::Servicetypes::_di_IBackendStorageApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendStorageApi*(void) { return (Rest::Backend::Servicetypes::IBackendStorageApi*)&__IBackendStorageApi; }
	#endif
	
};

#pragma pack(pop)

class DELPHICLASS TApp42StorageService;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TApp42StorageService : public Rest::Backend::App42provider::TApp42BackendService__1<TApp42StorageAPI*> 
{
	typedef Rest::Backend::App42provider::TApp42BackendService__1<TApp42StorageAPI*>  inherited;
	
protected:
	Rest::Backend::Servicetypes::_di_IBackendStorageApi __fastcall CreateStorageApi(void);
	Rest::Backend::Servicetypes::_di_IBackendStorageApi __fastcall GetStorageApi(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42StorageService(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : Rest::Backend::App42provider::TApp42BackendService__1<TApp42StorageAPI*> (AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42StorageService(void) { }
	
private:
	void *__IBackendStorageService;	// Rest::Backend::Servicetypes::IBackendStorageService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0B60B443-8D7F-4984-8DEA-B7057AD9ED7F}
	operator Rest::Backend::Servicetypes::_di_IBackendStorageService()
	{
		Rest::Backend::Servicetypes::_di_IBackendStorageService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Servicetypes::IBackendStorageService*(void) { return (Rest::Backend::Servicetypes::IBackendStorageService*)&__IBackendStorageService; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {E8BD0783-0E4D-459F-9EEC-11B5F29FE792}
	operator Rest::Backend::Providers::_di_IBackendService()
	{
		Rest::Backend::Providers::_di_IBackendService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Providers::IBackendService*(void) { return (Rest::Backend::Providers::IBackendService*)&__IBackendStorageService; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace App42services */
}	/* namespace Backend */
}	/* namespace Rest */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST_BACKEND_APP42SERVICES)
using namespace Rest::Backend::App42services;
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
#endif	// Rest_Backend_App42servicesHPP
