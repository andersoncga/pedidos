unit Controller.Entidades;

interface

uses
  Controller.Interfaces,
  Model.DAO.Interfaces,
  Model.Entidades.PedidosItens,
  Model.Entidades.Pedidos,
  Model.DAO.PedidosItens,
  Model.DAO.Pedidos,
  Model.Entidades.Clientes,
  Model.DAO.Clientes,
  Model.Entidades.Produtos,
  Model.DAO.Produtos;

type
  TControllerEntidades = class(TInterfacedObject, iControllerEntidades)
    private
      FPedidos :  iDaoEntidade<TPedidos>;
      FPedidosItens : iDaoEntidade<TPedidosItens>;
      FClientes : iDaoEntidade<TClientes>;
      FProdutos : iDaoEntidade<TProdutos>;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerEntidades;
      function Pedidos :  iDaoEntidade<TPedidos>;
      function PedidosItens : iDaoEntidade<TPedidosItens>;
      function Clientes : iDaoEntidade<TClientes>;
      function Produtos : iDaoEntidade<TProdutos>;
  end;

implementation

{ TControllerEntidades }

function TControllerEntidades.Clientes: iDaoEntidade<TClientes>;
begin
  if not Assigned(FClientes) then
    FClientes  :=  TDAOCliente.New;

  Result  :=  FClientes;
end;

constructor TControllerEntidades.Create;
begin
end;

destructor TControllerEntidades.Destroy;
begin

  inherited;
end;

class function TControllerEntidades.New: iControllerEntidades;
begin
  Result  :=  Self.Create;
end;

function TControllerEntidades.Pedidos: iDaoEntidade<TPedidos>;
begin
  if not Assigned(FPedidos) then
    FPedidos  :=  TDAOPedido.New;

  Result  :=  FPedidos;
end;

function TControllerEntidades.PedidosItens: iDaoEntidade<TPedidosItens>;
begin
  if not Assigned(FPedidosItens) then
    FPedidosItens  :=  TDAOPedidosItens.New;

  Result  :=  FPedidosItens;
end;

function TControllerEntidades.Produtos: iDaoEntidade<TProdutos>;
begin
  if not Assigned(FProdutos) then
    FProdutos  :=  TDAOProduto.New;

  Result  :=  FProdutos;
end;

end.
