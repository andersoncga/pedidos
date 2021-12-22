unit View.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Controller.Interfaces,
  Controller.Controller;

type
  TViewPrincipal = class(TForm)
    pnl_header: TPanel;
    lbl_client: TLabel;
    cbb_client: TComboBox;
    btn_new_pedido: TButton;
    pnl_body: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl_total: TLabel;
    lbl_total_pedido: TLabel;
    edt_produto: TEdit;
    edt_descricao_produto: TEdit;
    edt_preco_venda: TEdit;
    edt_qtde: TEdit;
    edt_total: TEdit;
    btn_new_produto: TButton;
    dbg_itens: TDBGrid;
    ds_itens: TDataSource;
    dbg_pedidos: TDBGrid;
    ds_pedidos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbg_pedidosCellClick(Column: TColumn);
    procedure btn_new_pedidoClick(Sender: TObject);
    procedure btn_new_produtoClick(Sender: TObject);
    procedure edt_produtoExit(Sender: TObject);
  private
    { Private declarations }
    procedure Listar;
    procedure IncluirPedido;
    procedure IncluirItem;
    function RetornaId_Cliente(Index: Integer): Integer;
    procedure PreencheComboBox;
    procedure ListarItem(Pedido: Integer);
    procedure Busca_Produto(Produto: string);
    procedure LimparCampos;
    procedure CalculaTotal;

  public
    { Public declarations }
    FController : iController;

  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

uses Helper.GlobalFunctions;

procedure TViewPrincipal.btn_new_pedidoClick(Sender: TObject);
begin
  if (cbb_client.ItemIndex<0) then begin
    ToastAlert('Atenção', 'Informe o cliente antes de incluir um novo pedido', taWarning);
    exit;
  end;

  IncluirPedido;
  ToastAlert('Sucesso', 'Pedido adicionado', taSuccess);
end;

procedure TViewPrincipal.btn_new_produtoClick(Sender: TObject);
begin
  if (edt_produto.Text='') then begin
    ToastAlert('Atenção', 'Informe o produto antes de incluir um novo item', taWarning);
    exit;
  end;

  IncluirItem;
  ToastAlert('Sucesso', 'Item adicionado', taSuccess);
  LimparCampos;
  edt_produto.SetFocus;
end;

procedure TViewPrincipal.dbg_pedidosCellClick(Column: TColumn);
begin
  dbg_itens.SelectedRows.Clear;
  dbg_pedidos.SelectedRows.CurrentRowSelected := True;
  FController
    .Entidades
    .PedidosItens
    .ListarPorId(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
    .DataSet(ds_itens);
  if not ds_pedidos.DataSet.IsEmpty then
    lbl_total_pedido.Caption  :=
      'Total do Pedido R$ ' +
      FormatFloat('#,##0.00', ds_pedidos.DataSet.FieldByName('total_pedido').AsFloat)
  else
    lbl_total_pedido.Caption  :=
      'Total do Pedido R$ ';
end;

procedure TViewPrincipal.edt_produtoExit(Sender: TObject);
begin
  if (edt_produto.Text <> '') then
    Busca_Produto(edt_produto.Text);
end;

procedure TViewPrincipal.Busca_Produto(Produto: string);
var
  LCod: Integer;
  LProduto: TDataSource;
begin

  TryStrToInt(Produto, LCod);
  LProduto  :=  TDataSource.Create(Self);
  try
    FController
      .Entidades
      .Produtos
      .ListarPorId(LCod)
      .DataSet(LProduto);

    if not LProduto.DataSet.IsEmpty then begin
      edt_descricao_produto.Text  :=  LProduto.DataSet.FieldByName('descricao').AsString;
      edt_preco_venda.Text        :=  LProduto.DataSet.FieldByName('preco_venda').AsString;
      CalculaTotal;
      Perform(WM_NEXTDLGCTL,0,0);
    end
    else
    begin
      edt_produto.SetFocus;
      LimparCampos;
    end;

  finally
    LProduto.DisposeOf;
  end;
end;

procedure TViewPrincipal.CalculaTotal;
var
  LUnit,
  LQtd    : Double;
begin
  TryStrToFloat(edt_qtde.Text, LQtd);
  TryStrToFloat(edt_preco_venda.Text, LUnit);
  edt_total.Text  :=  FormatFloat('#,##0.00', (LQtd*LUnit));
end;
                                                         
procedure TViewPrincipal.LimparCampos;
begin
  edt_produto.Text            :=  '';
  edt_descricao_produto.Text  :=  '';
  edt_preco_venda.Text        :=  '0,00';
  edt_total.Text              :=  '0,00';
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  Listar;
  PreencheComboBox;
end;

procedure TViewPrincipal.IncluirItem;
var
  LSoma : Double; 
begin
  LSoma := 0;
  
  FController
    .Entidades
    .PedidosItens
      .This
        .Numero_Pedido(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
        .Id_Produto(StrToInt(edt_produto.Text))
        .Qtd(StrToInt(edt_qtde.Text))
        .Preco_Venda(StrToFloat(edt_preco_venda.Text))
      .&End
    .Inserir;

  ListarItem(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger);

  ds_itens.DataSet.First;
  while not ds_itens.DataSet.Eof do begin
    LSoma :=  LSoma + (ds_itens.DataSet.FieldByName('qtd').AsFloat*ds_itens.DataSet.FieldByName('preco_venda').AsFloat);
    ds_itens.DataSet.Next; 
  end;
      
  FController
    .Entidades
    .Pedidos
      .This
        .Id_Cliente(ds_pedidos.DataSet.FieldByName('id_cliente').AsInteger)
        .Total_Pedido(LSoma)
        .Numero_Pedido(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
      .&End
    .Atualizar;  

  Listar;
end;

procedure TViewPrincipal.ListarItem(Pedido: Integer);
begin
  FController
    .Entidades
    .PedidosItens
      .ListarPorId(Pedido)
    .DataSet(ds_itens);
end;

procedure TViewPrincipal.IncluirPedido;
begin
  FController
    .Entidades
    .Pedidos
      .This
        .Id_Cliente(RetornaId_Cliente(cbb_client.ItemIndex))
        .Total_Pedido(0)
      .&End
    .Inserir;

  Listar;
end;

procedure TViewPrincipal.Listar;
begin
  FController
    .Entidades
    .Pedidos
    .Listar
    .DataSet(ds_pedidos);
  FController
    .Entidades
    .PedidosItens
    .Listar
    .DataSet(ds_itens);
end;

procedure TViewPrincipal.PreencheComboBox;
var
  Lista: TDataSource;
begin
  Lista :=  TDataSource.Create(Self);
  try

    FController
      .Entidades
      .Clientes
      .Listar
      .DataSet(Lista);

    Lista.DataSet.First;
    while not Lista.DataSet.Eof do begin
      cbb_client.Items.AddObject(
        Lista
          .DataSet
            .FieldByName('nome').AsString,
        TObject(
          Lista
            .DataSet
              .FieldByName('codigo').AsInteger
        )
      );
      Lista.DataSet.Next;
    end;

  finally
    Lista.DisposeOf;
  end;
end;

function TViewPrincipal.RetornaId_Cliente(Index: Integer): Integer;
begin
  Result := Integer(cbb_client.Items.Objects[Index]);
end;

end.
