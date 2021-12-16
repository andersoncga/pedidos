unit Model.Entidades.Pedidos;

interface

uses
  Model.DAO.Interfaces;

type
  TPedidos  = class
    private
      [weak]
      FParent : iDAOEntidade<TPedidos>;
      FNumero_Pedido  : Integer;
      FData_Pedido    : TDate;
      FId_Cliente     : Integer;
      FTotal_Pedido   : Double;
    public
      constructor Create(Parent: iDAOEntidade<TPedidos>);
      destructor Destroy; override;
      function Numero_Pedido(Value: Integer): TPedidos; overload;
      function Numero_Pedido: Integer; overload;
      function Data_Pedido(Value: TDate): TPedidos; overload;
      function Data_Pedido: TDate; overload;
      function Id_Cliente(Value: Integer): TPedidos; overload;
      function Id_Cliente: Integer; overload;
      function Total_Pedido(Value: Double): TPedidos; overload;
      function Total_Pedido: Double; overload;
      function &End: iDAOEntidade<TPedidos>;
  end;
implementation

{ TPedidos }

function TPedidos.&End: iDAOEntidade<TPedidos>;
begin
  Result  :=  FParent;
end;

constructor TPedidos.Create(Parent: iDAOEntidade<TPedidos>);
begin
  FParent :=  Parent;
end;

function TPedidos.Data_Pedido: TDate;
begin
  Result  :=  FData_Pedido;
end;

function TPedidos.Data_Pedido(Value: TDate): TPedidos;
begin
  Result        :=  Self;
  FData_Pedido  :=  Value;
end;

destructor TPedidos.Destroy;
begin

  inherited;
end;

function TPedidos.Id_Cliente: Integer;
begin
  Result  :=  FId_Cliente;
end;

function TPedidos.Id_Cliente(Value: Integer): TPedidos;
begin
  Result        :=  Self;
  FId_Cliente   :=  Value;
end;

function TPedidos.Numero_Pedido: Integer;
begin
  Result  :=  FNumero_Pedido;
end;

function TPedidos.Numero_Pedido(Value: Integer): TPedidos;
begin
  Result        :=  Self;
  FNumero_Pedido:=  Value;
end;

function TPedidos.Total_Pedido: Double;
begin
  Result  :=  FTotal_Pedido;
end;

function TPedidos.Total_Pedido(Value: Double): TPedidos;
begin
  Result        :=  Self;
  FTotal_Pedido :=  Value;
end;

end.
