unit Model.Conexao.Firedac;

interface

uses
  Firedac.Stan.Intf,
  Firedac.Stan.Option,
  Firedac.Stan.Error,
  Firedac.UI.Intf,
  Firedac.Phys.Intf,
  Firedac.Stan.Def,
  Firedac.Stan.Pool,
  Firedac.Stan.Async,
  Firedac.Phys,
  Firedac.Phys.MySQL,
  Firedac.Phys.MySQLDef,
  Firedac.Stan.ExprFuncs,
  Firedac.VCLUI.Wait,
  Firedac.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Model.Conexao.Interfaces,
  Data.DB;

type
  TModelConexao = class(TInterfacedObject, iConexao)
    private
      FConexao    : TFDConnection;
      FQuery      : TFDQuery;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iConexao;
      function Params(Param: string; Value: Variant): iConexao;
      function DataSet(DataSource: TDataSource): iConexao; overload;
      function DataSet: TDataSet; overload;
      function ExecSQL: iConexao;
      function Open: iConexao;
      function SQL(Value: string): iConexao;
  end;

implementation

{ TModelConexao }

constructor TModelConexao.Create;
begin
  FConexao          :=  TFDConnection.Create(nil);
  FQuery            :=  TFDQuery.Create(nil);
  FQuery.Connection :=  FConexao;
  FConexao.Params.Clear;
  FConexao.Params.Add('DriverID=MySQL');
  FConexao.Params.Add('Server=127.0.0.1');
  FConexao.Params.Add('Port=3306');
  FConexao.Params.Add('Database=pedidos');
  FConexao.Params.Add('CharacterSet=utf8');
  FConexao.Params.Add('User_Name=root');
  FConexao.Params.Add('Password=toor');
  FConexao.Connected := True;
end;

function TModelConexao.DataSet(DataSource: TDataSource): iConexao;
begin
  Result              :=  Self;
  DataSource.DataSet  :=  FQuery;
end;

function TModelConexao.DataSet: TDataSet;
begin
  Result  :=  FQuery;
end;

destructor TModelConexao.Destroy;
begin
  FConexao.DisposeOf;
  FQuery.DisposeOf;
  inherited;
end;

function TModelConexao.ExecSQL: iConexao;
begin
  Result  :=  Self;
  FQuery.ExecSQL;
end;

class function TModelConexao.New: iConexao;
begin
  Result  :=  Self.Create;
end;

function TModelConexao.Open: iConexao;
begin
  Result  :=  Self;
  FQuery.Open;
end;

function TModelConexao.Params(Param: string; Value: Variant): iConexao;
begin
  Result                           :=  Self;
  FQuery.ParamByName(Param).Value  :=  Value;
end;

function TModelConexao.SQL(Value: string): iConexao;
begin
  Result  :=  Self;
  FQuery.SQL.Clear;
  FQuery.SQl.Add(Value)
end;

end.
