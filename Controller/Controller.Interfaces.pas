unit Controller.Interfaces;

interface

uses
  Model.DAO.Interfaces,
  Model.Entidades.Pedidos,
  Model.Entidades.PedidosItens,
  Model.Entidades.Clientes,
  Model.Entidades.Produtos;

type

  iControllerEntidades = interface;

  iController = interface
    function Entidades : iControllerEntidades;
  end;

  iControllerEntidades = interface
    function Pedidos :  iDaoEntidade<TPedidos>;
    function PedidosItens : iDaoEntidade<TPedidosItens>;
    function Clientes : iDaoEntidade<TClientes>;
    function Produtos : iDaoEntidade<TProdutos>;
  end;

implementation

end.
