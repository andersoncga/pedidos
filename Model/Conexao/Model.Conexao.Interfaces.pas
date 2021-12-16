unit Model.Conexao.Interfaces;

interface

uses
  Data.DB;

type
  iConexao = interface
    function Params(Param: string; Value: Variant): iConexao;
    function DataSet(DataSource: TDataSource): iConexao; overload;
    function DataSet: TDataSet; overload;
    function ExecSQL: iConexao;
    function Open: iConexao;
    function SQL(Value: string): iConexao;
  end;

implementation

end.
