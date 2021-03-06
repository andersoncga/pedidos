object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ViewPrincipal'
  ClientHeight = 459
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnl_header: TPanel
    Left = 0
    Top = 0
    Width = 555
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbl_client: TLabel
      Left = 15
      Top = 13
      Width = 98
      Height = 15
      Caption = 'Selecione o cliente'
    end
    object cbb_client: TComboBox
      Left = 15
      Top = 34
      Width = 482
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
    object btn_new_pedido: TButton
      Left = 508
      Top = 32
      Width = 35
      Height = 25
      Hint = 'Novo pedido de venda'
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btn_new_pedidoClick
    end
  end
  object pnl_body: TPanel
    Left = 0
    Top = 65
    Width = 555
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 15
      Top = 135
      Width = 71
      Height = 15
      Caption = 'C'#243'd. Produto'
    end
    object Label2: TLabel
      Left = 87
      Top = 135
      Width = 46
      Height = 15
      Caption = 'Decri'#231#227'o'
    end
    object Label3: TLabel
      Left = 335
      Top = 135
      Width = 38
      Height = 15
      Caption = 'Vl. Unit'
    end
    object Label4: TLabel
      Left = 405
      Top = 135
      Width = 26
      Height = 15
      Caption = 'Qtde'
    end
    object lbl_total: TLabel
      Left = 472
      Top = 137
      Width = 25
      Height = 15
      Caption = 'Total'
    end
    object lbl_total_pedido: TLabel
      Left = 321
      Top = 369
      Width = 103
      Height = 15
      Caption = 'Total do Pedido R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edt_produto: TEdit
      Left = 15
      Top = 156
      Width = 66
      Height = 23
      TabOrder = 0
      OnExit = edt_produtoExit
    end
    object edt_descricao_produto: TEdit
      Left = 87
      Top = 155
      Width = 242
      Height = 23
      Enabled = False
      TabOrder = 1
    end
    object edt_preco_venda: TEdit
      Left = 334
      Top = 155
      Width = 43
      Height = 23
      Enabled = False
      NumbersOnly = True
      TabOrder = 2
      Text = '0,00'
    end
    object edt_qtde: TEdit
      Left = 383
      Top = 155
      Width = 51
      Height = 23
      TabOrder = 3
      Text = '1'
    end
    object edt_total: TEdit
      Left = 440
      Top = 155
      Width = 57
      Height = 23
      Enabled = False
      TabOrder = 4
      Text = '0,00'
    end
    object btn_new_produto: TButton
      Left = 508
      Top = 153
      Width = 35
      Height = 25
      Hint = 'Novo pedido de venda'
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btn_new_produtoClick
    end
    object dbg_itens: TDBGrid
      Left = 15
      Top = 195
      Width = 528
      Height = 161
      DataSource = ds_itens
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object dbg_pedidos: TDBGrid
      Left = 15
      Top = 6
      Width = 528
      Height = 109
      DataSource = ds_pedidos
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = dbg_pedidosCellClick
    end
  end
  object ds_itens: TDataSource
    Left = 468
    Top = 304
  end
  object ds_pedidos: TDataSource
    Left = 468
    Top = 96
  end
end
