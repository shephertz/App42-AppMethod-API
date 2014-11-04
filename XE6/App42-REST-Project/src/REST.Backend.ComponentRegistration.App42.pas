unit REST.Backend.ComponentRegistration.App42;

interface

uses
  System.Classes;

procedure Register;

implementation

uses
  REST.Backend.App42Provider,
  REST.Backend.App42Services,
  REST.Backend.App42PushDevice,
  REST.Backend.App42MetaTypes,
  REST.Backend.App42Api;

procedure Register;
begin
  RegisterComponents('BAAS Client', [TApp42Provider]);
end;

end.


