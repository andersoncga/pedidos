unit Model.DAO.Produtos;

interface

uses
  Model.Entidades.Produtos,
  Data.DB,
  Model.DAO.Interfaces,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;

type
  TDAOProduto = class(TInterfacedObject, iDAOEntidade<TProdutos>)
    private
      FProdutos: TProdutos;
      FConexao: iConexao;
      FDataSet: TDataSet;

    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iDAOEntidade<TProdutos>;
      function Listar : iDaoEntidade<TProdutos>;
      function ListarPorId(Id: Integer): iDaoEntidade<TProdutos>;
      function Excluir(Id: Integer): iDaoEntidade<TProdutos>; overload;
      function Excluir: iDaoEntidade<TProdutos>; overload;
      function Atualizar: iDaoEntidade<TProdutos>;
      function Inserir: iDaoEntidade<TProdutos>;
      function DataSet(DataSource: TDataSource):  iDaoEntidade<TProdutos>;
      function This: TProdutos;
  end;

implementation

uses
  System.SysUtils;

{ TDAOPedido }

function TDAOProduto.Atualizar: iDaoEntidade<TProdutos>;
begin
  Result := Self;
  try
    FConexao
      .SQL('update produtos set descricao=:descricao, preco_venda=:preco where codigo=:id')
      .Params('descricao', FProdutos.Descricao)
      .Params('preco', FProdutos.Preco_Venda)
      .Params('id', FProdutos.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TDAOProduto.Create;
begin
  FConexao  :=  TModelConexao.New;
  FProdutos :=  TProdutos.Create(Self)
end;

function TDAOProduto.DataSet(DataSource: TDataSource): iDaoEntidade<TProdutos>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConexao.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

destructor TDAOProduto.Destroy;
begin
  FProdutos.DisposeOf;
  inherited;
end;

function TDAOProduto.Excluir(Id: Integer): iDaoEntidade<TProdutos>;
begin
  Result := Self;
  try
    FConexao
      .SQL('delete from produtos where codigo=:id')
      .Params('id', Id)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TDAOProduto.Excluir: iDaoEntidade<TProdutos>;
begin
  Result := Self;
  try
    FConexao
      .SQL('delete from produtos where codigo=:id')
      .Params('id', FProdutos.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TDAOProduto.Inserir: iDaoEntidade<TProdutos>;
begin
  Result := Self;
  try
    FConexao
      .SQL('insert into produtos (descricao, preco_venda) values (:descricao, :preco)')
      .Params('descricao', FProdutos.Descricao)
      .Params('cidade', FProdutos.Preco_Venda)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TDAOProduto.Listar: iDaoEntidade<TProdutos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConexao
      .SQL('select * from produtos')
      .Open
      .DataSet;
end;

function TDAOProduto.ListarPorId(Id: Integer): iDaoEntidade<TProdutos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConexao
      .SQL('select * from produtos where codigo=:id')
      .Params('id', Id)
      .Open
      .DataSet;
end;

class function TDAOProduto.New: iDAOEntidade<TProdutos>;
begin
  Result  :=  Self.Create;
end;

function TDAOProduto.This: TProdutos;
begin
  Result  :=  FProdutos;
end;

end.
