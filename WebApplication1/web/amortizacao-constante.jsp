<%-- 
    Document   : amortizacao-constante
    Created on : 02/09/2018, 00:41:53
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
            <a href="amortizacao-constante.jsp">Amortização Constante</a>
        </div>

        <div class="panel-body">

            <table class="table">
                <thead>
                    <tr>
                        <th>Amortização Constante</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <p>Sistema de Amortização Constante (SAC) é uma forma de amortização de um empréstimo por prestações que incluem os juros, amortizando assim partes iguais do valor total do empréstimo.</p>
                        </td>
                    </tr>
                </tbody>
            </table>

            <form method="get">
                <div class="row">
                    <div class="col-md-4 col-xs-12">
                        <label>Valor</label>
                        <input maxlength="255" onKeyPress="return(money(this,event))" required type="text" class="form-control" name="valor" value="" />
                    </div>
                    <div class="col-md-4 col-xs-12">
                        <label>Nº de Prestações</label>
                        <input maxlength="255" required type="text" class="form-control maskNumber" name="pra" value="" />
                    </div>
                    <div class="col-md-4 col-xs-12">
                        <label>Taxa de juros (% ao mês)</label>
                        <input maxlength="255" required type="text" class="form-control maskNumber" name="por" value="" />
                    </div>
                </div>

                <hr>

                <div class="row">
                    <div class="col-md-12 col-xs-12 text-right">
                        <a href="home.jsp"><button type="button" class="btn btn-warning">Voltar</button></a>
                        <button type="submit" name="calcularAmortizacao" class="btn btn-primary">Calcular</button>
                    </div>
                </div>
            </form>

            <%
            if(request.getParameter("calcularAmortizacao")!=null){
                double valor = Double.parseDouble(request.getParameter("valor"));
                double pra = Double.parseDouble(request.getParameter("pra"));
                double por = Double.parseDouble(request.getParameter("por"));
                double porce=por/100;
                double amort = valor/pra;                                 
                double juros = (porce*valor);                
                double saldo = valor;
                double parcela = amort +(porce*valor);
                DecimalFormat df = new DecimalFormat("0.00");
                saldo = saldo-amort;
                double somaamo=0,somajur=0,somapar=0;
            %>
            <br>
            <table class="table content-right">
                <thead>
                    <tr>
                        <th width="40">#</th>
                        <th>Parcela</th>
                        <th>Amortizações</th>
                        <th>Juros</th>
                        <th>Saldo Devedor</th>                
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td><%= df.format(parcela) %></td>
                        <td><%= df.format(amort) %></td>
                        <td><%= df.format(juros) %></td>
                        <td><%= df.format(saldo) %></td>
                        <% 
                        somapar += parcela;
                        somaamo += amort;
                        somajur += juros; 
                        %>
                    </tr>
                     <% for(int l=2; l <= pra; l++){%>
                    <tr>
                        <%                        
                        juros = (porce*saldo);
                        saldo = saldo-amort;
                        parcela = amort+porce*(valor-(l-1)*amort);
                        %>
                        <td><%= l %></td>
                        <td><%= df.format(parcela) %></td>
                        <td><%= df.format(amort) %></td>
                        <td><%= df.format(juros) %></td>
                        <td><%= df.format(saldo) %></td>
                        <%
                        somapar += parcela;
                        somaamo += amort;
                        somajur += juros;
                        %>
                    </tr>
                    <%}%>
                </tbody>
                <tfoot>
                    <tr>
                        <td>TOTAL</td>
                        <td><%= df.format(somapar) %></td>
                        <td><%= df.format(somaamo) %></td>
                        <td><%= df.format(somajur) %></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
            <%}%>

        </div>
    </div>
</div>

<%@include file="WEB-INF/jspf/bottom.jspf" %>
