unit Unit_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, uDm, Data.Win.ADODB;

type
  TFrm_Principal = class(TForm)
    Panel1: TPanel;
    pnlProdutos: TPanel;
    pnlVenda: TPanel;
    lblTitulo: TLabel;
    lblProdutos: TLabel;
    edtPesq: TEdit;
    dbgProdutos: TDBGrid;
    lblVendas: TLabel;
    lblDataHora: TLabel;
    pnlCarrinho: TPanel;
    pnlPagamento: TPanel;
    bbtnAdicionar: TBitBtn;
    bbtnRemover: TBitBtn;
    bbtnRegistro: TBitBtn;
    lbledtCodigo: TLabeledEdit;
    lbledtQuantidade: TLabeledEdit;
    pnlTotalCarrinho: TPanel;
    lblTotal: TLabel;
    lblValorTotal: TLabel;
    rdgFormaPagamento: TRadioGroup;
    bbtnFinalizarCompra: TBitBtn;
    bbtnCancelarCompra: TBitBtn;
    lbledtValorDinheiro: TLabeledEdit;
    lbledtCliente: TLabeledEdit;
    lblTroco: TLabel;
    lblValorTroco: TLabel;
    sgdCarrinho: TStringGrid;
    qryProdutos: TADOQuery;
    DtProdutos: TDataSource;
    TimerData: TTimer;
    pnlCadastro: TPanel;
    lblCadastro: TLabel;
    lbldbedtProdCodigo: TDBLabeledEdit;
    lbldbedtProdDescricao: TDBLabeledEdit;
    lbldbedtProdValor: TDBLabeledEdit;
    lbldbedtProdQuantidade: TDBLabeledEdit;
    lbldbedtProdTipo: TDBLabeledEdit;
    bbtnNovo: TBitBtn;
    bbtnEditar: TBitBtn;
    bbtnSalvar: TBitBtn;
    bbtnCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure TimerDataTimer(Sender: TObject);
    procedure edtPesqKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnNovoClick(Sender: TObject);
    procedure bbtnEditarClick(Sender: TObject);
    procedure bbtnSalvarClick(Sender: TObject);
    procedure bbtnCancelarClick(Sender: TObject);
    procedure qryProdutosBeforePost(DataSet: TDataSet);
    procedure qryProdutosAfterOpen(DataSet: TDataSet);
    procedure DtProdutosStateChange(Sender: TObject);
    procedure bbtnRegistroClick(Sender: TObject);
    procedure rdgFormaPagamentoClick(Sender: TObject);
    procedure bbtnAdicionarClick(Sender: TObject);
    procedure DeletarItem(Grid: TStringGrid; RowNumber: Integer);
    procedure bbtnRemoverClick(Sender: TObject);
    procedure lbledtValorDinheiroKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnFinalizarCompraClick(Sender: TObject);
    procedure bbtnCancelarCompraClick(Sender: TObject);
  private
    { Private declarations }
    FFmt: TFormatSettings;
    function TotalCarrinho: Double;
    procedure AtualizarTotal;
    procedure AtualizaTroco;
    function FormatarMoeda(Valor: Double): string;
    function FormaPagamentoBanco: string;
    function GerarCupom(NumeroVenda: Integer; const Cliente: string; DataVenda: TDateTime;
      Recebido, Troco: Currency): string;
    procedure MostrarCupom(const Cupom: string);
    procedure LimparVenda;
    procedure AtualizaVendas;
  public
    { Public declarations }
  end;

var
  Frm_Principal: TFrm_Principal;

implementation

{$R *.dfm}

const
  LARGURA_CUPOM    = 40;
  NOME_PADARIA     = 'Padaria Gosto de Matéria';
  ENDERECO_PADARIA = 'Rua dos Padeiros Galaticos, 9000 - Centro';
  PAGTO_DINHEIRO   = 0;

function Centralizar(const Texto: string): string;
begin
  if Length(Texto) >= LARGURA_CUPOM then
    Result := Copy(Texto, 1, LARGURA_CUPOM)
  else
    Result := StringOfChar(' ', (LARGURA_CUPOM - Length(Texto)) div 2) + Texto;
end;

function Colunas(const Esquerda, Direita: string): string;
var
  Espacos: Integer;
begin
  Espacos := LARGURA_CUPOM - Length(Esquerda) - Length(Direita);
  if Espacos < 1 then
    Espacos := 1;
  Result := Esquerda + StringOfChar(' ', Espacos) + Direita;
end;

procedure TFrm_Principal.edtPesqKeyPress(Sender: TObject; var Key: Char);
var
  Pesquisa: string;
  Codigo: Integer;
begin
  if Key <> #13 then
    Exit;

  Key := #0;

  Pesquisa := Trim(edtPesq.Text);

  qryProdutos.Close;
  qryProdutos.SQL.Clear;

  if Pesquisa = '' then
    qryProdutos.SQL.Add('select * from estoque')
  else if TryStrToInt(Pesquisa, Codigo) then
  begin
    qryProdutos.SQL.Add('select * from estoque where codigo = :codigo or descricao like :descricao');
    qryProdutos.Parameters.ParamByName('codigo').Value := Codigo;
    qryProdutos.Parameters.ParamByName('descricao').Value := '%' + Pesquisa + '%';
  end
  else
  begin
    qryProdutos.SQL.Add('select * from estoque where descricao like :descricao');
    qryProdutos.Parameters.ParamByName('descricao').Value := '%' + Pesquisa + '%';
  end;

  qryProdutos.Open;
end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin

  FFmt := TFormatSettings.Create('pt-BR');

  sgdCarrinho.Cells[0,0] := 'Código';
  sgdCarrinho.Cells[1,0] := 'Produto';
  sgdCarrinho.Cells[2,0] := 'Tipo';
  sgdCarrinho.Cells[3,0] := 'Quantidade';
  sgdCarrinho.Cells[4,0] := 'Valor';

  sgdCarrinho.ColWidths[0] := 120;
  sgdCarrinho.ColWidths[1] := 300;
  sgdCarrinho.ColWidths[2] := 60;
  sgdCarrinho.ColWidths[3] := 90;
  sgdCarrinho.ColWidths[4] := 60;

  qryProdutos.Open;
  AtualizaVendas;
end;

procedure TFrm_Principal.lbledtValorDinheiroKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key <> #13 then
    Exit;

  Key := #0;
  AtualizaTroco;
end;

procedure TFrm_Principal.TimerDataTimer(Sender: TObject);
begin
  lblDataHora.Caption := FormatDateTime('dd/mm/yyyy  hh:nn:ss', Now, FFmt);
end;



{ ---------- Cadastro de produtos ---------- }

procedure TFrm_Principal.bbtnNovoClick(Sender: TObject);
begin
  qryProdutos.Append;
  lbldbedtProdDescricao.SetFocus;
end;

procedure TFrm_Principal.bbtnEditarClick(Sender: TObject);
begin
  if qryProdutos.IsEmpty then
  begin
    ShowMessage('Selecione um produto na lista para editar.');
    Exit;
  end;

  qryProdutos.Edit;
  lbldbedtProdDescricao.SetFocus;
end;

procedure TFrm_Principal.bbtnSalvarClick(Sender: TObject);
begin
  qryProdutos.Post;
  ShowMessage('Produto salvo com sucesso!');
end;

procedure TFrm_Principal.AtualizaTroco;
var
  Recebido, Troco: Double;
begin
  if not TryStrToFloat(StringReplace(Trim(lbledtValorDinheiro.Text), '.', ',', [rfReplaceAll]), Recebido, FFmt) then
  begin
    ShowMessage('Informe um valor recebido válido.');
    lbledtValorDinheiro.SetFocus;
    Exit;
  end;

  Troco := Recebido - TotalCarrinho;

  if Troco < 0 then
    ShowMessage('Valor recebido é menor que o total da compra.')
  else
    lblValorTroco.Caption := 'R$ ' + FormatFloat('#,##0.00', Troco, FFmt);
end;

procedure TFrm_Principal.AtualizaVendas;
var
  qryVendasCount: TADOQuery;
begin
  qryVendasCount := TADOQuery.Create(nil);
  try
    qryVendasCount.Connection := DataModule1.ADOConnection1;

    qryVendasCount.SQL.Add('select count(*) as VendasHoje from vendas');
    qryVendasCount.SQL.Add('WHERE data_venda >= CAST(GETDATE() AS DATE)');
    qryVendasCount.SQL.Add('AND data_venda <  DATEADD(DAY, 1, CAST(GETDATE() AS DATE))');
    qryVendasCount.Open;

    lblVendas.Caption := 'Vendas de hoje: ' + qryVendasCount.FieldByName('VendasHoje').AsString;

  finally
    qryVendasCount.Free;
  end;
end;

procedure TFrm_Principal.bbtnAdicionarClick(Sender: TObject);
var
  qryAdicionarCarrinho: TADOQuery;
  NovaLinha: Integer;
  Quantidade: Double;
begin
  if not TryStrToFloat(StringReplace(Trim(lbledtQuantidade.Text), '.', ',', [rfReplaceAll]), Quantidade, FFmt)
     or (Quantidade <= 0) then
  begin
    ShowMessage('Informe uma quantidade válida.');
    lbledtQuantidade.SetFocus;
    Exit;
  end;

  qryAdicionarCarrinho := TADOQuery.Create(nil);
  try
    qryAdicionarCarrinho.Connection := DataModule1.ADOConnection1;

    qryAdicionarCarrinho.SQL.Add('SELECT codigo, descricao, tipo_produto, quantidade, valor');
    qryAdicionarCarrinho.SQL.Add('FROM estoque');
    qryAdicionarCarrinho.SQL.Add('WHERE codigo = :codigo');
    qryAdicionarCarrinho.Parameters.ParamByName('codigo').Value := Trim(lbledtCodigo.Text);
    qryAdicionarCarrinho.Open;

    if qryAdicionarCarrinho.IsEmpty then
    begin
      ShowMessage('Produto não encontrado.');
      lbledtCodigo.SetFocus;
      Exit;
    end;

    if sgdCarrinho.Cells[0, 1] = '' then
      NovaLinha := 1
    else
    begin
      sgdCarrinho.RowCount := sgdCarrinho.RowCount + 1;
      NovaLinha := sgdCarrinho.RowCount - 1;
    end;

    sgdCarrinho.Cells[0, NovaLinha] := qryAdicionarCarrinho.FieldByName('codigo').AsString;
    sgdCarrinho.Cells[1, NovaLinha] := qryAdicionarCarrinho.FieldByName('descricao').AsString;
    sgdCarrinho.Cells[2, NovaLinha] := qryAdicionarCarrinho.FieldByName('tipo_produto').AsString;
    sgdCarrinho.Cells[3, NovaLinha] := FormatFloat('0.###', Quantidade, FFmt);
    sgdCarrinho.Cells[4, NovaLinha] := FormatFloat('0.00',
      qryAdicionarCarrinho.FieldByName('valor').AsFloat * Quantidade, FFmt);

    AtualizarTotal;

  finally
    qryAdicionarCarrinho.Free;
  end;
end;

procedure TFrm_Principal.bbtnCancelarClick(Sender: TObject);
begin
  qryProdutos.Cancel;
end;

procedure TFrm_Principal.qryProdutosBeforePost(DataSet: TDataSet);
var
  Tipo: string;
begin
  if Trim(DataSet.FieldByName('descricao').AsString) = '' then
  begin
    lbldbedtProdDescricao.SetFocus;
    raise Exception.Create('Informe a descrição do produto.');
  end;

  Tipo := UpperCase(Trim(DataSet.FieldByName('tipo_produto').AsString));
  if (Tipo <> 'UN') and (Tipo <> 'KG') then
  begin
    lbldbedtProdTipo.SetFocus;
    raise Exception.Create('O tipo do produto deve ser UN ou KG.');
  end;

  DataSet.FieldByName('tipo_produto').AsString := Tipo;
end;

procedure TFrm_Principal.rdgFormaPagamentoClick(Sender: TObject);
begin
  if rdgFormaPagamento.ItemIndex = 0 then
  begin
    lbledtValorDinheiro.Enabled := True;
    lblValorTroco.Enabled := True;
    lblTroco.Enabled := True;
  end
  else
  begin
    lbledtValorDinheiro.Enabled := False;
    lblValorTroco.Enabled := False;
    lblTroco.Enabled := False;
  end;


end;

procedure TFrm_Principal.DeletarItem(Grid: TStringGrid; RowNumber: Integer);
var
  i: Integer;
begin
  if (RowNumber < 1) or (RowNumber >= Grid.RowCount) then
    Exit;

  if Grid.RowCount = 2 then
  Grid.Rows[1].Clear
  else if RowNumber = Grid.RowCount - 1 then
    Grid.RowCount := Grid.RowCount - 1
  else
  begin
    for i := RowNumber to Grid.RowCount - 2 do
      Grid.Rows[i] := Grid.Rows[i + 1];
    Grid.RowCount := Grid.RowCount - 1;
  end;

  AtualizarTotal;
end;

procedure TFrm_Principal.DtProdutosStateChange(Sender: TObject);
var
  Editando: Boolean;
begin
  Editando := qryProdutos.State in [dsEdit, dsInsert];

  bbtnNovo.Enabled     := not Editando;
  bbtnEditar.Enabled   := (not Editando) and qryProdutos.Active and (not qryProdutos.IsEmpty);
  bbtnSalvar.Enabled   := Editando;
  bbtnCancelar.Enabled := Editando;

  edtPesq.Enabled     := not Editando;
  dbgProdutos.Enabled := not Editando;
end;

procedure TFrm_Principal.bbtnRegistroClick(Sender: TObject);
begin
  if pnlCadastro.Visible then
  begin

    if qryProdutos.State in [dsEdit, dsInsert] then
      qryProdutos.Cancel;

    pnlCadastro.Visible := False;
    bbtnRegistro.Caption := 'Registrar / Alterar';
  end
  else
  begin
    pnlCadastro.Top := bbtnRegistro.Top - 1;
    pnlCadastro.Visible := True;
    bbtnRegistro.Caption := 'Fechar cadastro';
  end;
end;

procedure TFrm_Principal.bbtnRemoverClick(Sender: TObject);
begin
  if sgdCarrinho.RowCount > 1 then
    DeletarItem(sgdCarrinho, sgdCarrinho.Row);
end;

function TFrm_Principal.TotalCarrinho: Double;
var
  Linha: Integer;
begin
  Result := 0;
  for Linha := 1 to sgdCarrinho.RowCount - 1 do
    Result := Result + StrToFloatDef(sgdCarrinho.Cells[4, Linha], 0, FFmt);
end;

procedure TFrm_Principal.AtualizarTotal;
begin
  lblValorTotal.Caption := 'R$ ' + FormatFloat('#,##0.00', TotalCarrinho, FFmt);
end;

procedure TFrm_Principal.qryProdutosAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('codigo').DisplayWidth       := 3;
  DataSet.FieldByName('descricao').DisplayWidth    := 18;
  DataSet.FieldByName('valor').DisplayWidth        := 6;
  DataSet.FieldByName('quantidade').DisplayWidth   := 8;
  DataSet.FieldByName('tipo_produto').DisplayWidth := 2;
end;

{ ---------- Finalizar venda ---------- }

function TFrm_Principal.FormatarMoeda(Valor: Double): string;
begin
  Result := 'R$ ' + FormatFloat('#,##0.00', Valor, FFmt);
end;

function TFrm_Principal.FormaPagamentoBanco: string;
begin
  case rdgFormaPagamento.ItemIndex of
    0: Result := 'Dinheiro';
    1: Result := 'PIX';
    2: Result := 'Cartão Crédito';
    3: Result := 'Cartão Débito';
  else
    Result := '';
  end;
end;

function TFrm_Principal.GerarCupom(NumeroVenda: Integer; const Cliente: string;
  DataVenda: TDateTime; Recebido, Troco: Currency): string;
var
  L: TStringList;
  Linha: Integer;
  Qtd, TotalItem: Double;
begin
  L := TStringList.Create;
  try
    L.Add(StringOfChar('=', LARGURA_CUPOM));
    L.Add(Centralizar(NOME_PADARIA));
    L.Add(Centralizar(ENDERECO_PADARIA));
    L.Add(StringOfChar('=', LARGURA_CUPOM));
    L.Add(Centralizar('*** CUPOM NÃO FISCAL ***'));
    L.Add(Colunas(Format('Venda nº %.6d', [NumeroVenda]),
      FormatDateTime('dd/mm/yyyy hh:nn', DataVenda, FFmt)));
    L.Add(Copy('Cliente: ' + Cliente, 1, LARGURA_CUPOM));
    L.Add(StringOfChar('-', LARGURA_CUPOM));

    for Linha := 1 to sgdCarrinho.RowCount - 1 do
    begin
      if sgdCarrinho.Cells[0, Linha] = '' then
        Continue;

      Qtd       := StrToFloat(sgdCarrinho.Cells[3, Linha], FFmt);
      TotalItem := StrToFloat(sgdCarrinho.Cells[4, Linha], FFmt);

      L.Add(Copy(Format('%.3d %s', [StrToInt(sgdCarrinho.Cells[0, Linha]),
        sgdCarrinho.Cells[1, Linha]]), 1, LARGURA_CUPOM));
      L.Add(Colunas(Format('    %s %s x %s', [sgdCarrinho.Cells[3, Linha],
        sgdCarrinho.Cells[2, Linha], FormatarMoeda(TotalItem / Qtd)]),
        FormatarMoeda(TotalItem)));
    end;

    L.Add(StringOfChar('-', LARGURA_CUPOM));
    L.Add(Colunas('TOTAL', FormatarMoeda(TotalCarrinho)));
    L.Add(Colunas('Pagamento', rdgFormaPagamento.Items[rdgFormaPagamento.ItemIndex]));
    if rdgFormaPagamento.ItemIndex = PAGTO_DINHEIRO then
    begin
      L.Add(Colunas('Valor recebido', FormatarMoeda(Recebido)));
      L.Add(Colunas('Troco', FormatarMoeda(Troco)));
    end;
    L.Add(StringOfChar('=', LARGURA_CUPOM));
    L.Add(Centralizar('Obrigado e volte sempre!'));

    Result := L.Text;
  finally
    L.Free;
  end;
end;

procedure TFrm_Principal.MostrarCupom(const Cupom: string);
var
  F: TForm;
  Memo: TMemo;
  Botao: TButton;
begin
  F := TForm.Create(nil);
  try
    F.Caption := 'Cupom da venda';
    F.BorderStyle := bsDialog;
    F.Position := poMainFormCenter;
    F.ClientWidth := 420;
    F.ClientHeight := 520;

    Botao := TButton.Create(F);
    Botao.Parent := F;
    Botao.Align := alBottom;
    Botao.Height := 34;
    Botao.Caption := 'Fechar';
    Botao.ModalResult := mrOk;
    Botao.Default := True;

    Memo := TMemo.Create(F);
    Memo.Parent := F;
    Memo.Align := alClient;
    Memo.ReadOnly := True;
    Memo.ScrollBars := ssVertical;
    Memo.Font.Name := 'Courier New';
    Memo.Font.Size := 10;
    Memo.Lines.Text := Cupom;

    F.ShowModal;
  finally
    F.Free;
  end;
end;

procedure TFrm_Principal.LimparVenda;
begin
  sgdCarrinho.RowCount := 2;
  sgdCarrinho.Rows[1].Clear;
  AtualizarTotal;

  rdgFormaPagamento.ItemIndex := -1;
  rdgFormaPagamentoClick(nil);
  lbledtValorDinheiro.Clear;
  lblValorTroco.Caption := 'R$ 0,00';
  lbledtCliente.Clear;
  lbledtCodigo.Clear;
  lbledtQuantidade.Clear;
end;

procedure TFrm_Principal.bbtnCancelarCompraClick(Sender: TObject);
begin
  if MessageDlg('Cancelar a compra e limpar o carrinho?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    LimparVenda;
end;

procedure TFrm_Principal.bbtnFinalizarCompraClick(Sender: TObject);
var
  qry: TADOQuery;
  Total, Recebido, Troco: Currency;
  ValorDigitado: Double;
  Cliente, Cupom: string;
  NumeroVenda, Linha: Integer;
  DataVenda: TDateTime;
begin
  { ---------- validações ---------- }
  if sgdCarrinho.Cells[0, 1] = '' then
  begin
    ShowMessage('O carrinho está vazio.');
    Exit;
  end;

  if rdgFormaPagamento.ItemIndex < 0 then
  begin
    ShowMessage('Selecione a forma de pagamento.');
    Exit;
  end;

  Total    := TotalCarrinho;
  Recebido := Total;
  Troco    := 0;

  if rdgFormaPagamento.ItemIndex = PAGTO_DINHEIRO then
  begin
    if not TryStrToFloat(StringReplace(Trim(lbledtValorDinheiro.Text), '.', ',', [rfReplaceAll]),
                         ValorDigitado, FFmt) then
    begin
      ShowMessage('Informe o valor recebido em dinheiro.');
      lbledtValorDinheiro.SetFocus;
      Exit;
    end;

    Recebido := ValorDigitado;
    if Recebido < Total then
    begin
      ShowMessage('Valor recebido é menor que o total da compra.');
      lbledtValorDinheiro.SetFocus;
      Exit;
    end;

    Troco := Recebido - Total;
    lblValorTroco.Caption := FormatarMoeda(Troco);
  end;

  Cliente := Trim(lbledtCliente.Text);
  if Cliente = '' then
    Cliente := 'CONSUMIDOR FINAL';

  if MessageDlg('Finalizar a venda de ' + FormatarMoeda(Total) + '?',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  DataVenda := Now;
  qry := TADOQuery.Create(nil);
  try
    qry.Connection := DataModule1.ADOConnection1;
    DataModule1.ADOConnection1.BeginTrans;
    try
      for Linha := 1 to sgdCarrinho.RowCount - 1 do
      begin
        if sgdCarrinho.Cells[0, Linha] = '' then
          Continue;

        qry.SQL.Text :=
          'UPDATE estoque SET quantidade = quantidade - :qtd ' +
          'WHERE codigo = :codigo AND quantidade >= :qtd_minima';
        qry.Parameters.ParamByName('qtd').Value        := StrToFloat(sgdCarrinho.Cells[3, Linha], FFmt);
        qry.Parameters.ParamByName('codigo').Value     := StrToInt(sgdCarrinho.Cells[0, Linha]);
        qry.Parameters.ParamByName('qtd_minima').Value := StrToFloat(sgdCarrinho.Cells[3, Linha], FFmt);

        if qry.ExecSQL = 0 then
          raise Exception.CreateFmt('Estoque insuficiente para "%s".', [sgdCarrinho.Cells[1, Linha]]);
      end;

      qry.SQL.Text :=
        'INSERT INTO VENDAS (forma_pagamento, valor_compra, cliente, cupom_fiscal, data_venda, troco) ' +
        'OUTPUT INSERTED.codigo ' +
        'VALUES (:forma, :valor, :cliente, '''', :data, :troco)';
      qry.Parameters.ParamByName('forma').Value   := FormaPagamentoBanco;
      qry.Parameters.ParamByName('valor').Value   := Total;
      qry.Parameters.ParamByName('cliente').Value := Cliente;
      qry.Parameters.ParamByName('data').Value    := DataVenda;
      qry.Parameters.ParamByName('troco').Value   := Troco;
      qry.Open;
      NumeroVenda := qry.Fields[0].AsInteger;
      qry.Close;

      Cupom := GerarCupom(NumeroVenda, Cliente, DataVenda, Recebido, Troco);
      qry.SQL.Text := 'UPDATE VENDAS SET cupom_fiscal = :cupom WHERE codigo = :codigo';
      qry.Parameters.ParamByName('cupom').DataType := ftMemo;
      qry.Parameters.ParamByName('cupom').Value    := Cupom;
      qry.Parameters.ParamByName('codigo').Value   := NumeroVenda;
      qry.ExecSQL;

      DataModule1.ADOConnection1.CommitTrans;
    except
      DataModule1.ADOConnection1.RollbackTrans;
      raise;
    end;
  finally
    qry.Free;
  end;

  MostrarCupom(Cupom);
  LimparVenda;

  if qryProdutos.State = dsBrowse then
    qryProdutos.Requery;

  AtualizaVendas
end;

end.
