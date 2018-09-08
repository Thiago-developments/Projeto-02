<%-- 
    Document   : amortizacao-constante
    Created on : 02/09/2018, 00:41:53
    Author     : thiag
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização_constante</title>
    </head>
    <body>
        <h1>Amortização constante</h1>
    <form>
            <h1>Digite o valor:</h1>
            <input type="number" name="valor" id="valor"></br>
            <h1>Digite a quantidade de meses:</h1>
            <input type="number" name="pra" id="pra"></br>
            <h1>Digite porcentagem ao mês:</h1>
            <input type="numer" name="por" id="por"></br>
            <input type="submit" name="calcularAmortizacao" value="Calcular"/>
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
                DecimalFormat df = new DecimalFormat("0.##");
                saldo = saldo-amort;
                double somaamo=0,somajur=0,somapar=0;
                %>
                <table border="1">
            <tr>
                    <th>#</th>
                    <th>Parcela</th>
                    <th>Amortizações</th>
                    <th>Juros</th>
                    <th>Saldo Devedor</th>                
            </tr>
                    <td>1</td>
                    <td><%= df.format(parcela) %></td>
                    <td><%= df.format(amort) %></td>
                    <td><%= df.format(juros) %></td>
                    <td><%= df.format(saldo) %></td>
                    <% somapar += parcela;
                        somaamo += amort;
                        somajur += juros; %>
            <%
                for(int l=2; l <= pra; l++){%>
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
                        <% somapar += parcela;
                        somaamo += amort;
                        somajur += juros; %>
                    
                </tr>
            <%}%>
            <tr>
                    <td>Total--</td>
                    <td><%= df.format(somapar) %></td>
                    <td><%= df.format(somaamo) %></td>
                    <td><%= df.format(somajur) %></td>
                    <td>--Total</td>
                    
                </tr>
        </table>
        <%}%>
    </body>
</html>
