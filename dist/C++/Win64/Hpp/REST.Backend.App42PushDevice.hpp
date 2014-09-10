// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'REST.Backend.App42PushDevice.pas' rev: 28.00 (Windows)

#ifndef Rest_Backend_App42pushdeviceHPP
#define Rest_Backend_App42pushdeviceHPP

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
#include <System.PushNotification.hpp>	// Pascal unit
#include <REST.Backend.Providers.hpp>	// Pascal unit
#include <REST.Backend.PushTypes.hpp>	// Pascal unit
#include <REST.Backend.App42Provider.hpp>	// Pascal unit
#include <REST.Backend.App42Api.hpp>	// Pascal unit
#include <REST.Backend.Exception.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
#pragma link "REST.Backend.App42PushDevice"

namespace Rest
{
namespace Backend
{
namespace App42pushdevice
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TApp42PushDeviceAPI;
class PASCALIMPLEMENTATION TApp42PushDeviceAPI : public Rest::Backend::App42provider::TApp42ServiceAPIAuth
{
	typedef Rest::Backend::App42provider::TApp42ServiceAPIAuth inherited;
	
private:
	#define TApp42PushDeviceAPI_sApp42 L"App42"
	
	System::UnicodeString FGCMAppID;
	
protected:
	System::Pushnotification::TPushService* __fastcall GetPushService(void);
	bool __fastcall HasPushService(void);
	void __fastcall RegisterDevice(Rest::Backend::Pushtypes::TDeviceRegisteredAtProviderEvent AOnRegistered);
	void __fastcall UnregisterDevice(void);
public:
	/* TApp42ServiceAPI.Create */ inline __fastcall TApp42PushDeviceAPI(void) : Rest::Backend::App42provider::TApp42ServiceAPIAuth() { }
	/* TApp42ServiceAPI.Destroy */ inline __fastcall virtual ~TApp42PushDeviceAPI(void) { }
	
private:
	void *__IBackendPushDeviceApi;	// Rest::Backend::Pushtypes::IBackendPushDeviceApi 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {2F1A3600-8C92-4C74-9D20-E800FD275482}
	operator Rest::Backend::Pushtypes::_di_IBackendPushDeviceApi()
	{
		Rest::Backend::Pushtypes::_di_IBackendPushDeviceApi intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Pushtypes::IBackendPushDeviceApi*(void) { return (Rest::Backend::Pushtypes::IBackendPushDeviceApi*)&__IBackendPushDeviceApi; }
	#endif
	
};


class DELPHICLASS TApp42PushDeviceService;
class PASCALIMPLEMENTATION TApp42PushDeviceService : public Rest::Backend::App42provider::TApp42BackendService__1<TApp42PushDeviceAPI*>
{
	typedef Rest::Backend::App42provider::TApp42BackendService__1<TApp42PushDeviceAPI*> inherited;
	
protected:
	virtual TApp42PushDeviceAPI* __fastcall CreateBackendApi(void);
	Rest::Backend::Pushtypes::_di_IBackendPushDeviceApi __fastcall CreatePushDeviceApi(void);
	Rest::Backend::Pushtypes::_di_IBackendPushDeviceApi __fastcall GetPushDeviceApi(void);
public:
	/* TApp42BackendService.Create */ inline __fastcall virtual TApp42PushDeviceService(const Rest::Backend::Providers::_di_IBackendProvider AProvider) : Rest::Backend::App42provider::TApp42BackendService__1<TApp42PushDeviceAPI*>(AProvider) { }
	/* TApp42BackendService.Destroy */ inline __fastcall virtual ~TApp42PushDeviceService(void) { }
	
private:
	void *__IBackendPushDeviceService;	// Rest::Backend::Pushtypes::IBackendPushDeviceService 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {1810D21D-BF97-4DF0-B39A-DECA2A8A6F07}
	operator Rest::Backend::Pushtypes::_di_IBackendPushDeviceService()
	{
		Rest::Backend::Pushtypes::_di_IBackendPushDeviceService intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Pushtypes::IBackendPushDeviceService*(void) { return (Rest::Backend::Pushtypes::IBackendPushDeviceService*)&__IBackendPushDeviceService; }
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
	operator Rest::Backend::Providers::IBackendService*(void) { return (Rest::Backend::Providers::IBackendService*)&__IBackendPushDeviceService; }
	#endif
	
};


class DELPHICLASS EApp42PushNotificationError;
class PASCALIMPLEMENTATION EApp42PushNotificationError : public Rest::Backend::Exception::EBackendServiceError
{
	typedef Rest::Backend::Exception::EBackendServiceError inherited;
	
public:
	/* Exception.Create */ inline __fastcall EApp42PushNotificationError(const System::UnicodeString Msg) : Rest::Backend::Exception::EBackendServiceError(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EApp42PushNotificationError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High) : Rest::Backend::Exception::EBackendServiceError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EApp42PushNotificationError(NativeUInt Ident)/* overload */ : Rest::Backend::Exception::EBackendServiceError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EApp42PushNotificationError(System::PResStringRec ResStringRec)/* overload */ : Rest::Backend::Exception::EBackendServiceError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EApp42PushNotificationError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High)/* overload */ : Rest::Backend::Exception::EBackendServiceError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EApp42PushNotificationError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High)/* overload */ : Rest::Backend::Exception::EBackendServiceError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EApp42PushNotificationError(const System::UnicodeString Msg, int AHelpContext) : Rest::Backend::Exception::EBackendServiceError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EApp42PushNotificationError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High, int AHelpContext) : Rest::Backend::Exception::EBackendServiceError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EApp42PushNotificationError(NativeUInt Ident, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendServiceError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EApp42PushNotificationError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendServiceError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EApp42PushNotificationError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendServiceError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EApp42PushNotificationError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : Rest::Backend::Exception::EBackendServiceError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EApp42PushNotificationError(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace App42pushdevice */
}	/* namespace Backend */
}	/* namespace Rest */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST_BACKEND_APP42PUSHDEVICE)
using namespace Rest::Backend::App42pushdevice;
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
#endif	// Rest_Backend_App42pushdeviceHPP
