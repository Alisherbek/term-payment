<%@page contentType="text/html" pageEncoding="UTF-8"%><%
%><%@page import="oracle.jdbc.OracleResultSet"%><%
%><%@page import="oracle.jdbc.OracleTypes"%><%
%><%@page import="oracle.jdbc.OracleCallableStatement"%><%
%><%@page import="java.sql.ResultSet"%><%
%><%@page import="java.sql.Statement"%><%
%><%@page import="test.JavaConnectDb"%><%
%><%@page import="java.sql.Connection"%><%
%><%@page import="java.util.Locale"%><%
%><%@page import="oracle.sql.ArrayDescriptor"%><%
%><%@page import="oracle.sql.ARRAY"%><%
%><%@page import="java.sql.SQLException"%><%
%><%@page import="java.sql.DatabaseMetaData;"%><%
    Connection conn = null;
    JavaConnectDb getConn = new JavaConnectDb();
    conn = getConn.getConnection();
    DatabaseMetaData dbmd = conn.getMetaData();
    out.print();
    if (conn == null) {
        %><script>
            alert('Not connection with data base');
          </script>
        <%        
    }
    Locale loc = null;
    Locale.setDefault(Locale.ENGLISH);
    ArrayDescriptor array_varchar2 = ArrayDescriptor.createDescriptor("ARRAY_VARCHAR2", conn);
    ArrayDescriptor array_number = ArrayDescriptor.createDescriptor("ARRAY_NUMBER", conn);
    OracleResultSet rs = null;
    //ArrayDescriptor array_date = ArrayDescriptor.createDescriptor("ARRAY_DATE", conn);
    //--save-------------        
    OracleCallableStatement cs1 = (OracleCallableStatement) conn.prepareCall("{call test}");
    if (request.getParameterValues("cd") != null) {
        //OracleCallableStatement cs = null;
        OracleCallableStatement cs = (OracleCallableStatement) conn.prepareCall("{call crm_api.Save_contract(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

        String prod[] = request.getParameterValues("prod");         
        String edizm[] = request.getParameterValues("edizm");         
        String col[] = request.getParameterValues("col");         
        String sen[] = request.getParameterValues("sen");         
        String per[] = request.getParameterValues("per");         
        String sum[] = request.getParameterValues("sum");         
        String stoim[] = request.getParameterValues("stoim");         
        String da1[] = request.getParameterValues("da1");         
        String raz[] = request.getParameterValues("raz");         

        cs.setString(1, request.getParameter("id"));
        cs.setString(2, request.getParameter("cd"));
        cs.setString(3, request.getParameter("fio"));
        cs.setString(4, request.getParameter("fname"));
        cs.setString(5, request.getParameter("post"));
        cs.setString(6, request.getParameter("snp"));
        cs.setString(7, request.getParameter("dp"));            
        cs.setString(8, request.getParameter("fio2"));
        cs.setString(9, request.getParameter("fio3"));
        cs.setString(10, request.getParameter("xxxx"));
        cs.setString(11, request.getParameter("csumm"));
        cs.setString(12, request.getParameter("bsumm"));
        cs.setString(13, request.getParameter("telc"));
        cs.setString(14, request.getParameter("addressc"));
        cs.setString(15, request.getParameter("adressf"));            
        cs.setString(16, request.getParameter("telf"));
        cs.setString(17, request.getParameter("faksf"));
        cs.setString(18, request.getParameter("acc"));
        cs.setString(19, request.getParameter("bank"));            
        cs.setInt(20, Integer.parseInt(request.getParameter("type_money")));            
        cs.setString(21, request.getParameter("iu"));            

        cs.setARRAY(22, new ARRAY(array_number, conn, prod));
        cs.setARRAY(23, new ARRAY(array_varchar2, conn, edizm));
        cs.setARRAY(24, new ARRAY(array_number, conn, col));
        cs.setARRAY(25, new ARRAY(array_number, conn, sen));
        cs.setARRAY(26, new ARRAY(array_number, conn, per));
        cs.setARRAY(27, new ARRAY(array_number, conn, sum));
        cs.setARRAY(28, new ARRAY(array_number, conn, stoim));           
        cs.setARRAY(29, new ARRAY(array_varchar2, conn, da1));
        cs.setARRAY(30, new ARRAY(array_number, conn, raz));
        cs.execute();
        response.sendRedirect("contracts.jsp");
    }
    //----edit---------------------------------------------------------------------        
        int type_c = 0;
        String where = "",t = "" ;
        String id = request.getParameter("id");
        String iu = request.getParameter("iu");
		
        id = (id==null)?"0":id;
        String contract_id = "";
        String contract_date = "";
        String customer_name1 = "";
        String cust_job_loc = "";
        String cust_job = "";
        String passport_number = "";
        String pass_issue_date = "";
        String customer_name2 = "";
        String customer_name3 = "";
        String xxxx = "";
        String contract_sum = "";
        String beginning_pay_sum = "";
        String telephon = "";
        String customer_adress = "";
        String address_cus_job_loc = "";
        String tel_cust_job_loc = "";
        String faks_cust_job_loc = "";
        String accaount = "";
        String bank = "";
        String total_pay = "";
        String remain_debt = "";
        int type_money ;        
        if (!id.equals("0")) {
            OracleCallableStatement cs = (OracleCallableStatement) conn.prepareCall("{ ? = call crm_api.contract_model(?)}");
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, Integer.parseInt(id));
            cs.execute();
            rs = (OracleResultSet) cs.getCursor(1);
            if (rs.next()) {            
                id = rs.getString(1);
                contract_date = rs.getString(2);
                customer_name1 = rs.getString(3);
                cust_job_loc = rs.getString(4);
                cust_job = rs.getString(5);
                passport_number = rs.getString(6);
                pass_issue_date = rs.getString(7);
                customer_name2 = rs.getString(8);
                customer_name3 = rs.getString(9);
                xxxx = rs.getString(10);
                contract_sum = rs.getString(11);
                beginning_pay_sum = rs.getString(12);
                telephon = rs.getString(13);
                customer_adress = rs.getString(14);
                address_cus_job_loc = rs.getString(15);
                tel_cust_job_loc = rs.getString(16);
                faks_cust_job_loc = rs.getString(17);
                accaount = rs.getString(18);
                bank = rs.getString(19);
                type_c = Integer.parseInt(rs.getString(20)) ;                 
            }
        }
        //else{
        //    type_c = Integer.parseInt(request.getParameter("type_c"));
        //}
    //-------------------------------------------------
    Statement stmt1 = conn.createStatement();
    Statement stmt2 = conn.createStatement();
    Statement stmt3 = conn.createStatement();
    Statement stmt4 = conn.createStatement();
        
    switch (type_c){
        case 1: where = "select * from rt_products_s_v"; t = "so`m"; type_money = 1; break;
        case 2: where = "select * from rt_products_$_v"; t = "$"; type_money = 2; break;
        case 3: where = "select * from rt_products_t_v"; t = "so`m"; type_money = 1; break;
        default: where = "select * from rt_products_s_v"; type_money = 1;
    }
//    ResultSet rs1 = stmt1.executeQuery("select * from rt_product_name_v");
		//ResultSet rs2 = stmt2.executeQuery(where); 	
		ResultSet rs3 = stmt3.executeQuery("select * from crm_con_pay_e_v t where t.contract_id = " + id);  
		ResultSet rs4 = stmt4.executeQuery("select * from crm_con_prod_e_v t where t.contract_id = " + id); 			
%>
<script>
var price = [], pname = [];
var prod = [], edizm = [], col = [], sen = [], per = [], sum = [],
    stoim = [], da1 = [], raz = [], pId = [];
    
function saveForm(){
    prod = [], edizm = [], col = [], sen = [], per = [], sum = [],
    stoim = [], da1 = [], raz = [];
    var el = fm.elements;
    var x = el.length, seq = 1;            
    for(var r = 0; r < x; r++){
        if(el[r].name == "prod"){
            if(el[r].value !=0){
                prod.push(el[r].value);                    
            }else{
//                        alert('tavarni tanlang!');
                break
            }
        }
        if(el[r].name == "edizm"){
            if(el[r].value != ""){
                edizm.push(el[r].value);
            }else{
                edizm.push('0');
            }
        }
        if(el[r].name == "col"){
            if(el[r].value != "" && el[r].value != 0){
                col.push(el[r].value);
            }else{
//                      alert('tavarni sonini kiriting!');
                break
            }
        }
        if(el[r].name == "sen"){
            if(el[r].value != ""){
               sen.push(el[r].value);
            }else{
//                    alert('tavarni summasini kiriting!');
                break
            }
        }
        if(el[r].name == "per"){
            per.push(el[r].value);
        }
        if(el[r].name == "sum"){
            sum.push(el[r].value);
        }
        if(el[r].name == "stoim"){
            if(el[r].value != ""){
                stoim.push(el[r].value);
            }else{
//                  alert('Umumiy summani kiriting!');
                break
            }
        }
        if(el[r].name == "da1"){                    
            if(el[r].value != ""){
                da1.push(el[r].value);  
            }else{
//                alert('To`lov muddatini kiriting!');
                break
            }
        }
        if(el[r].name == "raz"){                    
            if(el[r].value != ""){
                raz.push(el[r].value);  
            }else{
  //              alert('To`lov summasini kiriting!');
                break
            }
        }                
    }            
    if(prod.length !=0 && da1.length != 0 && raz.length != 0){
        if(prod.length == edizm.length && edizm.length == stoim.length && da1.length == raz.length)
          fm.submit();                                                                                           
		//alert(prod)
    }else{
        alert('Zaruriy malumotlar to`liq kiritilmagan!222');
    }
}
//-----------
function showRef(t) {	
	var r = window.showModalDialog("products.jsp?id="+t.id+"&type_c="+<%=type_c%>, "", "dialogWidth:800px;dialogHeight:500px");
	if (r != '' && r != undefined) {
		document.getElementById(r.elId).value = r.id;
		document.getElementById("prodN"+r.elId).value = r.p_n;
		document.getElementById("sen"+r.elId).value = r.p_p;
		document.getElementById("stoim"+r.elId).value = r.p_p;
	}
} 
function exit(){
    document.location.href = "contracts.jsp";
}
function sizePage(){
	var a = window.innerHeight, b = a-85;
	var c = b+"px";			
	document.getElementById("content").style.height = c;											
	alert('ok');
}
</script>        
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Elektron Tijorat</title>                        
        <link rel="stylesheet" href="../css/modal_c.css">
        <link rel="stylesheet" href="../css/main.css">
        <script src="../js/form.js"></script>
		<script src="../js/showModalDialog.js"></script>        
    </head>
    <style>
    .field {
      border: none;  
      font-size: 16px;
      background-color: #DDDDDD;
    }
    </style>
    <body style="background-color: #BDBDBD" onload="sizePage()">        
        <form action="contract.jsp" method="POST" name="fm" >
            <input name="save" value="Y" type="hidden">              
            <input name="type_money" value="<%=type_money%>" type="hidden">              
            <input name="type_c" value="<%=type_c%>" type="hidden">              
            <input name="iu" value="<%=iu%>" type="hidden">              
            <div id="myModal" class="modal1">
                <!-- Modal content -->
              <div class="modal-content" >                
                <div class="modal-header">
                  <span class="close" onclick="exit()">×</span>
                  <input value="Сохранить" type="submit" style="float:right; margin-top: 10px; margin-right: 20px" onclick="saveForm()"> 
                  <h2>Create Contract</h2>
                </div>
                <div class="modal-body">
                <table>
                    <tr>
                        <td><p align="right">ДОГОВОР №:</p></td>
                        <td><input type="number" max="10" min="1" name="id" value="<%=contract_id%>"><span style="float: right">data</span></td>
                        <td><input type="date" id="d" name="cd" value="<%=contract_date%>" required></td>
                    </tr>                          
                    <tr>
                        <td><p align="right">ФИО</p></td>
                        <td colspan="2"><input type="text" name="fio" size="50" <%=customer_name1%> required></td>                              
                    </tr>                          
                    <tr>
                        <td><p align="right">Места работа</p></td>
                        <td colspan="2"><input type="text" name="fname" size="50" required></td>                              
                    </tr>                          
                    <tr>
                        <td><p align="right">Должность</p></td>
                        <td colspan="2"><input type="text" name="post" size="30" required></td>                              
                    </tr>                          
                    <tr>
                        <td><p align="right">Паспорт серии</p></td>
                        <td><input type="text" name="snp" size=10  maxlength=9 required><span style="float: right">выдан</span></td>
                        <td><input type="date" name="dp" required></td>                              
                    </tr>                          
                    <tr>
                        <td><p align="right">"Покупатель" со второй стороны</p></td>
                        <td colspan="2"><input type="text" name="fio2" size="30" required></td>                              
                    <tr>
                        <td><p align="right">в лице Директора</p></td>
                        <td colspan="2"><input type="text" name="fio3" size="30" required></td>                              
                    </tr>                          
                    <tr>
                        <td><p align="right">действующего на основании</p></td>
                        <td colspan="2"><input type="text" name="xxxx" size="30" required></td>                              
                    </tr>                          
                    <tr>
                        <td colspan="3"><p align="center">ПРЕДМЕТ ДОГОВОРА</p></td>                              
                    </tr>                          
                    <tr>
                        <td colspan="3">
                            <table style="clear: both" id="tb">
                                <tr>
                                    <td rowspan="2"><p>№</p></td>                                          
                                    <td rowspan="2"><p>Наименование товаров</p></td>                                          
                                    <td rowspan="2"><p>Ед. изм.</p></td>                                          
                                    <td rowspan="2"><p>Кол-во</p></td>                                          
                                    <td rowspan="2"><p>Цена товара с<br> учетов<br> рассрочки</p></td>                                          
                                    <td colspan="2"><p align="center">НДС</p></td>                                          
                                    <td rowspan="2"><p>Стоимость поставки</p></td>                                          
                                    <td rowspan="2"><p>&nbsp;</p></td>                                          
                                </tr>
                                <tr>
                                    <td><p>%</p></td>                                          
                                    <td><p>Сумма</p></td>                                          
                                </tr>
                            <%if(!"0".equals(id)){
                                int count1 = 0;                            
                                while(rs4.next()){
                                String contract_products_id = rs4.getString(1);
                                String con_id               = rs4.getString(2);
                                String product_id           = rs4.getString(3);
                                String ed_izm               = rs4.getString(4);
								if("ed_izm".equals("-")){ed_izm="";}
                                String count                = rs4.getString(5);
                                String ras_sena             = rs4.getString(6);
                                String nds_foiz             = rs4.getString(7);
                                String nds_summa            = rs4.getString(8);
                                String stoimost_past        = rs4.getString(9);                                                                    
                            %>
                                <tr id="tr">
                                    <td>&nbsp;</td>
				    <td><input type="text" id="<%=count1%>" name="prod" size="2" ondblclick="showRef(this)" value="<%=product_id%>">&nbsp;<input  type="text" id="prodN<%=count1%>" name="prodN" size="13" value="<%=contract_products_id%>" readonly></td>
                                    <td><input type="text" id="ed" name="edizm" size="7" value="<%=ed_izm%>"></td>
                                    <td><input type="number" id="col<%=count1%>" name="col" size="3" value="1" onchange="colcal(this)" min="1" style="width: 50px" value="<%=count%>" required></td>
                                    <td><input type="number" id="sen<%=count1%>" name="sen" min="1" style="width: 100px" value="<%=ras_sena%>" readonly> <%=" "+t%></td>
                                    <td><input type="number" id="per<%=count1%>" name="per" size="3" min="1" onchange="percal(this)" value="<%=nds_foiz%>" style="width: 50px"></td>
                                    <td><input type="number" id="sum<%=count1%>" name="sum" size="3" min="1" style="width: 100px" value="<%=nds_summa%>" readonly><%=" "+t%></td>
                                    <td><input type="number" id="stoim<%=count1%>" name="stoim" size="15" min="1" style="width: 150px" readonly value="<%=stoimost_past%>" required><%=" "+t%></td>
                                    <td id="in"><input type="button" style="width: 25px" value="<%=(count1==0)?"+":"-"%>" title="<%=(count1==0)?"Add":"Delete"%>" onclick=<%=(count1==0)?"insDelCal(this)":"insDel(this)"%>>
                                                <!--input type="button" value="x" title="Clear" onclick="clean(t)"-->
                                    </td>
                                </tr>                            
                                <% count1++;}}else{%>
                                <tr id="tr">
                                    <td>&nbsp;</td>
				    <td><input type="text" id="0" name="prod" size="2" ondblclick="showRef(this)">&nbsp;<input  type="text" id="prodN0" name="prodN" size="13"  readonly></td>
                                    <td><input type="text" id="ed" name="edizm" size="7"></td>
                                    <td><input type="number" id="col0" name="col" size="3" value="1" onchange="colcal(this)" min="1" style="width: 50px" required></td>
                                    <td><input type="number" id="sen0" name="sen" min="1" style="width: 100px" readonly><%=" "+t%></td>
                                    <td><input type="number" id="per0" name="per" value="0" size="3" min="1" onchange="percal(this)" style="width: 50px"></td>
                                    <td><input type="number" id="sum0" name="sum" size="3" value="0" min="1" style="width: 100px" readonly><%=" "+t%></td>
                                    <td><input type="number" id="stoim0" name="stoim" size="15" min="1" style="width: 150px" readonly required><%=" "+t%></td>
                                    <td id="in"><input type="button" style="width: 25px" value="+" title="Add" onclick="insDelCal(this)">
                                                <!--input type="button" value="x" title="Clear" onclick="clean(t)"-->
                                    </td>
                                </tr>                            									
								<%}%>
                            </table>                                  
                        </td>                              
                    </tr>           
                    <tr>
                        <td colspan="3"><p align="center">ЦЕНА ДОГОВОРА</p></td>                              
                    </tr>                          
                    <tr>
                        <td><p align="center">договора составляет</p></td>                              
                        <td colspan="2"><input id="summa" name="csumm" type="text" size="15" readonly><%=" "+t%>
                        <input type="button" value="Get" onclick="calStoim()"></td>                              
                    </tr>   
                    <tr>
                        <td colspan="3"><p align="center">ПОРЯДОК РАСЧЕТОВ</p></td>                              
                    </tr>                          
                    <tr>
                          <td ><p align="center">первоначальной цены товаров</p></td>                              
                          <td colspan="2"><input id="perPl" name="bsumm" type="text" size="15" required><%=" "+t%></td>
                    </tr>   
                    <tr>
                        <td><p align="center">График рассроченной оплаты товаров: </p></td>
                        <td><input type="button" align="center" value="default/odatta" onclick="genDef()"></td>                              
                        <td>
                            <input type="number" id="sana" class="tooltip" style="width:50px" >&nbsp;&nbsp;&nbsp;sana&nbsp;&nbsp;&nbsp;
                            <input type="number" id="oy" style="width:50px">&nbsp;&nbsp;&nbsp;oyga&nbsp;&nbsp;&nbsp;
                            <input type="button" align="center" value="nodefaul/nooadatiy" onclick="custom()">                            
                        </td>                              
                    </tr>                          
                    <tr>
                        <td colspan="3">
                            <table id="tb1"> 
                                <tr>
                                <%int count1 = 0;
                                if(!"0".equals(id)){
                                    while(rs3.next()){
                                        String pid = rs3.getString(1);
                                        String pdate = rs3.getString(4);
                                        String psum = rs3.getString(5);                                                            
                                    %>							
                                    <td><input type="date" id="da1" name="da1" required value="<%=pdate%>"><span style="float: right">в размере</span></td>
                                    <td><input type="number" id="raz" name="raz" value="<%=psum%>" required><%=" "+t%></td>
                                    <td><input type="button" style="width: 25px" value="<%=(count1==0)?"+":"-"%>" title="<%=(count1==0)?"Add":"Delete"%>" onclick="insDel(this)"></td>
                                </tr> 
                                <%count1++;}}else{%>
                                    <td><input type="date" id="da1" name="da1" required><span style="float: right">в размере</span></td>
                                    <td><input type="number" id="raz" name="raz" required><%=" "+t%></td>
                                    <td><input type="button" style="width: 25px" value="<%=(count1==0)?"+":"-"%>" title="<%=(count1==0)?"Add":"Delete"%>" onclick="insDel(this)"></td>                                																	
                                </tr> 
								<%}%>                               
                            </table>
                        </td>
              </tr>
              <tr>
                  <td colspan="3"><p align="center">АДРЕСА И БАНКОВСКИЕ РЕКВИЗИТЫ СТОРОН</p></td>                                                          
              </tr>
              <tr>
                  <td ><p align="center">Телефон покупателя:</p></td>                  
                  <td colspan="2"><input type="text" id="phone" value="+998 " name="telc" maxlength="17" required onkeyup="myFunction2()"></td>
              </tr>
              <tr>
                  <td ><p align="center">адрес покупателя:</p></td>
                  <td colspan="2"><input type="text" name="addressc" maxlength="500" required></td>
              </tr>
              <tr>
                  <td ><p align="center">Адрес Работодателя:</p></td>
                  <td colspan="2"><input type="text" name="adressf" maxlength="500" required></td>
              </tr>
              <tr>
                  <td ><p align="center">Телефон Работодателя:</p></td>
                  <td colspan="2"><input type="text" id="phone" value="+998 " name="telf" maxlength="17" required onkeyup="myFunction2()"></td>
              </tr>
              <tr>
                  <td ><p align="center">Факс Работодателя:</p></td>
                  <td colspan="2"><input type="text" name="faksf" maxlength="18"></td>
              </tr>
              <tr>
                  <td ><p align="center">Расчетный счет №</p></td>
                  <td colspan="2"><input type="text" maxlength="20" name="acc" required></td>
              </tr>
              <tr>
                  <td ><p align="center">В банке</p></td>
                  <td colspan="2"><input type="text" name="bank" maxlength="200" required></td>
              </tr>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <h3>Modal Footer</h3>            
                  </div>
                 </form>
                </div>        
            </div>          
<script>
var _=document,j = 0, oz = true;           
window.onload = function () {            
    
    fm.id.value = '<%=id%>';
    fm.cd.value = '<%=contract_date%>';
    fm.fio.value = '<%=customer_name1%>';
    fm.fname.value = '<%=cust_job_loc%>';
    fm.post.value = '<%=cust_job%>';
    fm.snp.value = '<%=passport_number%>';
    fm.dp.value = '<%=pass_issue_date%>';
    fm.fio2.value = '<%=customer_name2%>';
    fm.fio3.value = '<%=customer_name3%>';
    fm.xxxx.value = '<%=xxxx%>';
    fm.csumm.value = '<%=contract_sum%>';
    fm.bsumm.value = '<%=beginning_pay_sum%>';
    fm.telc.value = '<%=telephon%>';
    fm.addressc.value = '<%=customer_adress%>';
    fm.adressf.value = '<%=address_cus_job_loc%>';
    fm.telf.value = '<%=tel_cust_job_loc%>';
    fm.faksf.value = '<%=faks_cust_job_loc%>';
    fm.acc.value = '<%=accaount%>';
    fm.bank.value = '<%=bank%>';
        
    for(var i = 1; i < pId.length; i++){
        _.getElementsByName("prod").value = pId[i];
    }

}            
function insDel(t){
    var td, td1, tr = t, table;
    if(t.value == "+"){
        t.value = "-";  
        t.title = "Delete";
        td = t.parentNode; 
        tr = td.parentNode.cloneNode(true);
        tr1 = td.parentNode;
        table =tr1.parentNode;
        table.appendChild(tr);           
        t.value = "+";
        t.title = "Add";
    }else{
        if (confirm('Siz haqiqatdan ham o`chirmoqchimisiz')){
            td = t.parentNode;
            tr = td.parentNode;
            table = tr.parentNode;            
            table.removeChild(tr);
            if(tr.name =="tr1"){
                i--;                
            }
        }
    }
}    
function colcal(t){    
    var idTek = t.id.substring(3), sen_i = "sen" + idTek, pSum = _.getElementById(sen_i).value, stoim_i = "stoim" + idTek,
	col = _.getElementById(t.id).value, per_i = "per" + idTek, sum_i ="sum" + idTek, sum_sum;   
	sum_sum = pSum * col * _.getElementById(per_i).value/100;
	_.getElementById(sum_i).value = sum_sum;
	_.getElementById(stoim_i).value = pSum * col + sum_sum;	
}
function percal(t){
    var idTek = t.id.substring(3),pid = _.getElementById(idTek).value, sen_susssm, sen_i = "sen" + idTek,
    per_i = "per" + idTek, per_sum, sum_i ="sum" + idTek, sum_sum, stoim_i = "stoim" + idTek, col_i = "col"+idTek;
	var col = _.getElementById(col_i).value;   
    if(pid !== "0"){        
        sen_sum = _.getElementById(sen_i).value;            
        per_sum = _.getElementById(per_i).value;
        sum_sum = sen_sum * per_sum /100 ;
        _.getElementById(sum_i).value = sum_sum;
        _.getElementById(stoim_i).value = col * sen_sum + sum_sum;        
    }
}
function insDelCal(t){
j++;
var input1, input2, input3, input4, input5, input6, input7, input8, input9,
    input10, td1, td2, td3, td4, td5, td6, td7, td8, td9, tr, table, 
    txt1 = _.createTextNode("<%=" "+t%>"), txt2 = _.createTextNode("<%=" "+t%>"),
    txt3 = _.createTextNode("<%=" "+t%>");
    td1 = _.createElement("td");	
    td2 = _.createElement("td");    
    input1 = _.createElement("input");    
	input1.id = j;
	input1.name = "prod";
	input1.style = "width: 45px;margin-right:5px";
	input1.type = "number";
	input1.ondblclick = function(){showRef(this)};
	td2.appendChild(input1);
    input2 = _.createElement("input");
	input2.name = "prodN";
	input2.id = "prodN"+j;
	input2.type = "text";
	input2.style = "width: 125px;";
	input2.readOnly = true;
    td2.appendChild(input2);
    input3 = _.createElement("input");
    input3.size = 7;        
    input3.id = "ed"+j;
    input3.name = "edizm";
    td3 = _.createElement("td");
    td3.appendChild(input3);
    input4 = _.createElement("input");
    input4.type = "number";
    input4.min = 1;
    input4.style = "width: 50px";
    input4.value = "1";
    input4.id = "col"+j;
    input4.name = "col";	
    input4.onchange=function(){colcal(this)};
    //input4.onkeydown=function(){colcal(this)};
    td4 = _.createElement("td");
    td4.appendChild(input4);
    input5 = _.createElement("input");     
    input5.style = "width: 100px";        
	input5.readOnly =true;
    input5.name = "sen";
    input5.id = "sen"+j;
    td5 = _.createElement("td");
    td5.appendChild(input5);        
    td5.appendChild(txt1);        
    input6 = _.createElement("input");
    input6.type = "number";
    input6.min = 0;
    input6.style = "width: 50px";
    input6.value = "0";
    input6.id = "per"+j;
    input6.name = "per";
    input6.onchange=function(){percal(this)};
    //input6.onkeydown=function(){percal(this)};
    td6 = _.createElement("td");
    td6.appendChild(input6);        
    input7 = _.createElement("input");
    input7.style = "width: 100px";                
    input7.name  = "sum";
    input7.id = "sum"+j;
    input7.readOnly = true;	
	input7.value = "0";
    td7 = _.createElement("td");
    td7.appendChild(input7);        
    td7.appendChild(txt2);        
    input8 = _.createElement("input");      
    input8.style = "width: 150px";
    input8.name = "stoim";
    input8.id = "stoim"+j;
    input8.readOnly = true;
    td8 = _.createElement("td");
    td8.appendChild(input8);
    td8.appendChild(txt3);
    input9 = _.createElement("input");
    input9.type = "button";
    input9.value = "-";
    input9.title = "Delete";        
    input9.style = "width: 25px";        
    input9.onclick=function(){insDel(this)};        
    td9 = _.createElement("td");
    td9.appendChild(input9);          
    tr = _.createElement("tr");
    tr.name = "tr1";
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);
    tr.appendChild(td5);
    tr.appendChild(td6);
    tr.appendChild(td7);
    tr.appendChild(td8);
    tr.appendChild(td9);
    table = _.getElementById("tb");
    table.appendChild(tr);        
}
function calStoim(){
    var sum = 0, stoim_i, val;
    for(var p = 0; p<=j; p++){
        stoim_i = "stoim" + p;
        val = _.getElementById(stoim_i).value;
        sum += val*1;
    }
    if (sum != 0){
        _.getElementById("summa").value = sum;
    }else {
        alert("заполняти предмет договора!");
    }
}
function genDate(t, o){ //to`lov sanasini aniqlaydigan fynk, t - to`lov tartibi, o to`lov oralig`i
    var d = new Date();
    var time = d.getTime(), npd = time + 86400000 * t * o;
    var nd = new Date(npd),	yyyy = nd.getFullYear(),
        mm = nd.getMonth()+1, dd = nd.getDate(),
        sana = yyyy + ((mm <= 9)?"-0":"-")+ mm + ((dd <= 9)?"-0":"-") + dd;
    return sana;
}
function genDateCus(t, kun){ //to`lov sanasini aniqlaydigan fynk, t - to`lov tartibi
    var d = new Date();
    var time = d.getTime(), npd = time + 86400000 * t * 31;
    var nd = new Date(npd),	yyyy = nd.getFullYear(),
        mm = nd.getMonth() + 1, dd = kun,
        sana = yyyy + ((mm <= 9)?"-0":"-")+ mm + ((dd <= 9)?"-0":"-") + dd;
    return sana;
}
function genDef(){
    if(oz){
        var x1 = _.getElementById("summa").value, x2 = _.getElementById("perPl").value,
                sum = (x1 - x2)/6;
        if(x1 !="" && x2 !=""){    
            var or = prompt("To`lovni oraliq muddatini kiriting!", "28"), k;
            _.getElementById("da1").value = genDate(1, or);
            _.getElementById("raz").value = Math.floor(sum);                               
            for (l = 2; l <  7; l++){               
                k = genDate(l, or);                
                def(l, sum, k);
            }
            oz = false;
        } else {
            alert("заполняти предмет договора!");
        }
    } else {
        var x1 = _.getElementById("summa").value, x2 = _.getElementById("perPl").value,
                sum = (x1 - x2)/6;
        if(x1 !="" && x2 !=""){    
            var or = prompt("To`lovni oraliq muddatini kiriting!", "28"), k;
            var tb = _.getElementById("tb1");
            for(l = 1; l < 6; l++){
                var ch = tb.lastChild;
                tb.removeChild(ch);
            }
            _.getElementById("da1").value = genDate(1, or);
            _.getElementById("raz").value = Math.floor(sum);                               
            for (l = 2; l <  7; l++){               
                //k = genDate(l, or);                
                def(l, sum, genDate(l, or));
            }
            oz = false;
        } else {
            alert("заполняти предмет договора!");
        }
        //------       
    }
}
function def(t, sum, d){   
    var  input2 = _.createElement("input"), input3 = _.createElement("input"), 
    input4 = _.createElement("input"), td1 = _.createElement("td"),
    td2 = _.createElement("td"), td3 = _.createElement("td"), 
    td4 = _.createElement("td"), tr = _.createElement("tr"),
    table = _.getElementById("tb1"), para = _.createElement("span"),
    node = _.createTextNode("в размере"),
    txt = _.createTextNode("<%=t%>");    
    para.style = "float: right";
    para.appendChild(node);        
    input2.type = "date";
    input2.value = d;
    input2.name = "da1";
    td2.appendChild(input2);
    td2.appendChild(para);
    input3.value = Math.floor(sum);
    input3.name = "raz";
    td3.appendChild(input3);
    td3.appendChild(txt);
    input4.type = "button";
    input4.value = "-";
    input4.title = "Delete";        
    input4.style = "width: 25px";        
    input4.onclick = function(){insDel(this)};        
    td4.appendChild(input4);    
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);            
    table.appendChild(tr);        
}
function custom(){
    if (oz){
        var x1 = _.getElementById("summa").value, x2 = _.getElementById("perPl").value,
            sana = _.getElementById("sana").value, oy = _.getElementById("oy").value;
        if(x1 != "" && x2 != ""){
            if(sana != "" && oy != ""){
				if(sana>28){alert('sana 29 dan kichik bo`lishi kerak!!!');return}
                var sum = (x1 - x2) / oy;                        
                _.getElementById("da1").value = genDateCus(1, sana);
                _.getElementById("raz").value = Math.floor(sum);
                for (l = 2; l <= oy; l++){               
                    def(l, sum, genDateCus(l, sana));
                }
            oz = false;    
            } else {
                alert('kun va oyni kiriting!');                
            }        
        } else {
           alert("заполняти предмет договора!"); 
        }         
    }    
}
function myFunction2(){
  var son = '+0123456789 ';
  var input = document.getElementById("phone");
  var text = input.value;
  var len = text.length;
  var curLetter = text.substr(len-1,1);
  if(son.match(curLetter) == null){
    input.value = text.substr(0,len-1);    
  }
  if(len == 4 || len == 7 || len == 11 || len == 14){
    input.value = text + ' ';
  }
  if(len < 6){
    input.value = '+998 ';
  }  
}
</script>
    </body>      
</html>