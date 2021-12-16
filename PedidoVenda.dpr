program PedidoVenda;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {ViewPrincipal},
  Model.Conexao.Interfaces in 'Model\Conexao\Model.Conexao.Interfaces.pas',
  Model.Conexao.Firedac in 'Model\Conexao\Model.Conexao.Firedac.pas',
  Model.Entidades.Pedidos in 'Model\Entidades\Model.Entidades.Pedidos.pas',
  Model.Entidades.PedidosItens in 'Model\Entidades\Model.Entidades.PedidosItens.pas',
  Model.Entidades.Clientes in 'Model\Entidades\Model.Entidades.Clientes.pas',
  Model.Entidades.Produtos in 'Model\Entidades\Model.Entidades.Produtos.pas',
  Model.DAO.Interfaces in 'Model\DAO\Model.DAO.Interfaces.pas',
  Model.DAO.Pedidos in 'Model\DAO\Model.DAO.Pedidos.pas',
  Model.DAO.PedidosItens in 'Model\DAO\Model.DAO.PedidosItens.pas',
  Controller.Interfaces in 'Controller\Controller.Interfaces.pas',
  Controller.Entidades in 'Controller\Controller.Entidades.pas',
  Controller.Controller in 'Controller\Controller.Controller.pas',
  Model.DAO.Clientes in 'Model\DAO\Model.DAO.Clientes.pas',
  Model.DAO.Produtos in 'Model\DAO\Model.DAO.Produtos.pas',
  View.ToastAlert in 'View\View.ToastAlert.pas' {ViewToastAlert},
  Helper.GlobalFunctions in 'Helper\Helper.GlobalFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TViewToastAlert, ViewToastAlert);
  Application.Run;
end.
