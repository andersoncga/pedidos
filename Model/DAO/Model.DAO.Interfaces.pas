unit Model.DAO.Interfaces;

interface

uses
  Data.DB;

type
  iDaoEntidade<T> = interface
    function Listar : iDaoEntidade<T>;
    function ListarPorId(Id: Integer): iDaoEntidade<T>;
    function Excluir(Id: Integer): iDaoEntidade<T>; overload;
    function Excluir: iDaoEntidade<T>; overload;
    function Atualizar: iDaoEntidade<T>;
    function Inserir: iDaoEntidade<T>;
    function DataSet(DataSource: TDataSource):  iDaoEntidade<T>;
    function This: T;
  end;

implementation

end.
