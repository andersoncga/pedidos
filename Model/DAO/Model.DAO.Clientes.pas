unit Model.DAO.Clientes;

interface

uses
  Model.Entidades.Clientes,
  Data.DB,
  Model.DAO.Interfaces,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;

type
  TDAOCliente = class(TInterfacedObject, iDAOEntidade<TClientes>)
    private
      FClientes: TClientes;
      FConexao: iConexao;
      FDataSet: TDataSet;

    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iDAOEntidade<TClientes>;
      function Listar : iDaoEntidade<TClientes>;
      function ListarPorId(Id: Integer): iDaoEntidade<TClientes>;
      function Excluir(Id: Integer): iDaoEntidade<TClientes>; overload;
      function Excluir: iDaoEntidade<TClientes>; overload;
      function Atualizar: iDaoEntidade<TClientes>;
      function Inserir: iDaoEntidade<TClientes>;
      function DataSet(DataSource: TDataSource):  iDaoEntidade<TClientes>;
      function This: TClientes;
  end;

implementation

uses
  System.SysUtils;

{ TDAOPedido }

function TDAOCliente.Atualizar: iDaoEntidade<TClientes>;
begin
  Result := Self;
  try
    FConexao
      .SQL('update clientes set nome=:nome, cidade=:cidade, uf=:uf where codigo=:id')
      .Params('nome', FClientes.Nome)
      .Params('cidade', FClientes.Cidade)
      .Params('uf', FClientes.Uf)
      .Params('id', FClientes.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TDAOCliente.Create;
begin
  FConexao  :=  TModelConexao.New;
  FClientes :=  TClientes.Create(Self)
end;

function TDAOCliente.DataSet(DataSource: TDataSource): iDaoEntidade<TClientes>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConexao.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

destructor TDAOCliente.Destroy;
begin
  FClientes.DisposeOf;
  inherited;
end;

function TDAOCliente.Excluir(Id: Integer): iDaoEntidade<TClientes>;
begin
  Result := Self;
  try
    FConexao
      .SQL('delete from clientes where codigo=:id')
      .Params('id', Id)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TDAOCliente.Excluir: iDaoEntidade<TClientes>;
begin
  Result := Self;
  try
    FConexao
      .SQL('delete from clientes where codigo=:id')
      .Params('id', FClientes.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TDAOCliente.Inserir: iDaoEntidade<TClientes>;
begin
  Result := Self;
  try
    FConexao
      .SQL('insert into clientes (nome, cidade, uf) values (:nome, :cidade, :uf)')
      .Params('nome', FClientes.Nome)
      .Params('cidade', FClientes.Cidade)
      .Params('uf', FClientes.Uf)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TDAOCliente.Listar: iDaoEntidade<TClientes>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConexao
      .SQL('select * from clientes')
      .Open
      .DataSet;
end;

function TDAOCliente.ListarPorId(Id: Integer): iDaoEntidade<TClientes>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConexao
      .SQL('select * from clientes where codigo=:id')
      .Params('id', Id)
      .Open
      .DataSet;
end;

class function TDAOCliente.New: iDAOEntidade<TClientes>;
begin
  Result  :=  Self.Create;
end;

function TDAOCliente.This: TClientes;
begin
  Result  :=  FClientes;
end;

end.
