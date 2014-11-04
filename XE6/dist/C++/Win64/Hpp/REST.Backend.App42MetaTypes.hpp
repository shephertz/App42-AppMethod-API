// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'REST.Backend.App42MetaTypes.pas' rev: 27.00 (Windows)

#ifndef Rest_Backend_App42metatypesHPP
#define Rest_Backend_App42metatypesHPP

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
#include <REST.Backend.MetaTypes.hpp>	// Pascal unit
#include <REST.Backend.App42Provider.hpp>	// Pascal unit
#include <REST.Backend.App42Api.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rest
{
namespace Backend
{
namespace App42metatypes
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMetaObject;
class PASCALIMPLEMENTATION TMetaObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Rest::Backend::App42api::TApp42Api::TObjectID FObjectID;
	
protected:
	System::UnicodeString __fastcall GetObjectID(void);
	System::TDateTime __fastcall GetCreatedAt(void);
	System::TDateTime __fastcall GetUpdatedAt(void);
	System::UnicodeString __fastcall GetClassName(void);
	
public:
	__fastcall TMetaObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID);
	__property Rest::Backend::App42api::TApp42Api::TObjectID ObjectID = {read=FObjectID};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaObject(void) { }
	
private:
	void *__IBackendMetaObject;	// Rest::Backend::Metatypes::IBackendMetaObject 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendMetaObject; }
	#endif
	
};


class DELPHICLASS TMetaCreatedObject;
class PASCALIMPLEMENTATION TMetaCreatedObject : public TMetaObject
{
	typedef TMetaObject inherited;
	
public:
	/* TMetaObject.Create */ inline __fastcall TMetaCreatedObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID) : TMetaObject(AObjectID) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaCreatedObject(void) { }
	
private:
	void *__IBackendCreatedAt;	// Rest::Backend::Metatypes::IBackendCreatedAt 
	void *__IBackendClassName;	// Rest::Backend::Metatypes::IBackendClassName 
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C3204A92-434F-4008-B356-E41896BC22CA}
	operator Rest::Backend::Metatypes::_di_IBackendCreatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendCreatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendCreatedAt*(void) { return (Rest::Backend::Metatypes::IBackendCreatedAt*)&__IBackendCreatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A73AB14F-12C8-4121-AFB1-2E0C55F37BB6}
	operator Rest::Backend::Metatypes::_di_IBackendClassName()
	{
		Rest::Backend::Metatypes::_di_IBackendClassName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendClassName*(void) { return (Rest::Backend::Metatypes::IBackendClassName*)&__IBackendClassName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendCreatedAt; }
	#endif
	
};


class DELPHICLASS TMetaClassObject;
class PASCALIMPLEMENTATION TMetaClassObject : public TMetaObject
{
	typedef TMetaObject inherited;
	
public:
	/* TMetaObject.Create */ inline __fastcall TMetaClassObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID) : TMetaObject(AObjectID) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaClassObject(void) { }
	
private:
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	void *__IBackendClassName;	// Rest::Backend::Metatypes::IBackendClassName 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A73AB14F-12C8-4121-AFB1-2E0C55F37BB6}
	operator Rest::Backend::Metatypes::_di_IBackendClassName()
	{
		Rest::Backend::Metatypes::_di_IBackendClassName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendClassName*(void) { return (Rest::Backend::Metatypes::IBackendClassName*)&__IBackendClassName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendObjectID; }
	#endif
	
};


class DELPHICLASS TMetaUpdatedObject;
class PASCALIMPLEMENTATION TMetaUpdatedObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Rest::Backend::App42api::TApp42Api::TUpdatedAt FUpdatedAt;
	
protected:
	System::UnicodeString __fastcall GetObjectID(void);
	System::TDateTime __fastcall GetUpdatedAt(void);
	System::UnicodeString __fastcall GetClassName(void);
	
public:
	__fastcall TMetaUpdatedObject(const Rest::Backend::App42api::TApp42Api::TUpdatedAt &AUpdatedAt);
	__property Rest::Backend::App42api::TApp42Api::TUpdatedAt ObjectID = {read=FUpdatedAt};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaUpdatedObject(void) { }
	
private:
	void *__IBackendMetaObject;	// Rest::Backend::Metatypes::IBackendMetaObject 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendMetaObject; }
	#endif
	
};


class DELPHICLASS TMetaUser;
class PASCALIMPLEMENTATION TMetaUser : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Rest::Backend::App42api::TApp42Api::TUser FUser;
	
protected:
	System::UnicodeString __fastcall GetObjectID(void);
	System::TDateTime __fastcall GetCreatedAt(void);
	System::TDateTime __fastcall GetUpdatedAt(void);
	System::UnicodeString __fastcall GetUserName(void);
	
public:
	__fastcall TMetaUser(const Rest::Backend::App42api::TApp42Api::TUser &AUser);
	__property Rest::Backend::App42api::TApp42Api::TUser User = {read=FUser};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaUser(void) { }
	
private:
	void *__IBackendMetaObject;	// Rest::Backend::Metatypes::IBackendMetaObject 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendMetaObject; }
	#endif
	
};


class DELPHICLASS TMetaFile;
class PASCALIMPLEMENTATION TMetaFile : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Rest::Backend::App42api::TApp42Api::TFile FFile;
	
protected:
	System::UnicodeString __fastcall GetDownloadURL(void);
	System::UnicodeString __fastcall GetFileName(void);
	System::UnicodeString __fastcall GetFileID(void);
	
public:
	__fastcall TMetaFile(const Rest::Backend::App42api::TApp42Api::TFile &AFile)/* overload */;
	__fastcall TMetaFile(const System::UnicodeString AFileID)/* overload */;
	__property Rest::Backend::App42api::TApp42Api::TFile FileValue = {read=FFile};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaFile(void) { }
	
private:
	void *__IBackendMetaObject;	// Rest::Backend::Metatypes::IBackendMetaObject 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendMetaObject; }
	#endif
	
};


class DELPHICLASS TMetaUserObject;
class PASCALIMPLEMENTATION TMetaUserObject : public TMetaUser
{
	typedef TMetaUser inherited;
	
public:
	/* TMetaUser.Create */ inline __fastcall TMetaUserObject(const Rest::Backend::App42api::TApp42Api::TUser &AUser) : TMetaUser(AUser) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaUserObject(void) { }
	
private:
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendObjectID; }
	#endif
	
};


class DELPHICLASS TMetaLogin;
class PASCALIMPLEMENTATION TMetaLogin : public TMetaUser
{
	typedef TMetaUser inherited;
	
private:
	Rest::Backend::App42api::TApp42Api::TLogin FLogin;
	
protected:
	System::UnicodeString __fastcall GetAuthTOken(void);
	
public:
	__fastcall TMetaLogin(const Rest::Backend::App42api::TApp42Api::TLogin &ALogin);
	__property Rest::Backend::App42api::TApp42Api::TLogin Login = {read=FLogin};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaLogin(void) { }
	
};


class DELPHICLASS TMetaFoundObject;
class PASCALIMPLEMENTATION TMetaFoundObject : public TMetaObject
{
	typedef TMetaObject inherited;
	
public:
	/* TMetaObject.Create */ inline __fastcall TMetaFoundObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID) : TMetaObject(AObjectID) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaFoundObject(void) { }
	
private:
	void *__IBackendUpdatedAt;	// Rest::Backend::Metatypes::IBackendUpdatedAt 
	void *__IBackendCreatedAt;	// Rest::Backend::Metatypes::IBackendCreatedAt 
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	void *__IBackendClassName;	// Rest::Backend::Metatypes::IBackendClassName 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {16630E95-EE80-4328-8323-6F7FF67C0141}
	operator Rest::Backend::Metatypes::_di_IBackendUpdatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendUpdatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUpdatedAt*(void) { return (Rest::Backend::Metatypes::IBackendUpdatedAt*)&__IBackendUpdatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C3204A92-434F-4008-B356-E41896BC22CA}
	operator Rest::Backend::Metatypes::_di_IBackendCreatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendCreatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendCreatedAt*(void) { return (Rest::Backend::Metatypes::IBackendCreatedAt*)&__IBackendCreatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A73AB14F-12C8-4121-AFB1-2E0C55F37BB6}
	operator Rest::Backend::Metatypes::_di_IBackendClassName()
	{
		Rest::Backend::Metatypes::_di_IBackendClassName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendClassName*(void) { return (Rest::Backend::Metatypes::IBackendClassName*)&__IBackendClassName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendUpdatedAt; }
	#endif
	
};


class DELPHICLASS TMetaUploadedFile;
class PASCALIMPLEMENTATION TMetaUploadedFile : public TMetaFile
{
	typedef TMetaFile inherited;
	
public:
	/* TMetaFile.Create */ inline __fastcall TMetaUploadedFile(const Rest::Backend::App42api::TApp42Api::TFile &AFile)/* overload */ : TMetaFile(AFile) { }
	/* TMetaFile.Create */ inline __fastcall TMetaUploadedFile(const System::UnicodeString AFileID)/* overload */ : TMetaFile(AFileID) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaUploadedFile(void) { }
	
private:
	void *__IBackendDownloadURL;	// Rest::Backend::Metatypes::IBackendDownloadURL 
	void *__IBackendFileName;	// Rest::Backend::Metatypes::IBackendFileName 
	void *__IBackendFileID;	// Rest::Backend::Metatypes::IBackendFileID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0403AF5D-AF5D-4463-97DD-2903DE03EBFD}
	operator Rest::Backend::Metatypes::_di_IBackendDownloadURL()
	{
		Rest::Backend::Metatypes::_di_IBackendDownloadURL intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendDownloadURL*(void) { return (Rest::Backend::Metatypes::IBackendDownloadURL*)&__IBackendDownloadURL; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {59E96B63-92B9-4A1D-991E-1487FF26B0A3}
	operator Rest::Backend::Metatypes::_di_IBackendFileName()
	{
		Rest::Backend::Metatypes::_di_IBackendFileName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendFileName*(void) { return (Rest::Backend::Metatypes::IBackendFileName*)&__IBackendFileName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B58DA141-82E8-4BD6-920D-9C9E680BEC03}
	operator Rest::Backend::Metatypes::_di_IBackendFileID()
	{
		Rest::Backend::Metatypes::_di_IBackendFileID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendFileID*(void) { return (Rest::Backend::Metatypes::IBackendFileID*)&__IBackendFileID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendDownloadURL; }
	#endif
	
};


class DELPHICLASS TMetaFileObject;
class PASCALIMPLEMENTATION TMetaFileObject : public TMetaFile
{
	typedef TMetaFile inherited;
	
public:
	/* TMetaFile.Create */ inline __fastcall TMetaFileObject(const Rest::Backend::App42api::TApp42Api::TFile &AFile)/* overload */ : TMetaFile(AFile) { }
	/* TMetaFile.Create */ inline __fastcall TMetaFileObject(const System::UnicodeString AFileID)/* overload */ : TMetaFile(AFileID) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaFileObject(void) { }
	
private:
	void *__IBackendFileID;	// Rest::Backend::Metatypes::IBackendFileID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B58DA141-82E8-4BD6-920D-9C9E680BEC03}
	operator Rest::Backend::Metatypes::_di_IBackendFileID()
	{
		Rest::Backend::Metatypes::_di_IBackendFileID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendFileID*(void) { return (Rest::Backend::Metatypes::IBackendFileID*)&__IBackendFileID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendFileID; }
	#endif
	
};


class DELPHICLASS TMetaUpdatedUser;
class PASCALIMPLEMENTATION TMetaUpdatedUser : public TMetaUser
{
	typedef TMetaUser inherited;
	
public:
	/* TMetaUser.Create */ inline __fastcall TMetaUpdatedUser(const Rest::Backend::App42api::TApp42Api::TUser &AUser) : TMetaUser(AUser) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaUpdatedUser(void) { }
	
private:
	void *__IBackendUserName;	// Rest::Backend::Metatypes::IBackendUserName 
	void *__IBackendUpdatedAt;	// Rest::Backend::Metatypes::IBackendUpdatedAt 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B7022538-2C7D-4F93-A1C8-A7A96545E4BF}
	operator Rest::Backend::Metatypes::_di_IBackendUserName()
	{
		Rest::Backend::Metatypes::_di_IBackendUserName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUserName*(void) { return (Rest::Backend::Metatypes::IBackendUserName*)&__IBackendUserName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {16630E95-EE80-4328-8323-6F7FF67C0141}
	operator Rest::Backend::Metatypes::_di_IBackendUpdatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendUpdatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUpdatedAt*(void) { return (Rest::Backend::Metatypes::IBackendUpdatedAt*)&__IBackendUpdatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendUserName; }
	#endif
	
};


class DELPHICLASS TMetaFoundUser;
class PASCALIMPLEMENTATION TMetaFoundUser : public TMetaUser
{
	typedef TMetaUser inherited;
	
public:
	/* TMetaUser.Create */ inline __fastcall TMetaFoundUser(const Rest::Backend::App42api::TApp42Api::TUser &AUser) : TMetaUser(AUser) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaFoundUser(void) { }
	
private:
	void *__IBackendUserName;	// Rest::Backend::Metatypes::IBackendUserName 
	void *__IBackendUpdatedAt;	// Rest::Backend::Metatypes::IBackendUpdatedAt 
	void *__IBackendCreatedAt;	// Rest::Backend::Metatypes::IBackendCreatedAt 
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B7022538-2C7D-4F93-A1C8-A7A96545E4BF}
	operator Rest::Backend::Metatypes::_di_IBackendUserName()
	{
		Rest::Backend::Metatypes::_di_IBackendUserName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUserName*(void) { return (Rest::Backend::Metatypes::IBackendUserName*)&__IBackendUserName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {16630E95-EE80-4328-8323-6F7FF67C0141}
	operator Rest::Backend::Metatypes::_di_IBackendUpdatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendUpdatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUpdatedAt*(void) { return (Rest::Backend::Metatypes::IBackendUpdatedAt*)&__IBackendUpdatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C3204A92-434F-4008-B356-E41896BC22CA}
	operator Rest::Backend::Metatypes::_di_IBackendCreatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendCreatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendCreatedAt*(void) { return (Rest::Backend::Metatypes::IBackendCreatedAt*)&__IBackendCreatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendUserName; }
	#endif
	
};


class DELPHICLASS TMetaLoginUser;
class PASCALIMPLEMENTATION TMetaLoginUser : public TMetaLogin
{
	typedef TMetaLogin inherited;
	
public:
	/* TMetaLogin.Create */ inline __fastcall TMetaLoginUser(const Rest::Backend::App42api::TApp42Api::TLogin &ALogin) : TMetaLogin(ALogin) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaLoginUser(void) { }
	
private:
	void *__IBackendAuthToken;	// Rest::Backend::Metatypes::IBackendAuthToken 
	void *__IBackendUserName;	// Rest::Backend::Metatypes::IBackendUserName 
	void *__IBackendUpdatedAt;	// Rest::Backend::Metatypes::IBackendUpdatedAt 
	void *__IBackendCreatedAt;	// Rest::Backend::Metatypes::IBackendCreatedAt 
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {3C4FF6D8-11CA-48D8-8967-B3F1FC06C3EA}
	operator Rest::Backend::Metatypes::_di_IBackendAuthToken()
	{
		Rest::Backend::Metatypes::_di_IBackendAuthToken intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendAuthToken*(void) { return (Rest::Backend::Metatypes::IBackendAuthToken*)&__IBackendAuthToken; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B7022538-2C7D-4F93-A1C8-A7A96545E4BF}
	operator Rest::Backend::Metatypes::_di_IBackendUserName()
	{
		Rest::Backend::Metatypes::_di_IBackendUserName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUserName*(void) { return (Rest::Backend::Metatypes::IBackendUserName*)&__IBackendUserName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {16630E95-EE80-4328-8323-6F7FF67C0141}
	operator Rest::Backend::Metatypes::_di_IBackendUpdatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendUpdatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUpdatedAt*(void) { return (Rest::Backend::Metatypes::IBackendUpdatedAt*)&__IBackendUpdatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C3204A92-434F-4008-B356-E41896BC22CA}
	operator Rest::Backend::Metatypes::_di_IBackendCreatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendCreatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendCreatedAt*(void) { return (Rest::Backend::Metatypes::IBackendCreatedAt*)&__IBackendCreatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendAuthToken; }
	#endif
	
};


class DELPHICLASS TMetaSignupUser;
class PASCALIMPLEMENTATION TMetaSignupUser : public TMetaLogin
{
	typedef TMetaLogin inherited;
	
public:
	/* TMetaLogin.Create */ inline __fastcall TMetaSignupUser(const Rest::Backend::App42api::TApp42Api::TLogin &ALogin) : TMetaLogin(ALogin) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaSignupUser(void) { }
	
private:
	void *__IBackendAuthToken;	// Rest::Backend::Metatypes::IBackendAuthToken 
	void *__IBackendUserName;	// Rest::Backend::Metatypes::IBackendUserName 
	void *__IBackendCreatedAt;	// Rest::Backend::Metatypes::IBackendCreatedAt 
	void *__IBackendObjectID;	// Rest::Backend::Metatypes::IBackendObjectID 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {3C4FF6D8-11CA-48D8-8967-B3F1FC06C3EA}
	operator Rest::Backend::Metatypes::_di_IBackendAuthToken()
	{
		Rest::Backend::Metatypes::_di_IBackendAuthToken intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendAuthToken*(void) { return (Rest::Backend::Metatypes::IBackendAuthToken*)&__IBackendAuthToken; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B7022538-2C7D-4F93-A1C8-A7A96545E4BF}
	operator Rest::Backend::Metatypes::_di_IBackendUserName()
	{
		Rest::Backend::Metatypes::_di_IBackendUserName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendUserName*(void) { return (Rest::Backend::Metatypes::IBackendUserName*)&__IBackendUserName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {C3204A92-434F-4008-B356-E41896BC22CA}
	operator Rest::Backend::Metatypes::_di_IBackendCreatedAt()
	{
		Rest::Backend::Metatypes::_di_IBackendCreatedAt intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendCreatedAt*(void) { return (Rest::Backend::Metatypes::IBackendCreatedAt*)&__IBackendCreatedAt; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CD893599-279D-4000-B7E2-F94B944D6C63}
	operator Rest::Backend::Metatypes::_di_IBackendObjectID()
	{
		Rest::Backend::Metatypes::_di_IBackendObjectID intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendObjectID*(void) { return (Rest::Backend::Metatypes::IBackendObjectID*)&__IBackendObjectID; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendAuthToken; }
	#endif
	
};


class DELPHICLASS TMetaClass;
class PASCALIMPLEMENTATION TMetaClass : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::UnicodeString FClassName;
	System::UnicodeString FDataType;
	
protected:
	System::UnicodeString __fastcall GetClassName(void);
	System::UnicodeString __fastcall GetDataType(void);
	
public:
	__fastcall TMetaClass(const System::UnicodeString AClassName)/* overload */;
	__fastcall TMetaClass(const System::UnicodeString ADataType, const System::UnicodeString AClassName)/* overload */;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaClass(void) { }
	
private:
	void *__IBackendMetaObject;	// Rest::Backend::Metatypes::IBackendMetaObject 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {95F29709-C995-4E69-A16E-3E9FA6D81ED6}
	operator Rest::Backend::Metatypes::_di_IBackendMetaObject()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaObject*(void) { return (Rest::Backend::Metatypes::IBackendMetaObject*)&__IBackendMetaObject; }
	#endif
	
};


class DELPHICLASS TMetaClassName;
class PASCALIMPLEMENTATION TMetaClassName : public TMetaClass
{
	typedef TMetaClass inherited;
	
public:
	/* TMetaClass.Create */ inline __fastcall TMetaClassName(const System::UnicodeString AClassName)/* overload */ : TMetaClass(AClassName) { }
	/* TMetaClass.Create */ inline __fastcall TMetaClassName(const System::UnicodeString ADataType, const System::UnicodeString AClassName)/* overload */ : TMetaClass(ADataType, AClassName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaClassName(void) { }
	
private:
	void *__IBackendClassName;	// Rest::Backend::Metatypes::IBackendClassName 
	void *__IBackendMetaClass;	// Rest::Backend::Metatypes::IBackendMetaClass 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A73AB14F-12C8-4121-AFB1-2E0C55F37BB6}
	operator Rest::Backend::Metatypes::_di_IBackendClassName()
	{
		Rest::Backend::Metatypes::_di_IBackendClassName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendClassName*(void) { return (Rest::Backend::Metatypes::IBackendClassName*)&__IBackendClassName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F80536B3-4F7F-4C52-9F53-A81CF608299C}
	operator Rest::Backend::Metatypes::_di_IBackendMetaClass()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaClass intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaClass*(void) { return (Rest::Backend::Metatypes::IBackendMetaClass*)&__IBackendMetaClass; }
	#endif
	
};


class DELPHICLASS TMetaDataType;
class PASCALIMPLEMENTATION TMetaDataType : public TMetaClass
{
	typedef TMetaClass inherited;
	
public:
	/* TMetaClass.Create */ inline __fastcall TMetaDataType(const System::UnicodeString AClassName)/* overload */ : TMetaClass(AClassName) { }
	/* TMetaClass.Create */ inline __fastcall TMetaDataType(const System::UnicodeString ADataType, const System::UnicodeString AClassName)/* overload */ : TMetaClass(ADataType, AClassName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaDataType(void) { }
	
private:
	void *__IBackendDataType;	// Rest::Backend::Metatypes::IBackendDataType 
	void *__IBackendClassName;	// Rest::Backend::Metatypes::IBackendClassName 
	void *__IBackendMetaClass;	// Rest::Backend::Metatypes::IBackendMetaClass 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {8E75565A-3A1B-44E0-B150-B74927F50F97}
	operator Rest::Backend::Metatypes::_di_IBackendDataType()
	{
		Rest::Backend::Metatypes::_di_IBackendDataType intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendDataType*(void) { return (Rest::Backend::Metatypes::IBackendDataType*)&__IBackendDataType; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {A73AB14F-12C8-4121-AFB1-2E0C55F37BB6}
	operator Rest::Backend::Metatypes::_di_IBackendClassName()
	{
		Rest::Backend::Metatypes::_di_IBackendClassName intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendClassName*(void) { return (Rest::Backend::Metatypes::IBackendClassName*)&__IBackendClassName; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {F80536B3-4F7F-4C52-9F53-A81CF608299C}
	operator Rest::Backend::Metatypes::_di_IBackendMetaClass()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaClass intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaClass*(void) { return (Rest::Backend::Metatypes::IBackendMetaClass*)&__IBackendMetaClass; }
	#endif
	
};


class DELPHICLASS TMetaFactory;
class PASCALIMPLEMENTATION TMetaFactory : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
protected:
	Rest::Backend::Metatypes::TBackendClassValue __fastcall CreateMetaClass(const System::UnicodeString AClassName);
	Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaClassObject(const System::UnicodeString AClassName, const System::UnicodeString AObjectID);
	Rest::Backend::Metatypes::TBackendClassValue __fastcall CreateMetaDataType(const System::UnicodeString ADataType, const System::UnicodeString ABackendClassName);
	Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaFileObject(const System::UnicodeString AFileID);
public:
	/* TObject.Create */ inline __fastcall TMetaFactory(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMetaFactory(void) { }
	
private:
	void *__IBackendMetaFileFactory;	// Rest::Backend::Metatypes::IBackendMetaFileFactory 
	void *__IBackendMetaDataTypeFactory;	// Rest::Backend::Metatypes::IBackendMetaDataTypeFactory 
	void *__IBackendMetaClassObjectFactory;	// Rest::Backend::Metatypes::IBackendMetaClassObjectFactory 
	void *__IBackendMetaClassFactory;	// Rest::Backend::Metatypes::IBackendMetaClassFactory 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {96C22B76-C711-4D7C-90C8-AEA565F622D5}
	operator Rest::Backend::Metatypes::_di_IBackendMetaFileFactory()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaFileFactory intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaFileFactory*(void) { return (Rest::Backend::Metatypes::IBackendMetaFileFactory*)&__IBackendMetaFileFactory; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {7FDED929-4F6D-4C41-8AF9-8AE20BFB2EF9}
	operator Rest::Backend::Metatypes::_di_IBackendMetaDataTypeFactory()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaDataTypeFactory intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaDataTypeFactory*(void) { return (Rest::Backend::Metatypes::IBackendMetaDataTypeFactory*)&__IBackendMetaDataTypeFactory; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {80E7B794-6088-4A85-A5A2-49ADA2112629}
	operator Rest::Backend::Metatypes::_di_IBackendMetaClassObjectFactory()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaClassObjectFactory intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaClassObjectFactory*(void) { return (Rest::Backend::Metatypes::IBackendMetaClassObjectFactory*)&__IBackendMetaClassObjectFactory; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B27A40E6-5084-4093-BED3-A329DCC65E92}
	operator Rest::Backend::Metatypes::_di_IBackendMetaClassFactory()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaClassFactory intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaClassFactory*(void) { return (Rest::Backend::Metatypes::IBackendMetaClassFactory*)&__IBackendMetaClassFactory; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B58EC9B1-060C-4B44-82E9-82F576AB3793}
	operator Rest::Backend::Metatypes::_di_IBackendMetaFactory()
	{
		Rest::Backend::Metatypes::_di_IBackendMetaFactory intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator Rest::Backend::Metatypes::IBackendMetaFactory*(void) { return (Rest::Backend::Metatypes::IBackendMetaFactory*)&__IBackendMetaFileFactory; }
	#endif
	
};


class DELPHICLASS TApp42MetaFactory;
class PASCALIMPLEMENTATION TApp42MetaFactory : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	static Rest::Backend::Metatypes::TBackendClassValue __fastcall CreateMetaClass(const System::UnicodeString AClassName);
	static Rest::Backend::Metatypes::TBackendClassValue __fastcall CreateMetaDataType(const System::UnicodeString ADataType, const System::UnicodeString AClassName)/* overload */;
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaClassObject(const System::UnicodeString AClassName, const System::UnicodeString AObjectID)/* overload */;
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaClassObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID)/* overload */;
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaCreatedObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID);
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaFoundObject(const Rest::Backend::App42api::TApp42Api::TObjectID &AObjectID);
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaUpdatedObject(const Rest::Backend::App42api::TApp42Api::TUpdatedAt &AUpdatedAt);
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaUpdatedUser(const Rest::Backend::App42api::TApp42Api::TUpdatedAt &AUpdatedAt)/* overload */;
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaSignupUser(const Rest::Backend::App42api::TApp42Api::TLogin &ALogin)/* overload */;
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaLoginUser(const Rest::Backend::App42api::TApp42Api::TLogin &ALogin)/* overload */;
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaFoundUser(const Rest::Backend::App42api::TApp42Api::TUser &AUser);
	static Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaUploadedFile(const Rest::Backend::App42api::TApp42Api::TFile &AFile);
	__classmethod Rest::Backend::Metatypes::TBackendEntityValue __fastcall CreateMetaFileObject(const System::UnicodeString AFileID);
public:
	/* TObject.Create */ inline __fastcall TApp42MetaFactory(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TApp42MetaFactory(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace App42metatypes */
}	/* namespace Backend */
}	/* namespace Rest */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_REST_BACKEND_APP42METATYPES)
using namespace Rest::Backend::App42metatypes;
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
#endif	// Rest_Backend_App42metatypesHPP
