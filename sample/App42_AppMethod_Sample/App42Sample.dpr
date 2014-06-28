program App42Sample;

uses
  FMX.Forms,
  UserSample in 'UserSample.pas' {Form2},
  StorageForm in 'StorageForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
