<%-- 
    Document   : tabela-price
    Created on : 02/09/2018, 00:42:45
    Author     : thiag
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/jspf/top.jspf" %>
<%@include file="WEB-INF/jspf/menu.jspf" %>

<div class="col-md-8">
    <div class="panel panel-default">
        <div class="panel-heading font-weight-bold">
            <a href="home.jsp">Home</a> / 
            <a href="tabela-price.jsp">Tabela Price</a>
        </div>

        <div class="panel-body">

            <table class="table">
                <thead>
                    <tr>
                        <th>Tabela Price</th>
                    </tr>
                </thead>
            </table>
        
            <form method="get">
                <div class="row">
                    <div class="col-md-4 col-xs-12">
                        <label>Valor</label>
                        <input maxlength="255" onKeyPress="return(money(this,event))" required type="text" class="form-control" name="valor" value="" />
                    </div>
                    <div class="col-md-4 col-xs-12">
                        <label>Nº de Prestações</label>
                        <input maxlength="255" required type="text" class="form-control maskNumber" name="prestacoes" value="" />
                    </div>
                    <div class="col-md-4 col-xs-12">
                        <label>Taxa de juros (% ao mês)</label>
                        <input maxlength="255" required type="text" class="form-control maskNumber" name="juros" value="" />
                    </div>
                </div>

                <hr>

                <div class="row">
                    <div class="col-md-12 col-xs-12 text-right">
                        <a href="home.jsp"><button type="button" class="btn btn-warning">Voltar</button></a>
                        <button type="submit" name="botao" class="btn btn-primary">Calcular</button>
                    </div>
                </div>
            </form>

            <%if (request.getParameter("botao")!= null){
                double valor = Double.parseDouble(request.getParameter("valor"));
                /*double entrada = Double.parseDouble(request.getParameter("entrada"));*/
                double saldodevedor = valor ;
                double parcelas = Double.parseDouble(request.getParameter("prestacoes"));
                double juros = Double.parseDouble(request.getParameter("juros"));
                juros = juros/100 ;
                double valordojuros ;double amortizacao;
                double valordaparcela = valor*(((Math.pow(1+juros, parcelas))*juros)/((Math.pow(1+juros, parcelas))-1));
                double acamor = 0;double acjuros =0;double acparcela =0;
                DecimalFormat df = new DecimalFormat("0.00");
            %>
            <br>
            <table class="table content-right">
                <thead>
                    <tr>
                        <td width="40">Período</td>
                        <td>Prestação</td>
                        <td>Juros</td>
                        <td>Amortização</td>
                        <td>Saldo devedor</td>
                    </tr>
                    <tr>
                        <td>0</td>
                        <td>0.00</td>
                        <td>0.00</td>
                        <td>0.00</td>
                        <td><%=df.format(valor)%></td>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 1; i <= parcelas; i++) { 
                        acparcela   += valordaparcela;
                        valordojuros = saldodevedor*juros;
                        acjuros     += valordojuros;
                        amortizacao  = valordaparcela - valordojuros;
                        acamor      += amortizacao;
                        saldodevedor = saldodevedor - amortizacao;
                    %>
                    <tr>
                        <td><%=i%></td>
                        <td><%=df.format(valordaparcela)%></td>
                        <td><%=df.format(valordojuros)%></td>
                        <td><%=df.format(amortizacao)%></td>
                        <td><%=df.format(saldodevedor)%></td>
                    </tr>
                <%}%>
                <tfoot>
                    <tr>
                        <td>TOTAL</td>
                        <td><%=df.format(acparcela)%></td>
                        <td><%=df.format(acjuros)%></td>
                        <td><%=df.format(acamor)%></td>
                        <td>0.00</td>
                    </tr>
                </tfoot>
            </table>
            <%}%>

        </div>
    </div>
</div>

<%@include file="WEB-INF/jspf/bottom.jspf" %>
