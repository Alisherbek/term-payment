<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="test.JavaConnectDb"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Locale"%>
<%@page import="oracle.jdbc.OracleResultSet"%>
<%@page import="oracle.jdbc.OracleTypes"%>
<%@page import="oracle.jdbc.OracleCallableStatement"%>
<%
//  String x=request.getParameter("o");  
//    out.print(x);
    Locale loc = null;
    Locale.setDefault(Locale.ENGLISH);
    Connection conn = null;
    JavaConnectDb getConn = new JavaConnectDb();
    conn = getConn.getConnection();
    if (conn == null) {
        %><script>alert('Not connection with data base');</script><%        
    }
    OracleResultSet rs = null;
    if (request.getParameter("username") != null&&request.getParameter("password")!=null) {
        OracleCallableStatement cs = (OracleCallableStatement) conn.prepareCall("{ ? = call adm_setup.logon(?,?)}");
        cs.registerOutParameter(1, OracleTypes.VARCHAR);
        cs.setString(2, request.getParameter("username"));
        cs.setString(3, request.getParameter("password"));        
        cs.execute();
        String user=cs.getString(1);
        if(user==null){
            %><script>alert('Parol yoki login xato');</script><%        
        }else{
        //out.print("<h1 STYLE='color: red'>Parol yoki login xato</h1>");
            response.sendRedirect("main.jsp?user="+user);
        }
    }

%>
<!DOCTYPE html>
<html lang="en" class="bg-dark">
  <head>
    <meta charset="utf-8" />
    <title>CP</title>
    <link rel="stylesheet" href="css/layout.css" type="text/css" />    
    <!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->
    <script language="JavaScript">         
    function checkUser(fm) {
        if (fm.username.value == ""&&fm.password.value == ""){
          alert("ILTIMOS LOGIN  VA PAROLINGIZNI KIRITING!");
          }
          if (fm.username.value != ""&&fm.password.value == ""){
          alert("ILTIMOS PAROLINGIZNI KIRITING!");
          }
          if (fm.username.value == ""&&fm.password.value != ""){
          alert("ILTIMOS LOGINNI KIRITING!");
          }
          if(fm.username.value != ""&&fm.password.value != "") { 
        //   document.location.href = "ED.jsp";//?id=" + id + "&iud=U";
          fm.submit();
        }
        }
</script>
  </head>
  <body>
	<center><h2 style="color:red">Программa для учета </h2></center>
	<center><h2 style="color:white" >продаж в рассрочку</h2></center>
      <div class="container aside-xxl"> 		
        <section class="panel panel-default m-t-lg bg-white">
          <header class="panel-heading text-center">
            <strong>Login</strong>
          </header>
          <form action="index.jsp" class="panel-body wrapper-lg" name="fm">
            <div class="form-group">
              <label class="control-label">Name</label>
              <input type="text" placeholder="login" class="form-control input-lg" name="username"> </div>
              <div class="form-group">
              <label class="control-label">password</label>
              <input type="password" id="inputpassword" placeholder="password" class="form-control input-lg" name="password"> </div>
              <button onclick="checkUser(this.form)" >Enter</button>
          </form>
        </section>
      </div>
    </section>    
  </body>
</html>