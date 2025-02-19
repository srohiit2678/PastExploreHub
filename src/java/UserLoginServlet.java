// Source code is decompiled from a .class file using FernFlower decompiler.
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLoginServlet extends HttpServlet {
   private String Load_Driver = "com.mysql.cj.jdbc.Driver";
   private String dbms_url = "jdbc:mysql://localhost:3306/ExploreHub?useSSL=false";
   private String dbms_user = "root";
   private String dbms_pass = "root";
   private String login_query;

   public UserLoginServlet() {
   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws IOException, ServletException {
      PrintWriter var3 = var2.getWriter();
      String var4 = var1.getParameter("userid");
      String var5 = var1.getParameter("password");
      this.login_query = "select * from users where enroll_id='" + var4 + "' and password='" + var5 + "'";
      var3.println("<html><body>");

      try {
         Class.forName(this.Load_Driver);
         Connection var6 = DriverManager.getConnection(this.dbms_url, this.dbms_user, this.dbms_pass);
         Statement var7 = var6.createStatement();
         ResultSet var8 = var7.executeQuery(this.login_query);
         if (var8.next()) {
            var3.println("<h1>Welcome to home</h1>");
            var2.sendRedirect("Main.html");
         }
      } catch (Exception var9) {
         var3.println(var9);
      }

      var3.println("</body></html>");
      var3.close();
   }
}
