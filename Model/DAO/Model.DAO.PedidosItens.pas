unit Model.DAO.PedidosItens;

interface

uses
  Model.DAO.Interfaces,
  Model.Entidades.PedidosItens,
  Data.DB,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;

type
  TDAOPedidosItens = class(TInterfacedObject, iDAOEntidade<TPedidosItens>)
    private
      FPedidosItens: TPedidosItens;
      FConexao: iConexao;
      FDataSet: TDataSet;

    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iDAOEntidade<TPedidosItens>;
      function Listar : iDaoEntidade<TPedidosItens>;
      function ListarPorId(Id: Integer): iDaoEntidade<TPedidosItens>;
      function Excluir(Id: Integer): iDaoEntidade<TPedidosItens>; overload;
      function Excluir: iDaoEntidade<TPedidosItens>; overload;
      function Atualizar: iDaoEntidade<TPedidosItens>;
      function Inserir: iDaoEntidade<TPedidosItens>;
      function DataSet(DataSource: TDataSource):  iDaoEntidade<TPedidosItens>;
      function This: TPedidosItens;
  end;

implementation

uses
  System.SysUtils;

{ TPedidosItens }

function TDAOPedidosItens.Atualizar: iDaoEntidade<TPedidosItens>;
begin
  Result := Self;
  try
    FConexao
      .SQL('update pedidos_itens set qtd=:dtd, preco_venda=:preco where numero_item=:id')
      .Params('qtd', FPedidosItens.qtd)
      .Params('preco', FPedidosItens.Preco_Venda)
      .Params('id', FPedidosItens.Numero_Item)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TDAOPedidosItens.Create;
begin
  FConexao       :=  TModelConexao.New;
  FPedidosItens  :=  TPedidosItens.Create(Self)
end;

function TDAOPedidosItens.DataSet(
  DataSource: TDataSource): iDaoEntidade<TPedidosItens>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConexao.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

destructor TDAOPedidosItens.Destroy;
begin
  FPedidosItens.DisposeOf;
  inherited;
end;

function TDAOPedidosItens.Excluir(Id: Integer): iDaoEntidade<TPedidosItens>;
begin
  Result := Self;
  try
    FConexao
      .SQL('delete from pedidos_itens where id=:id')
      .Params('id', Id)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TDAOPedidosItens.Excluir: iDaoEntidade<TPedidosItens>;
begin
  Result := Self;
  try
    FConexao
      .SQL('delete from pedidos_itens where id=:id')
      .Params('id', FPedidosItens.Numero_Item)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TDAOPedidosItens.Inserir: iDaoEntidade<TPedidosItens>;
begin
  Result := Self;
  try
    FConexao
      .SQL('insert into pedidos_itens (numero_pedido, id_produto, qtd, preco_venda) values (:id, :idproduto, :qtd, :preco)')
      .Params('id', FPedidosItens.Numero_Pedido)
      .Params('idproduto', FPedidosItens.Id_Produto)
      .Params('qtd', FPedidosItens.Qtd)
      .Params('preco', FPedidosItens.Preco_Venda)
      .ExecSQL;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TDAOPedidosItens.Listar: iDaoEntidade<TPedidosItens>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConexao
      .SQL('select * from pedidos_itens')
      .Open
      .DataSet;
end;

function TDAOPedidosItens.ListarPorId(Id: Integer): iDaoEntidade<TPedidosItens>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConexao
      .SQL('select * from pedidos_itens where numero_pedido=:id')
      .Params('id', Id)
      .Open
      .DataSet;
end;

class function TDAOPedidosItens.New: iDAOEntidade<TPedidosItens>;
begin
  Result  :=  Self.Create;
end;

function TDAOPedidosItens.This: TPedidosItens;
begin
  Result  :=  FPedidosItens;
end;

end.
