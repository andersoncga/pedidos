unit Model.Entidades.Produtos;

interface

uses
  Model.DAO.Interfaces;

type
  TProdutos = class
    private
      [weak]
      FParent : iDAOEntidade<TProdutos>;
      FCodigo : Integer;
      FDescricao: string;
      FPreco_Venda: Double;

    public
      constructor Create(Parent: iDAOEntidade<TProdutos>);
      destructor Destroy; override;
      function Codigo(Value: Integer): TProdutos; overload;
      function Codigo: Integer; overload;
      function Descricao(Value: string): TProdutos; overload;
      function Descricao: string; overload;
      function Preco_Venda(Value: Double): TProdutos; overload;
      function Preco_Venda: Double; overload;
      function &End : iDAOEntidade<TProdutos>;

  end;
implementation

{ TProdutos }

function TProdutos.&End: iDAOEntidade<TProdutos>;
begin
  Result  :=  FParent;
end;

function TProdutos.Codigo: Integer;
begin
  Result  :=  FCodigo;
end;

function TProdutos.Codigo(Value: Integer): TProdutos;
begin
  Result  := Self;
  FCodigo := Value;
end;

constructor TProdutos.Create(Parent: iDAOEntidade<TProdutos>);
begin
  FParent :=  Parent;
end;

function TProdutos.Descricao(Value: string): TProdutos;
begin
  Result      := Self;
  FDescricao  := Value;
end;

function TProdutos.Descricao: string;
begin
  Result  :=  FDescricao;
end;

destructor TProdutos.Destroy;
begin

  inherited;
end;

function TProdutos.Preco_Venda: Double;
begin
  Result  :=  FPreco_Venda;
end;

function TProdutos.Preco_Venda(Value: Double): TProdutos;
begin
  Result        :=  Self;
  FPreco_Venda  :=  Value;
end;

end.
