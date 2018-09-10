<%-- 
    Document   : tabela-price
    Created on : 02/09/2018, 00:42:45
    Author     : thiag
--%>
<%@page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela_price</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/Navegar.jspf" %>
        <h1>Cálculo financiamento price</h1>
        
        <form method="get">
            <h2>Digite o valor:</h2>
            <input type="number" name="valor"/><br>
            <%/*<h2>Digite o valor da entrada:</h2>
            <input type="number" name="entrada"/><br>*/%>
            <h2>Digite o número de prestações:</h2>
            <input type="number" name="prestacoes"/><br>
            <h2>Digite a taxa de juros (% ao mês):</h2>
            <input type="number" name="juros"/><br>
            <input type="submit" name="botao" value="Calcular"/>
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
        <table border="1">
            <tr>
                <td>Período</td>
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
            <%for (int i = 1; i <= parcelas; i++) {%>
            <tr>

                <td><%=i%></td>
                <td><%=df.format(valordaparcela)%></td>
                <%acparcela+= valordaparcela;%>
                
                <%valordojuros = saldodevedor*juros;%>
                <td><%=df.format(valordojuros)%></td>
                <%acjuros+= valordojuros;%>
                
                <%amortizacao= valordaparcela - valordojuros;%>
                <td><%=df.format(amortizacao)%></td>
                <%acamor+= amortizacao;%>
                
                <%saldodevedor= saldodevedor - amortizacao;%>
                <td><%=df.format(saldodevedor)%></td>
            </tr>
                
                    
            <%}%>
            <tr>
                <td>TOTAL</td>
                
                <td><%=df.format(acparcela)%></td>
                <td><%=df.format(acjuros)%></td>
                <td><%=df.format(acamor)%></td>
                <td>0.00</td>
              
            </tr>
        </table>
        
        <%}%>
    </body>
</html>
