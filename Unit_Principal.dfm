object Frm_Principal: TFrm_Principal
  Left = 0
  Top = 0
  Caption = 'Vendas Padaria'
  ClientHeight = 690
  ClientWidth = 1034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1034
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Color = 7080252
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1032
    object lblTitulo: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 326
      Height = 51
      Align = alLeft
      Alignment = taCenter
      Caption = 'Padaria Gosto de mat'#233'ria'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 37
    end
    object lblVendas: TLabel
      AlignWithMargins = True
      Left = 335
      Top = 3
      Width = 515
      Height = 51
      Align = alClient
      Alignment = taCenter
      Caption = 'Vendas de hoje: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 164
      ExplicitHeight = 30
    end
    object lblDataHora: TLabel
      AlignWithMargins = True
      Left = 856
      Top = 3
      Width = 175
      Height = 51
      Align = alRight
      Caption = '00/00/000 00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 30
    end
  end
  object pnlProdutos: TPanel
    Left = 0
    Top = 57
    Width = 369
    Height = 633
    Align = alLeft
    TabOrder = 1
    ExplicitHeight = 625
    object lblProdutos: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 11
      Width = 361
      Height = 30
      Margins.Top = 10
      Align = alTop
      Caption = 'Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 90
    end
    object edtPesq: TEdit
      AlignWithMargins = True
      Left = 4
      Top = 54
      Width = 361
      Height = 23
      Margins.Top = 10
      Align = alTop
      TabOrder = 0
      TextHint = 'Pesquise c'#243'digo ou descri'#231#227'o do produto'
      OnKeyPress = edtPesqKeyPress
    end
    object dbgProdutos: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 83
      Width = 361
      Height = 333
      Align = alClient
      DataSource = DtProdutos
      DrawingStyle = gdsGradient
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object pnlCadastro: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 422
      Width = 361
      Height = 176
      Align = alBottom
      BevelOuter = bvLowered
      ShowCaption = False
      TabOrder = 3
      Visible = False
      ExplicitTop = 414
      object lblCadastro: TLabel
        Left = 12
        Top = 6
        Width = 151
        Height = 20
        Caption = 'Cadastro de produtos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbldbedtProdCodigo: TDBLabeledEdit
        Left = 12
        Top = 48
        Width = 70
        Height = 23
        TabStop = False
        Color = clBtnFace
        DataField = 'codigo'
        DataSource = DtProdutos
        ReadOnly = True
        TabOrder = 4
        EditLabel.Width = 42
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo:'
      end
      object lbldbedtProdDescricao: TDBLabeledEdit
        Left = 92
        Top = 48
        Width = 257
        Height = 23
        DataField = 'descricao'
        DataSource = DtProdutos
        TabOrder = 0
        EditLabel.Width = 54
        EditLabel.Height = 15
        EditLabel.Caption = 'Descri'#231#227'o:'
      end
      object lbldbedtProdValor: TDBLabeledEdit
        Left = 12
        Top = 100
        Width = 100
        Height = 23
        DataField = 'valor'
        DataSource = DtProdutos
        TabOrder = 1
        EditLabel.Width = 29
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor:'
      end
      object lbldbedtProdQuantidade: TDBLabeledEdit
        Left = 124
        Top = 100
        Width = 100
        Height = 23
        DataField = 'quantidade'
        DataSource = DtProdutos
        TabOrder = 2
        EditLabel.Width = 65
        EditLabel.Height = 15
        EditLabel.Caption = 'Quantidade:'
      end
      object lbldbedtProdTipo: TDBLabeledEdit
        Left = 236
        Top = 100
        Width = 113
        Height = 23
        CharCase = ecUpperCase
        DataField = 'tipo_produto'
        DataSource = DtProdutos
        TabOrder = 3
        TextHint = 'UN ou KG'
        EditLabel.Width = 27
        EditLabel.Height = 15
        EditLabel.Caption = 'Tipo:'
      end
      object bbtnNovo: TBitBtn
        Left = 12
        Top = 140
        Width = 80
        Height = 25
        Caption = 'Novo produto'
        TabOrder = 5
        OnClick = bbtnNovoClick
      end
      object bbtnEditar: TBitBtn
        Left = 98
        Top = 140
        Width = 80
        Height = 25
        Caption = 'Editar produto'
        TabOrder = 6
        OnClick = bbtnEditarClick
      end
      object bbtnSalvar: TBitBtn
        Left = 184
        Top = 140
        Width = 80
        Height = 25
        Caption = 'Salvar'
        Enabled = False
        TabOrder = 7
        OnClick = bbtnSalvarClick
      end
      object bbtnCancelar: TBitBtn
        Left = 270
        Top = 140
        Width = 79
        Height = 25
        Caption = 'Cancelar'
        Enabled = False
        TabOrder = 8
        OnClick = bbtnCancelarClick
      end
    end
    object bbtnRegistro: TBitBtn
      AlignWithMargins = True
      Left = 4
      Top = 604
      Width = 361
      Height = 25
      Align = alBottom
      Caption = 'Registrar / Alterar'
      TabOrder = 2
      OnClick = bbtnRegistroClick
      ExplicitTop = 596
    end
  end
  object pnlVenda: TPanel
    Left = 369
    Top = 57
    Width = 665
    Height = 633
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 663
    ExplicitHeight = 625
    object pnlCarrinho: TPanel
      Left = 0
      Top = 0
      Width = 665
      Height = 393
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 663
      object bbtnAdicionar: TBitBtn
        Left = 302
        Top = 32
        Width = 120
        Height = 23
        Caption = 'Adicionar'
        TabOrder = 0
        OnClick = bbtnAdicionarClick
      end
      object bbtnRemover: TBitBtn
        Left = 428
        Top = 32
        Width = 120
        Height = 23
        Caption = 'Remover item'
        TabOrder = 1
        OnClick = bbtnRemoverClick
      end
      object lbledtCodigo: TLabeledEdit
        Left = 16
        Top = 32
        Width = 121
        Height = 23
        EditLabel.Width = 41
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo:'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        TabOrder = 2
        Text = ''
      end
      object lbledtQuantidade: TLabeledEdit
        Left = 160
        Top = 32
        Width = 121
        Height = 23
        EditLabel.Width = 67
        EditLabel.Height = 15
        EditLabel.Caption = 'Quantidade:'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        Text = ''
        TextHint = 'UN = 1  /  KG = 1,000'
      end
      object sgdCarrinho: TStringGrid
        Left = 16
        Top = 72
        Width = 641
        Height = 315
        FixedCols = 0
        RowCount = 2
        TabOrder = 4
      end
    end
    object pnlPagamento: TPanel
      Left = 0
      Top = 393
      Width = 665
      Height = 240
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 663
      ExplicitHeight = 232
      object lblTroco: TLabel
        Left = 202
        Top = 144
        Width = 55
        Height = 30
        Caption = 'Troco:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblValorTroco: TLabel
        Left = 265
        Top = 142
        Width = 96
        Height = 37
        Alignment = taCenter
        Caption = 'R$ 0,00'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clCrimson
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlTotalCarrinho: TPanel
        Left = 1
        Top = 1
        Width = 663
        Height = 72
        Align = alTop
        BevelOuter = bvNone
        Color = clGreen
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 661
        object lblTotal: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 3
          Width = 63
          Height = 66
          Margins.Left = 10
          Align = alLeft
          Alignment = taCenter
          Caption = 'Total:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 32
        end
        object lblValorTotal: TLabel
          AlignWithMargins = True
          Left = 79
          Top = 3
          Width = 554
          Height = 66
          Margins.Right = 30
          Align = alClient
          Alignment = taRightJustify
          Caption = 'R$ 0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 537
          ExplicitWidth = 96
          ExplicitHeight = 37
        end
      end
      object rdgFormaPagamento: TRadioGroup
        Left = 16
        Top = 83
        Width = 169
        Height = 153
        Caption = 'Forma de Pagamento'
        Items.Strings = (
          'Dinheiro'
          'PIX'
          'Cart'#227'o de Cr'#233'dito'
          'Cart'#227'o de D'#233'bito')
        TabOrder = 1
        OnClick = rdgFormaPagamentoClick
      end
      object bbtnFinalizarCompra: TBitBtn
        Left = 376
        Top = 83
        Width = 281
        Height = 86
        Caption = 'Finalizar compra'
        TabOrder = 2
        OnClick = bbtnFinalizarCompraClick
      end
      object bbtnCancelarCompra: TBitBtn
        Left = 376
        Top = 174
        Width = 281
        Height = 59
        Caption = 'Cancelar compra'
        TabOrder = 3
        OnClick = bbtnCancelarCompraClick
      end
      object lbledtValorDinheiro: TLabeledEdit
        Left = 202
        Top = 101
        Width = 123
        Height = 23
        EditLabel.Width = 78
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor recebido:'
        Enabled = False
        TabOrder = 4
        Text = ''
        OnKeyPress = lbledtValorDinheiroKeyPress
      end
      object lbledtCliente: TLabeledEdit
        Left = 202
        Top = 205
        Width = 160
        Height = 23
        EditLabel.Width = 40
        EditLabel.Height = 15
        EditLabel.Caption = 'Cliente:'
        MaxLength = 150
        TabOrder = 5
        Text = ''
        TextHint = 'CONSUMIDOR FINAL'
      end
    end
  end
  object qryProdutos: TADOQuery
    Connection = DataModule1.ADOConnection1
    CursorType = ctStatic
    AfterOpen = qryProdutosAfterOpen
    BeforePost = qryProdutosBeforePost
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from estoque')
    Left = 112
    Top = 265
  end
  object DtProdutos: TDataSource
    AutoEdit = False
    DataSet = qryProdutos
    OnStateChange = DtProdutosStateChange
    Left = 32
    Top = 265
  end
  object TimerData: TTimer
    OnTimer = TimerDataTimer
    Left = 1000
    Top = 56
  end
end
