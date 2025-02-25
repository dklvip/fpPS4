unit ps4_libSceUsbd;

{$mode ObjFPC}{$H+}

interface

uses
 sys_types,
 ps4_program;

implementation

const
 SCE_USBD_ERROR_NO_DEVICE=$80240004;
 SCE_USBD_ERROR_NOT_FOUND=$80240005;

type
 SceUsbdDevice=Pointer;
 PSceUsbdDevice=^SceUsbdDevice;

function ps4_sceUsbdInit:Integer; SysV_ABI_CDecl;
begin
 Writeln('sceUsbdInit');
 Result:=SCE_USBD_ERROR_NOT_FOUND;
end;

function ps4_sceUsbdGetDeviceList(list:PSceUsbdDevice):Integer; SysV_ABI_CDecl;
begin
 Writeln('sceUsbdGetDeviceList');
 Result:=0;
end;

procedure ps4_sceUsbdFreeDeviceList(list:PSceUsbdDevice;unrefDevices:Integer); SysV_ABI_CDecl;
begin
 Writeln('sceUsbdFreeDeviceList');
end;

function ps4_sceUsbdHandleEventsTimeout(tv:Ptimeval):Integer; SysV_ABI_CDecl;
begin
 Writeln('sceUsbdHandleEventsTimeout');
 if tv<>nil then
 begin
  Writeln('sec=',tv^.tv_sec,',usec=',tv^.tv_usec);
 end;
 Result:=0;
end;

function Load_libSceUsbd(Const name:RawByteString):TElf_node;
var
 lib:PLIBRARY;
begin
 Result:=TElf_node.Create;
 Result.pFileName:=name;

 lib:=Result._add_lib('libSceUsbd');

 lib^.set_proc($4CE860ECFEA44C7E,@ps4_sceUsbdInit);
 lib^.set_proc($F2A07D02BE0FE677,@ps4_sceUsbdGetDeviceList);
 lib^.set_proc($110E9208B32ACE43,@ps4_sceUsbdFreeDeviceList);
 lib^.set_proc($FB053A086B997169,@ps4_sceUsbdHandleEventsTimeout);
end;

initialization
 ps4_app.RegistredPreLoad('libSceUsbd.prx',@Load_libSceUsbd);

end.
