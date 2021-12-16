unit Controller.Controller;

interface

uses
  Controller.Interfaces,
  Controller.Entidades;

type
  TController = class(TInterfacedObject, iController)
    private
      FEntidade : iControllerEntidades;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iController;
      function Entidades : iControllerEntidades;
  end;

implementation

{ TController }

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Entidades: iControllerEntidades;
begin
  if not Assigned(FEntidade) then
    FEntidade := TControllerEntidades.New;

  Result  :=  FEntidade;
end;

class function TController.New: iController;
begin
  Result  :=  Self.Create;
end;

end.
