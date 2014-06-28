unit StorageForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, IPPeerClient, REST.Backend.ServiceTypes, REST.Backend.MetaTypes,
  System.JSON, REST.Backend.App42Services, REST.Backend.Providers,
  REST.Backend.ServiceComponents;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Back: TButton;
    SaveObject: TButton;
    Button2: TButton;
    Button3: TButton;
    BackendStorage1: TBackendStorage;
    Button1: TButton;
    procedure BackClick(Sender: TObject);
    procedure SaveObjectClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ObjectId: string;
    BackendEntityVal : TBackendEntityValue;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

 uses UserSample;

procedure TForm1.BackClick(Sender: TObject);
begin
     Form1.Hide;
     Form2.Show;
end;


procedure TForm1.SaveObjectClick(Sender: TObject);
var
  LJSONObject: TJSONObject;
  LEntityValue: TBackendEntityValue;
begin
 LJSONObject := TJSONObject.Create;
    try
      LJSONObject.AddPair('name', 'elmo');
      LJSONObject.AddPair('address', 'gurgaon');
      BackendStorage1.Storage.CreateObject('MyCollection', LJSONObject, LEntityValue);
      ObjectId := LEntityValue.ObjectID;
      Edit1.Text := 'Object created At '+ DateTimeToStr(LEntityValue.CreatedAt) +' With id ' + LEntityValue.ObjectID;
      ShowMessage('Object Created');
    finally
      LJSONObject.Free;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LJSONObject: TJSONObject;
  LEntityValue: TBackendEntityValue;
begin
 LJSONObject := TJSONObject.Create;
    try
      LJSONObject.AddPair('name', 'bert');
      LJSONObject.AddPair('address', 'delhi');
   BackendStorage1.Storage.UpdateObject('MyCollection', ObjectId, LJSONObject, LEntityValue);
   ShowMessage('Object Updated.');
 finally
 LJSONObject.Free;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   BackendStorage1.Storage.FindObject('MyCollection', ObjectId,
          procedure(const AID: TBackendEntityValue; const AJSONObject: TJSONObject)
          begin
           Edit1.Text := 'Object Found ' + AID.ObjectID;
          BackendEntityVal := AID;
          ShowMessage('Object Found');
          end);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
LDelete: Boolean;
begin
LDelete := BackendStorage1.Storage.DeleteObject('MyCollection',BackendEntityVal.ObjectID);
ShowMessage('Is deleted ' + BoolToStr(LDelete));
end;

end.
