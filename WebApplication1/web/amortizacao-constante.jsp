<%-- 
    Document   : amortizacao-constante
    Created on : 02/09/2018, 00:41:53
    Author     : thiag
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização_constante</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/Navegar.jspf" %>
        <h1>Amortização constante</h1>
    <form>
            <h1>Digite o valor:</h1>
            <input type="text" name="valor" id="valor"></br>
            <h1>Digite a quantidade de meses:</h1>
            <input type="text" name="pra" id="pra"></br>
            <h1>Digite porcentagem ao mês:</h1>
            <input type="text" name="por" id="por"></br>
            <input type="submit" name="calcularAmortizacao" value="Calcular"/>
        </form>        
        <%
            if(request.getParameter("calcularAmortizacao")!=null){
                int valor = Integer.parseInt(request.getParameter("valor"));
                int pra = Integer.parseInt(request.getParameter("pra"));
                int por = Integer.parseInt(request.getParameter("por"));
                int amort = valor/pra;                                 
                int juros = ((por/100)*valor);
                %>
                <table border="1">
            <tr>
                <%
                    int colunas=5;
                    for(int c=1; c<=colunas; c++){%>
                    <th>#</th>
                    <th>Parcela</th>
                    <th>Amortizações</th>
                    <th>Juros</th>
                    <th>Saldo Devedor</th>
                <%}%>
            </tr>
            <%
                for(int l=1; l<=pra; l++){%>
                <tr>
                    <%                  
                    for(int c=1; c<=colunas; c++){
                    int parcela = amort +(juros*valor);%>
                    <td><%= pra %></td>
                    <td><%= parcela %></td>
                    <td><%= amort %></td>
                    <td><%= juros %></td>
                    <%
                    juros = ((por/100)*valor-l*amort);    
                    } 
                    %>
                </tr>
            <%}%>
        </table>
        <%}%>
    </body>
</html>
