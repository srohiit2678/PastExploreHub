// Source code is decompiled from a .class file using FernFlower decompiler.
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserRegisterServlet extends HttpServlet {
   private String Load_Driver = "com.mysql.cj.jdbc.Driver";
   private String dbms_url = "jdbc:mysql://localhost:3306/ExploreHub?useSSL=false";
   private String dbms_user = "root";
   private String dbms_pass = "root";
   private String Register_query;

   public UserRegisterServlet() {
   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws IOException, ServletException {
      PrintWriter var3 = var2.getWriter();
      String var4 = var1.getParameter("name");
      String var5 = var1.getParameter("enroll_id");
      String var6 = var1.getParameter("email");
      int var7 = Integer.parseInt(var1.getParameter("department"));
      String var8 = var1.getParameter("type");
      String var9 = var1.getParameter("password");
      this.Register_query = "INSERT INTO Users (enroll_id, name, email, password, role, department_id) values ('" + var5 + "','" + var4 + "','" + var6 + "','" + var9 + "','" + var8 + "'," + var7 + ")";
      var3.println("<html><body>");

      try {
         Class.forName(this.Load_Driver);
         Connection var10 = DriverManager.getConnection(this.dbms_url, this.dbms_user, this.dbms_pass);
         Statement var11 = var10.createStatement();
         int var12 = var11.executeUpdate(this.Register_query);
         if (var12 != 0) {
            var3.println("<h1>register Successfully</h1>");
            var2.sendRedirect("login.html");
         } else {
            var3.println("<h1>Registeration Not Done Successfully</h1>");
         }

         var10.close();
      } catch (Exception var13) {
         var3.println(var13);
      }

   }
}
