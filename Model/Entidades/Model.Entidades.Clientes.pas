unit Model.Entidades.Clientes;

interface

uses
  Model.DAO.Interfaces;

type
  TClientes = class
    private
      [weak]
      FParent : iDAOEntidade<TClientes>;
      FCodigo : Integer;
      FNome   : string;
      FCidade : string;
      FUf     : string;
    public
      constructor Create(Parent: iDAOEntidade<TClientes>);
      destructor Destroy; override;
      function Codigo(Value: Integer): TClientes; overload;
      function Codigo: Integer; overload;
      function Nome(Value: string): TClientes; overload;
      function Nome: string; overload;
      function Cidade(Value: string): TClientes; overload;
      function Cidade: string; overload;
      function Uf(Value: string): TClientes; overload;
      function Uf: string; overload;
      function &End : iDAOEntidade<TClientes>;

  end;

implementation

{ TClientes }

function TClientes.&End: iDAOEntidade<TClientes>;
begin
  Result  :=  FParent;
end;

function TClientes.Cidade: string;
begin
  Result  :=  FCidade;
end;

function TClientes.Cidade(Value: string): TClientes;
begin
  Result  := Self;
  FCidade := Value;
end;

function TClientes.Codigo(Value: Integer): TClientes;
begin
  Result  := Self;
  FCodigo := Value;
end;

function TClientes.Codigo: Integer;
begin
  Result  :=  FCodigo;
end;

constructor TClientes.Create(Parent: iDAOEntidade<TClientes>);
begin
  FParent :=  Parent;
end;

destructor TClientes.Destroy;
begin

  inherited;
end;

function TClientes.Nome(Value: string): TClientes;
begin
  Result  := Self;
  FNome   := Value;
end;

function TClientes.Nome: string;
begin
  Result  :=  FNome;
end;

function TClientes.Uf: string;
begin
  Result  :=  FUf;
end;

function TClientes.Uf(Value: string): TClientes;
begin
  Result  := Self;
  FUf     := Value;
end;

end.
