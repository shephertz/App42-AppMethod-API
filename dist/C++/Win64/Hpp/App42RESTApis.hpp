// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'App42RESTApis.dpk' rev: 28.00 (Windows)

#ifndef App42restapisHPP
#define App42restapisHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <REST.Backend.App42Api.hpp>	// Pascal unit
#include <REST.Backend.App42MetaTypes.hpp>	// Pascal unit
#include <REST.Backend.App42Provider.hpp>	// Pascal unit
#include <REST.Backend.App42PushDevice.hpp>	// Pascal unit
#include <REST.Backend.App42Services.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysConst.hpp>	// Pascal unit
#include <Winapi.ImageHlp.hpp>	// Pascal unit
#include <Winapi.SHFolder.hpp>	// Pascal unit
#include <Winapi.PsAPI.hpp>	// Pascal unit
#include <System.RTLConsts.hpp>	// Pascal unit
#include <System.Character.hpp>	// Pascal unit
#include <System.Internal.ExcUtils.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.VarUtils.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <Winapi.ActiveX.hpp>	// Pascal unit
#include <System.StrUtils.hpp>	// Pascal unit
#include <System.AnsiStrings.hpp>	// Pascal unit
#include <System.Math.hpp>	// Pascal unit
#include <System.Generics.Defaults.hpp>	// Pascal unit
#include <System.Generics.Collections.hpp>	// Pascal unit
#include <System.Rtti.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.TimeSpan.hpp>	// Pascal unit
#include <System.DateUtils.hpp>	// Pascal unit
#include <System.JSONConsts.hpp>	// Pascal unit
#include <System.JSON.hpp>	// Pascal unit
#include <System.Bindings.Consts.hpp>	// Pascal unit
#include <System.Bindings.EvalProtocol.hpp>	// Pascal unit
#include <System.Diagnostics.hpp>	// Pascal unit
#include <System.SyncObjs.hpp>	// Pascal unit
#include <System.Bindings.Search.hpp>	// Pascal unit
#include <System.Bindings.Evaluator.hpp>	// Pascal unit
#include <System.Bindings.EvalSys.hpp>	// Pascal unit
#include <System.Bindings.CustomScope.hpp>	// Pascal unit
#include <System.Bindings.CustomWrapper.hpp>	// Pascal unit
#include <System.Bindings.Manager.hpp>	// Pascal unit
#include <System.Bindings.NotifierContracts.hpp>	// Pascal unit
#include <System.Bindings.NotifierDefaults.hpp>	// Pascal unit
#include <System.Bindings.Graph.hpp>	// Pascal unit
#include <System.Bindings.ExpressionDefaults.hpp>	// Pascal unit
#include <System.Bindings.ManagerDefaults.hpp>	// Pascal unit
#include <System.Bindings.Factories.hpp>	// Pascal unit
#include <System.Bindings.ObjEval.hpp>	// Pascal unit
#include <System.Bindings.Helper.hpp>	// Pascal unit
#include <System.Bindings.Outputs.hpp>	// Pascal unit
#include <System.Bindings.Expression.hpp>	// Pascal unit
#include <Data.Bind.Consts.hpp>	// Pascal unit
#include <Data.Bind.ObserverLinks.hpp>	// Pascal unit
#include <System.Bindings.Methods.hpp>	// Pascal unit
#include <Data.Bind.Grid.hpp>	// Pascal unit
#include <Data.Bind.Editors.hpp>	// Pascal unit
#include <Data.Bind.Components.hpp>	// Pascal unit
#include <Data.Bind.ObjectScope.hpp>	// Pascal unit
#include <IPPeerResStrs.hpp>	// Pascal unit
#include <IPPeerAPI.hpp>	// Pascal unit
#include <REST.Consts.hpp>	// Pascal unit
#include <REST.HttpClient.hpp>	// Pascal unit
#include <REST.Types.hpp>	// Pascal unit
#include <REST.Exception.hpp>	// Pascal unit
#include <REST.BindSource.hpp>	// Pascal unit
#include <REST.Json.Types.hpp>	// Pascal unit
#include <System.NetEncoding.hpp>	// Pascal unit
#include <REST.Json.Interceptors.hpp>	// Pascal unit
#include <REST.JsonReflect.hpp>	// Pascal unit
#include <REST.Json.hpp>	// Pascal unit
#include <REST.Utils.hpp>	// Pascal unit
#include <Data.Bind.JSON.hpp>	// Pascal unit
#include <REST.Client.hpp>	// Pascal unit
#include <REST.Backend.Exception.hpp>	// Pascal unit
#include <REST.Backend.Consts.hpp>	// Pascal unit
#include <IdException.hpp>	// Pascal unit
#include <IdResourceStrings.hpp>	// Pascal unit
#include <IdStreamVCL.hpp>	// Pascal unit
#include <IdStream.hpp>	// Pascal unit
#include <IdGlobal.hpp>	// Pascal unit
#include <IdResourceStringsProtocols.hpp>	// Pascal unit
#include <IdFIPS.hpp>	// Pascal unit
#include <IdCharsets.hpp>	// Pascal unit
#include <IdBaseComponent.hpp>	// Pascal unit
#include <IdWinsock2.hpp>	// Pascal unit
#include <IdWship6.hpp>	// Pascal unit
#include <IdStackConsts.hpp>	// Pascal unit
#include <IdStackBSDBase.hpp>	// Pascal unit
#include <IdIDN.hpp>	// Pascal unit
#include <Winapi.WinSock.hpp>	// Pascal unit
#include <Winapi.IpTypes.hpp>	// Pascal unit
#include <Winapi.IpRtrMib.hpp>	// Pascal unit
#include <Winapi.IpExport.hpp>	// Pascal unit
#include <Winapi.IpHlpApi.hpp>	// Pascal unit
#include <IdStackWindows.hpp>	// Pascal unit
#include <IdStack.hpp>	// Pascal unit
#include <IdIPAddress.hpp>	// Pascal unit
#include <System.Masks.hpp>	// Pascal unit
#include <System.IOUtils.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <IdAssignedNumbers.hpp>	// Pascal unit
#include <IdResourceStringsCore.hpp>	// Pascal unit
#include <IdGlobalProtocols.hpp>	// Pascal unit
#include <IdHash.hpp>	// Pascal unit
#include <IdHashSHA.hpp>	// Pascal unit
#include <IdHMAC.hpp>	// Pascal unit
#include <IdHMACSHA1.hpp>	// Pascal unit
#include <Soap.EncdDecd.hpp>	// Pascal unit
#include <IdComponent.hpp>	// Pascal unit
#include <IdExceptionCore.hpp>	// Pascal unit
#include <IdEMailAddress.hpp>	// Pascal unit
#include <IdHeaderCoderBase.hpp>	// Pascal unit
#include <IdHeaderCoderPlain.hpp>	// Pascal unit
#include <IdHeaderCoder2022JP.hpp>	// Pascal unit
#include <IdHeaderCoderIndy.hpp>	// Pascal unit
#include <IdAllHeaderCoders.hpp>	// Pascal unit
#include <IdCoderHeader.hpp>	// Pascal unit
#include <IdCoder.hpp>	// Pascal unit
#include <IdCoderQuotedPrintable.hpp>	// Pascal unit
#include <IdCoder3to4.hpp>	// Pascal unit
#include <IdCoderMIME.hpp>	// Pascal unit
#include <IdMultipartFormData.hpp>	// Pascal unit
#include <IdHeaderList.hpp>	// Pascal unit
#include <IdAuthentication.hpp>	// Pascal unit
#include <IdHTTPHeaderInfo.hpp>	// Pascal unit
#include <IdReply.hpp>	// Pascal unit
#include <IdReplyRFC.hpp>	// Pascal unit
#include <IdAntiFreezeBase.hpp>	// Pascal unit
#include <IdBuffer.hpp>	// Pascal unit
#include <IdIntercept.hpp>	// Pascal unit
#include <IdIOHandler.hpp>	// Pascal unit
#include <IdSocketHandle.hpp>	// Pascal unit
#include <IdCustomTransparentProxy.hpp>	// Pascal unit
#include <IdIOHandlerStack.hpp>	// Pascal unit
#include <IdTCPConnection.hpp>	// Pascal unit
#include <IdTCPClient.hpp>	// Pascal unit
#include <IdSocks.hpp>	// Pascal unit
#include <IdIOHandlerSocket.hpp>	// Pascal unit
#include <IdYarn.hpp>	// Pascal unit
#include <IdTask.hpp>	// Pascal unit
#include <IdThreadSafe.hpp>	// Pascal unit
#include <IdThread.hpp>	// Pascal unit
#include <IdScheduler.hpp>	// Pascal unit
#include <IdServerIOHandler.hpp>	// Pascal unit
#include <IdSSL.hpp>	// Pascal unit
#include <IdZLibCompressorBase.hpp>	// Pascal unit
#include <IdUriUtils.hpp>	// Pascal unit
#include <IdURI.hpp>	// Pascal unit
#include <IdCookie.hpp>	// Pascal unit
#include <IdCookieManager.hpp>	// Pascal unit
#include <IdAuthenticationManager.hpp>	// Pascal unit
#include <IdResourceStringsOpenSSL.hpp>	// Pascal unit
#include <IdCTypes.hpp>	// Pascal unit
#include <IdSSLOpenSSLHeaders.hpp>	// Pascal unit
#include <IdContext.hpp>	// Pascal unit
#include <IdSchedulerOfThread.hpp>	// Pascal unit
#include <IdServerIOHandlerSocket.hpp>	// Pascal unit
#include <IdServerIOHandlerStack.hpp>	// Pascal unit
#include <IdGlobalCore.hpp>	// Pascal unit
#include <IdSchedulerOfThreadDefault.hpp>	// Pascal unit
#include <IdCustomTCPServer.hpp>	// Pascal unit
#include <IdTCPServer.hpp>	// Pascal unit
#include <IdSSLOpenSSL.hpp>	// Pascal unit
#include <IdStruct.hpp>	// Pascal unit
#include <IdHashMessageDigest.hpp>	// Pascal unit
#include <IdNTLM.hpp>	// Pascal unit
#include <IdAuthenticationNTLM.hpp>	// Pascal unit
#include <IdSSPI.hpp>	// Pascal unit
#include <IdResourceStringsSSPI.hpp>	// Pascal unit
#include <IdAuthenticationSSPI.hpp>	// Pascal unit
#include <IdAuthenticationDigest.hpp>	// Pascal unit
#include <IdAllAuthentications.hpp>	// Pascal unit
#include <IdHTTP.hpp>	// Pascal unit
#include <REST.Backend.MetaTypes.hpp>	// Pascal unit
#include <REST.Backend.ServiceTypes.hpp>	// Pascal unit
#include <REST.Backend.Providers.hpp>	// Pascal unit
#include <System.Messaging.hpp>	// Pascal unit
#include <System.PushNotification.hpp>	// Pascal unit
#include <REST.Backend.PushTypes.hpp>	// Pascal unit
#include <REST.Backend.ServiceFactory.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace App42restapis
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace App42restapis */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_APP42RESTAPIS)
using namespace App42restapis;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// App42restapisHPP
